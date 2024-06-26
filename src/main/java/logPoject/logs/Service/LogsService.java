package logPoject.logs.Service;

import logPoject.logs.DTO.LogsDTO;
import logPoject.logs.DTO.LogsComentDTO;

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

    public List<LogsComentDTO> getClist(Long postNo) {
        String sql = "SELECT postNo, comentContent, comentCreateDate, comentNickname, comentPW, comentNo, cocomentNo, comentDepth FROM coment WHERE postNo = ?";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            LogsComentDTO logsComentDTO = new LogsComentDTO();
            logsComentDTO.setPostNo(rs.getString("postNo"));
            logsComentDTO.setcomentContent(rs.getString("comentContent"));
            logsComentDTO.setcomentCreateDate(rs.getString("comentCreateDate"));
            logsComentDTO.setcomentNickname(rs.getString("comentNickname"));
            logsComentDTO.setcomentPW(rs.getString("comentPW"));
            logsComentDTO.setcomentNo(rs.getString("comentNo"));
            logsComentDTO.setcocomentNo(rs.getString("cocomentNo"));
            logsComentDTO.setcomentDepth(rs.getString("comentDepth"));
            return logsComentDTO;
        }, postNo);
    }

    @Override
    public void writeComent(LogsComentDTO logsComentDTO) {
        String sql = "INSERT INTO coment (postNo, comentContent, comentNickname, comentPW, cocomentNo, comentDepth) VALUES (?, ?, ?, ?, ?, ?)";

        jdbcTemplate.update(sql, logsComentDTO.getPostNo(), logsComentDTO.getcomentContent(),
                logsComentDTO.getcomentNickname(),
                logsComentDTO.getcomentPW(), logsComentDTO.getcocomentNo(), logsComentDTO.getcomentDepth());
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
