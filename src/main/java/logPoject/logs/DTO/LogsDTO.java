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
    private String postCreateDate;

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

    public String getPostCreateDate() {
        return postCreateDate;
    }

    public void setPostCreateDate(String postCreateDate) {
        this.postCreateDate = postCreateDate;
    }

};