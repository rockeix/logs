package logPoject.logs;

import logPoject.logs.DTO.LogsDTO;
import logPoject.logs.DTO.LogsComentDTO;
import logPoject.logs.Service.LogsService;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import java.io.IOException;

@RestController
@RequestMapping("/logs")
public class LogsController {
    @Autowired
    public PhotoUtil photoUtil;
    @Autowired
    private final LogsService logsService;
    @Autowired
    private final BCryptPasswordEncoder passwordEncoder;

    public LogsController(LogsService logsService, BCryptPasswordEncoder passwordEncoder) {
        this.logsService = logsService;
        this.passwordEncoder = passwordEncoder;
    }

    @RequestMapping("/index2")
    public ModelAndView index2() {
        ModelAndView modelAndView = new ModelAndView("index2");
        return modelAndView;
    }

    @PostMapping("/save")
    public ResponseEntity<?> savePost(@RequestBody LogsDTO logsDTO) {
        try {
            logsService.savePost(logsDTO);
            return ResponseEntity.ok().body("Post saved successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error saving post");
        }
    }

    @PostMapping("/moveFiles")
    public ResponseEntity<String> moveFiles(@RequestBody List<String> fileNames) {
        for (String fileName : fileNames) {
            boolean result = photoUtil.moveFile(fileName);
            if (!result) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("파일 이동에 실패했습니다: " + fileName);
            }
        }
        return ResponseEntity.ok("모든 파일이 성공적으로 이동되었습니다.");
    }

    @PostMapping("/temp")
    public ModelAndView tempUpload(MultipartHttpServletRequest request) {
        ModelAndView mav = new ModelAndView("jsonView");

        String tempPath = photoUtil.tempUpload(request);

        mav.addObject("uploaded", true);
        mav.addObject("url", tempPath);
        return mav;
    }

    @PostMapping("/cleanup")
    public ResponseEntity<String> cleanupTempFolder() {
        try {
            photoUtil.deleteTempFolder();
            return ResponseEntity.ok("임시 폴더를 성공적으로 정리했습니다.");
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("임시 폴더 정리 중 오류가 발생했습니다.");
        }
    }

    @GetMapping("/all")
    public ResponseEntity<List<LogsDTO>> getAllPosts() {
        List<LogsDTO> allPosts = logsService.getAllPosts();
        return ResponseEntity.ok().body(allPosts);
    }

    @GetMapping("/Nos")
    public ResponseEntity<List<LogsDTO>> getNos(@RequestParam Long postNo) {
        List<LogsDTO> Nos = logsService.getNos(postNo);
        return ResponseEntity.ok().body(Nos);
    }

    @GetMapping("/Clist")
    ResponseEntity<List<LogsComentDTO>> getClist(@RequestParam Long postNo) {
        List<LogsComentDTO> Clist = logsService.getClist(postNo);
        return ResponseEntity.ok().body(Clist);
    }

    @GetMapping("/index3")
    public ModelAndView index3(@RequestParam("postNo") String postNo) {
        ModelAndView modelAndView = new ModelAndView("index3");
        modelAndView.addObject("postNo", postNo);
        return modelAndView;
    }

    @PostMapping("/write")
    public ResponseEntity<?> writeComent(@RequestBody LogsComentDTO logsComentDTO) {
        try {
            logsService.writeComent(logsComentDTO);
            return ResponseEntity.ok().body("Post saved successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error saving post");
        }
    }

    @GetMapping("/Pon")
    public ResponseEntity<List<LogsDTO>> getPoName(@RequestParam String search) {
        List<LogsDTO> Pon = logsService.getPoName(search);
        return ResponseEntity.ok().body(Pon);
    }

    @RequestMapping("/search")
    public ModelAndView search() {
        ModelAndView modelAndView = new ModelAndView("search");
        return modelAndView;
    }

    @PostMapping("/update")
    public ResponseEntity<?> deleteComent(@RequestBody LogsComentDTO logsComentDTO) {
        try {
            logsService.deleteComent(logsComentDTO);
            return ResponseEntity.ok().body("Post saved successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error saving post");
        }
    }

    @PostMapping("/verify")
    public ResponseEntity<?> verify(@RequestBody Map<String, String> request) {
        String comentNo = request.get("comentNo");
        String comentPW = request.get("comentPW");

        List<LogsComentDTO> result = logsService.verify(comentNo);
        if (!result.isEmpty() && passwordEncoder.matches(comentPW, result.get(0).getcomentPW())) {
            return ResponseEntity.ok(Collections.singletonMap("valid", true));
        } else {
            return ResponseEntity.ok(Collections.singletonMap("valid", false));
        }
    }

}