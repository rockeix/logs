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

    public List<LogsDTO> getNos(Long postNo) {
        String sql = "SELECT postNo, postName, postContent, userNickname, postIMG FROM post WHERE postNo = ?";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            LogsDTO logsDTO = new LogsDTO();
            logsDTO.setPostNo(rs.getString("postNo"));
            logsDTO.setPostName(rs.getString("postName"));
            logsDTO.setPostContent(rs.getString("postContent"));
            logsDTO.setUserNickname(rs.getString("userNickname"));
            logsDTO.setPostIMG(rs.getString("postIMG"));
            return logsDTO;
        }, postNo);
    }

    @Override
    public void savePost(LogsDTO logsDTO) {
        String sql = "INSERT INTO post (postName, postContent, userNickname, userPW, postIMG) VALUES (?, ?, ?, ?, ?)";

        jdbcTemplate.update(sql, logsDTO.getPostName(), logsDTO.getPostContent(), logsDTO.getUserNickname(),
                logsDTO.getUserPW(), logsDTO.getPostIMG());
    }

    @Override
    public List<LogsDTO> getAllPosts() {
        String sql = "SELECT postNo, postName, postContent, userNickname, postIMG FROM post";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            LogsDTO logsDTO = new LogsDTO();
            logsDTO.setPostNo(rs.getString("postNo"));
            logsDTO.setPostName(rs.getString("postName"));
            logsDTO.setPostContent(rs.getString("postContent"));
            logsDTO.setUserNickname(rs.getString("userNickname"));
            logsDTO.setPostIMG(rs.getString("postIMG"));
            return logsDTO;
        });
    }

    public List<LogsDTO> getClist() {
        String sql = "SELECT  comentContent, comentCreateDate, comentNickname, comentPW, comentNo, cocomentNo, comentDepth FROM coment WHERE postNo = ?";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            LogsDTO logsDTO = new LogsDTO();
            logsDTO.setcomentNickname(rs.getString("comentNickname"));
            logsDTO.setcomentContent(rs.getString("comentContent"));
            logsDTO.setcomentCreateDate(rs.getString("comentCreateDate"));
            return logsDTO;
        });
    }

    // @Override
    // public List<LogsDTO> getNos() {
    // String sql = "SELECT postName, postContent, userNickname, postIMG FROM post
    // where postNo = ?";
    // return jdbcTemplate.query(sql, (rs, rowNum) -> {
    // LogsDTO logsDTO = new LogsDTO();
    // logsDTO.setPostName(rs.getString("postName"));
    // logsDTO.setPostContent(rs.getString("postContent"));
    // logsDTO.setUserNickname(rs.getString("userNickname"));
    // logsDTO.setPostIMG(rs.getString("postIMG"));
    // return logsDTO;
    // });
    // }

}
