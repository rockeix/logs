package logPoject.logs.DTO;

import com.fasterxml.jackson.annotation.JsonAutoDetect;

@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)

public class LogsDTO {

    // 포스트 테이블
    private String postNo;
    private String postName;
    private String postContent;
    private String userNickname;
    private String userPW;
    private String postIMG;

    // 댓글 테이블
    private String comentContent;
    private String comentCreateDate;
    private String comentNickname;
    private String comentPW;

    // 포스트
    public String getPostNo() {
        return postNo;
    }

    public void setPostNo(String postNo) {
        this.postNo = postNo;
    }

    public String getPostName() {
        return postName;
    }

    public void setPostName(String postName) {
        this.postName = postName;
    }

    public String getPostContent() {
        return postContent;
    }

    public void setPostContent(String postContent) {
        this.postContent = postContent;
    }

    public String getUserNickname() {
        return userNickname;
    }

    public void setUserNickname(String userNickname) {
        this.userNickname = userNickname;
    }

    public String getUserPW() {
        return userPW;
    }

    public void setUserPW(String userPW) {
        this.userPW = userPW;
    }

    public String getPostIMG() {
        return postIMG;
    }

    public void setPostIMG(String postIMG) {
        this.postIMG = postIMG;
    }

    // 댓글
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
}