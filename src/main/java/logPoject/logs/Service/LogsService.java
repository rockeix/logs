package logPoject.logs.Service;

import logPoject.logs.DTO.LogsDTO;
import logPoject.logs.DTO.LogsComentDTO;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class LogsService implements LogsServiceInterface {
    private final JdbcTemplate jdbcTemplate;
    private final BCryptPasswordEncoder passwordEncoder;

    public LogsService(JdbcTemplate jdbcTemplate, BCryptPasswordEncoder passwordEncoder) {
        this.jdbcTemplate = jdbcTemplate;
        this.passwordEncoder = passwordEncoder;
    }

    public List<LogsDTO> getNos(Long postNo) {
        String sql = "SELECT postNo, postName, postContent, userNickname, postCreateDate FROM post WHERE postNo = ?";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            LogsDTO logsDTO = new LogsDTO();
            logsDTO.setPostNo(rs.getString("postNo"));
            logsDTO.setPostName(rs.getString("postName"));
            logsDTO.setPostContent(rs.getString("postContent"));
            logsDTO.setUserNickname(rs.getString("userNickname"));
            logsDTO.setPostCreateDate(rs.getString("postCreateDate"));
            return logsDTO;
        }, postNo);
    }

    @Override
    public void savePost(LogsDTO logsDTO) {
        String sql = "INSERT INTO post (postName, postContent, userNickname, userPW) VALUES (?, ?, ?, ?)";

        jdbcTemplate.update(sql, logsDTO.getPostName(), logsDTO.getPostContent(), logsDTO.getUserNickname(),
                logsDTO.getUserPW());
    }

    @Override
    public List<LogsDTO> getAllPosts() {
        String sql = "SELECT postNo, postName, postContent, userNickname, postCreateDate FROM post ORDER BY postNo DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            LogsDTO logsDTO = new LogsDTO();
            logsDTO.setPostNo(rs.getString("postNo"));
            logsDTO.setPostName(rs.getString("postName"));
            logsDTO.setPostContent(rs.getString("postContent"));
            logsDTO.setUserNickname(rs.getString("userNickname"));
            logsDTO.setPostCreateDate(rs.getString("postCreateDate"));
            return logsDTO;
        });
    }

    @Override
    public List<LogsComentDTO> getClist(Long postNo) {
        String sql = "SELECT postNo, comentContent, comentCreateDate, comentNickname, comentPW, comentNo, cocomentNo, comentDepth, comentDelete FROM coment WHERE postNo = ?";
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
            logsComentDTO.setcomentDelete(rs.getString("comentDelete"));
            return logsComentDTO;
        }, postNo);
    }

    @Override
    public void writeComent(LogsComentDTO logsComentDTO) {

        // 비밀번호 해시화
        String hashedPassword = passwordEncoder.encode(logsComentDTO.getcomentPW());
        logsComentDTO.setcomentPW(hashedPassword);

        String sql = "INSERT INTO coment (postNo, comentContent, comentNickname, comentPW, cocomentNo, comentDepth) VALUES (?, ?, ?, ?, ?, ?)";

        jdbcTemplate.update(sql, logsComentDTO.getPostNo(), logsComentDTO.getcomentContent(),
                logsComentDTO.getcomentNickname(),
                logsComentDTO.getcomentPW(), logsComentDTO.getcocomentNo(), logsComentDTO.getcomentDepth());
    }

    public List<LogsDTO> getPoName(String search) {
        String sql = "SELECT postNo, postName, postContent, userNickname, postCreateDate FROM post WHERE postName LIKE ? ORDER BY postNo DESC";
        String searchPattern = "%" + search + "%";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            LogsDTO logsDTO = new LogsDTO();
            logsDTO.setPostNo(rs.getString("postNo"));
            logsDTO.setPostName(rs.getString("postName"));
            logsDTO.setPostContent(rs.getString("postContent"));
            logsDTO.setUserNickname(rs.getString("userNickname"));
            logsDTO.setPostCreateDate(rs.getString("postCreateDate"));
            return logsDTO;
        }, searchPattern);
    }

    @Override
    public void deleteComent(LogsComentDTO logsComentDTO) {
        String sql = "UPDATE coment SET comentContent = '삭제된 댓글입니다', comentNickname = '', comentPW = '', comentDelete = 1 WHERE comentNo = ?;";
        jdbcTemplate.update(sql, logsComentDTO.getcomentNo());

    }

    @Override
    public List<LogsComentDTO> verify(int comentNo) {
        String sql = "SELECT comentPW FROM coment WHERE comentNo = ?";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            LogsComentDTO logsComentDTO = new LogsComentDTO();
            logsComentDTO.setcomentPW(rs.getString("comentPW"));
            return logsComentDTO;
        }, comentNo);
    }

}
