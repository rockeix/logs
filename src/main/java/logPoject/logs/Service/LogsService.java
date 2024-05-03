package logPoject.logs.Service;

import logPoject.logs.DTO.LogsDTO;

import java.util.List;

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
        String sql = "INSERT INTO post (postName, postContent, userNickname, userPW, postIMG) VALUES (?, ?, ?, ?, ?)";

        jdbcTemplate.update(sql, logsDTO.getPostName(), logsDTO.getPostContent(), logsDTO.getUserNickname(),
                logsDTO.getUserPW(), logsDTO.getPostIMG());
    }

    @Override
    public List<LogsDTO> getAllPosts() {
        String sql = "SELECT postName, postContent, userNickname, postIMG FROM post";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            LogsDTO logsDTO = new LogsDTO();
            logsDTO.setPostName(rs.getString("postName"));
            logsDTO.setPostContent(rs.getString("postContent"));
            logsDTO.setUserNickname(rs.getString("userNickname"));
            logsDTO.setPostIMG(rs.getString("postIMG"));
            return logsDTO;
        });
    }
}
