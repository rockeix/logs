package logPoject.logs;

import logPoject.logs.DTO.LogsDTO;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface LogsMapper {
    
    @Insert("INSERT INTO post (post_name, post_content, user_nickname, user_pw) VALUES (#{postName}, #{postContent}, #{userNickname}, #{userPW})")
    void insertPost(LogsDTO logsDTO);
}