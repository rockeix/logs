package logPoject.logs.Service;

import java.util.List;

import logPoject.logs.DTO.LogsDTO;
import logPoject.logs.DTO.LogsComentDTO;

public interface LogsServiceInterface {

    void savePost(LogsDTO logsDTO);

    List<LogsDTO> getAllPosts();

    List<LogsDTO> getNos(Long postNo);

    List<LogsComentDTO> getClist(Long postNo);
}
