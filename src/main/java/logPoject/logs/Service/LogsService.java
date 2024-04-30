package logPoject.logs.Service;

import logPoject.logs.DTO.LogsDTO;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class LogsService implements LogsServiceInterface {
    private final JdbcTemplate jdbcTemplate;

    public LogsService(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void savePost(LogsDTO logsDTO) {
        String sql = "INSERT INTO post (postName, postContent, userNickname, userPW) VALUES (?, ?, ?, ?)";
        
        jdbcTemplate.update(sql, logsDTO.getPostName(), logsDTO.getPostContent(), logsDTO.getUserNickname(), logsDTO.getUserPW());
    }
}
