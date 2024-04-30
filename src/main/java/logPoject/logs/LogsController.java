package logPoject.logs;

import logPoject.logs.DTO.LogsDTO;
import logPoject.logs.Service.LogsService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/logs")
public class LogsController {

    private final LogsService logsService;

    public LogsController(LogsService logsService) {
        this.logsService = logsService;
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
}
