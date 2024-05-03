package logPoject.logs;

import logPoject.logs.DTO.LogsDTO;
import logPoject.logs.Service.LogsService;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/logs")
public class LogsController {

    private final LogsService logsService;

    public LogsController(LogsService logsService) {
        this.logsService = logsService;
    }

    @RequestMapping("/index2")
    public ModelAndView index2() {
        ModelAndView modelAndView = new ModelAndView("index2"); // ModelAndView 객체를 생성하고 "index2"를 설정
        return modelAndView; // "index2.jsp"로 이동하도록 ModelAndView 객체 반환
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

    @GetMapping("/all")
    public ResponseEntity<List<LogsDTO>> getAllPosts() {
        List<LogsDTO> allPosts = logsService.getAllPosts();
        return ResponseEntity.ok().body(allPosts);
    }
}
