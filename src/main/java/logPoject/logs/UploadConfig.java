package logPoject.logs;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

@Configuration

public class UploadConfig implements WebMvcConfigurer {
    @Bean
    MappingJackson2JsonView jsonView() {

        return new MappingJackson2JsonView();
    }
}
