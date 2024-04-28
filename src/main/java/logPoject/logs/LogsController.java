package logPoject.logs;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RestController;

@Controller
public class LogsController {

     @RequestMapping("/index2")
	    public String index2page() {
	        return "index2";
	    }
	 @RequestMapping(value = "/index2", method = RequestMethod.POST)
    public String index2page(@RequestParam("content") String content, Model model) {
        model.addAttribute("content", content); // 사용자가 입력한 내용을 모델에 추가하여 전달
        return "index2"; // 입력된 내용을 처리할 페이지로 이동
    }
}
