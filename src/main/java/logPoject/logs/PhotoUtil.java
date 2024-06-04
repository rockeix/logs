package logPoject.logs;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Comparator;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class PhotoUtil {

    private final String UPLOAD_DIR = "/uploads/";
    private final String TEMP_DIR = "/temp/";
    private final String TEMP_DIRDelete = "src/main/webapp/temp";

    // public String upload(MultipartHttpServletRequest request) {
    //     MultipartFile uploadFile = request.getFile("upload");

    //     String fileName = getFileName(uploadFile);
    //     String uploadPath = getPath(request, UPLOAD_DIR) + fileName;
    //     uploadFile(uploadPath, uploadFile);

    //     return request.getContextPath() + UPLOAD_DIR + fileName;
    // }

    public String tempUpload(MultipartHttpServletRequest request) {
        MultipartFile uploadFile = request.getFile("upload");

        String fileName = getFileName(uploadFile);
        String tempPath = getPath(request, TEMP_DIR) + fileName;
        uploadFile(tempPath, uploadFile);

        // 웹 접근 가능한 경로 반환
        return request.getContextPath() + TEMP_DIR + fileName;
    }

    public void moveFileToUploadDir(String tempFilePath) throws IOException {
        Path tempPath = Paths.get(tempFilePath);
        Path uploadPath = Paths.get(tempFilePath.replace(TEMP_DIR, UPLOAD_DIR));

        Files.createDirectories(uploadPath.getParent());
        Files.move(tempPath, uploadPath);
    }

    public void deleteTempFolder() throws IOException {

        Path tempFolder = Paths.get(TEMP_DIRDelete);
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

    // public void deleteTempFile(String tempFilePath) throws IOException {
    //     Path tempPath = Paths.get(tempFilePath);
    //     Files.deleteIfExists(tempPath);
    // }

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