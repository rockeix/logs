package logPoject.logs;

import logPoject.logs.DTO.LogsComentDTO;
import logPoject.logs.DTO.LogsDTO;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface LogsMapper {

    @Insert("insert into post(postName, postContent, userNickname, userPW, postIMG) values (#{postName}, #{postContent}, #{userNickname}, #{userPW}, #{postIMG})")
    void insertPost(LogsDTO logsDTO);

    @Select("SELECT postNo, postName, postContent, userNickname, postIMG FROM post")
    List<LogsDTO> getAllPosts();

    @Select("SELECT postNo, postName, postContent, userNickname, postIMG FROM post where postNo = #{postNo}")
    LogsDTO getNos(int postNo);

    @Select("SELECT postNo, comentContent, comentCreateDate, comentNickname, comentPW, comentNo, cocomentNo, comentDepth, comentDelete FROM coment where postNo = #{postNo}")
    List<LogsComentDTO> getClist();

    @Insert("INSERT INTO coment (postNo, comentContent, comentNickname, comentPW, cocomentNo, comentDepth) VALUES (#{postNo}, #{comentContent}, #{comentNickname}, #{comentPW}, #{cocomentNo}, #{comentDepth})")
    void writeComent(LogsComentDTO logsComentDTO);

    @Select("SELECT postNo, postName, postContent, userNickname, postIMG FROM post where postName like '%${search}%'")
    List<LogsDTO> getPostNamePost();

    @Update("UPDATE coment SET comentContent = '삭제된 댓글입니다', comentNickname = '', comentPW = '', comentDelete = 1 WHERE comentNo = #{comentNo}")
    void deleteComent(int comentNo);
}