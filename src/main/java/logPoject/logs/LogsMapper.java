package logPoject.logs;

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

    @Select("SELECT * FROM post where postNo = #{postNo}")
    LogsDTO getNos(int postNo);
}