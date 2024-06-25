package logPoject.logs;

import logPoject.logs.DTO.LogsComentDTO;
import logPoject.logs.DTO.LogsDTO;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
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

    @Select("SELECT postNo, comentContent, comentCreateDate, comentNickname, comentPW, comentNo, cocomentNo, comentDepth FROM coment")
    List<LogsComentDTO> getClist();

}