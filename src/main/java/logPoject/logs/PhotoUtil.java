package logPoject.logs;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Comparator;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component
public class PhotoUtil {

    @Value("${file.temp-dir:/temp/}")
    private String tempDir;

    @Value("${file.temp-dir-delete:src/main/webapp/temp}")
    private String tempDirDelete;

    @Value("${file.uploadDirMove:src/main/webapp/upload/}")
    private String uploadDirMove;

    @Value("${file.tempDirMove:src/main/webapp/temp/}")
    private String tempDirMove;

    public String tempUpload(MultipartHttpServletRequest request) {
        MultipartFile uploadFile = request.getFile("upload");

        String fileName = getFileName(uploadFile);
        String tempPath = getPath(request, tempDir) + fileName;
        uploadFile(tempPath, uploadFile);

        // 웹 접근 가능한 경로 반환
        return request.getContextPath() + tempDir + fileName;
    }

    public boolean moveFile(String fileName) {
        try {
            Files.move(Paths.get(tempDirMove + fileName),
                       Paths.get(uploadDirMove + fileName),
                       StandardCopyOption.REPLACE_EXISTING);
            return true;
        } catch (IOException e) {
            return false;
        }
    }

    public void deleteTempFolder() throws IOException {

        Path tempFolder = Paths.get(tempDirDelete);
        if (Files.exists(tempFolder)) {
            Files.walk(tempFolder)
                .sorted(Comparator.reverseOrder())
                .map(Path::toFile)
                .forEach(file -> {
                    System.out.println("Deleting: " + file.getAbsolutePath());
                    file.delete();
                });
        }
    }

    private void uploadFile(String savePath, MultipartFile uploadFile) {
        try {
            File file = new File(savePath);
            if (!file.exists()) {
                file.mkdirs();
            }
            uploadFile.transferTo(file);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private String getFileName(MultipartFile uploadFile) {
        String originalFileName = uploadFile.getOriginalFilename();
        if (originalFileName == null || originalFileName.isEmpty()) {
            return UUID.randomUUID().toString() + ".txt"; // 확장자 지정
        }
        String ext = originalFileName.substring(originalFileName.lastIndexOf(".")); // 확장자 확인
        return UUID.randomUUID() + ext;
    }

    private String getPath(MultipartHttpServletRequest request, String directory) {
        String rootPath = request.getServletContext().getRealPath("/");
        if (!directory.startsWith("/")) {
            directory = "/" + directory;
        }
        String path = rootPath + directory;
        File dir = new File(path);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        return path;
    }
}