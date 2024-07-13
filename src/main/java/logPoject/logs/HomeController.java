package logPoject.logs;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class HomeController {
    
    @GetMapping("/")
    public String index2() {
        return "index2";
    }

    @GetMapping("/Write")
    public String index() {
        return "index";
    }
    
}
