package logPoject.logs;

import logPoject.logs.DTO.LogsDTO;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface LogsMapper {
    
    @Insert("insert into post(postName, postContent, userNickname, userPW) values (#{postName}, #{postContent}, #{userNickname}, #{userPW})")
    void insertPost(LogsDTO logsDTO);
}