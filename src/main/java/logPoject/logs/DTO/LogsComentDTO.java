package logPoject.logs.DTO;

import com.fasterxml.jackson.annotation.JsonAutoDetect;

@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)

public class LogsComentDTO {

    private String postNo;
    private String comentContent;
    private String comentCreateDate;
    private String comentNickname;
    private String comentPW;
    private String comentNo;
    private String cocomentNo;
    private String comentDepth;
    private String comentDelete;

public String getPostNo() {
        return postNo;
    }

public void setPostNo(String postNo) {
        this.postNo = postNo;
    }

public String getcomentContent() {
    return comentContent;
}

public void setcomentContent(String comentContent) {
    this.comentContent = comentContent;
}

public String getcomentCreateDate() {
    return comentCreateDate;
}

public void setcomentCreateDate(String comentCreateDate) {
    this.comentCreateDate = comentCreateDate;
}

public String getcomentNickname() {
    return comentNickname;
}

public void setcomentNickname(String comentNickname) {
    this.comentNickname = comentNickname;
}

public String getcomentPW() {
    return comentPW;
}

public void setcomentPW(String comentPW) {
    this.comentPW = comentPW;
}

public String getcomentNo() {
    return comentNo;
}

public void setcomentNo(String comentNo) {
    this.comentNo = comentNo;
}

public String getcocomentNo() {
    return cocomentNo;
}

public void setcocomentNo(String cocomentNo) {
    this.cocomentNo = cocomentNo;
}

public String getcomentDepth() {
    return comentDepth;
}

public void setcomentDepth(String comentDepth) {
    this.comentDepth = comentDepth;
}

public String getcomentDelete() {
    return comentDelete;
}

public void setcomentDelete(String comentDelete) {
    this.comentDepth = comentDelete;
}
};