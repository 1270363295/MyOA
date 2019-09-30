package org.java.entity;

import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: 你的小张同志
 * Date: 2019/9/18 18:32
 */
public class File implements Serializable {
    private Integer fileId;

    private String fileName;

    private String fileUrl;

    private String username;

    private String remark;

    private Integer fileState;

    private static final long serialVersionUID = 1L;

    public Integer getFileId() {
        return fileId;
    }

    public void setFileId(Integer fileId) {
        this.fileId = fileId;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getFileState() {
        return fileState;
    }

    public void setFileState(Integer fileState) {
        this.fileState = fileState;
    }

    public File() {
    }

    public File(Integer fileId, String fileName, String fileUrl, String username, String remark, Integer fileState) {
        this.fileId = fileId;
        this.fileName = fileName;
        this.fileUrl = fileUrl;
        this.username = username;
        this.remark = remark;
        this.fileState = fileState;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", fileId=").append(fileId);
        sb.append(", fileName=").append(fileName);
        sb.append(", fileUrl=").append(fileUrl);
        sb.append(", username=").append(username);
        sb.append(", remark=").append(remark);
        sb.append(", fileState=").append(fileState);
        sb.append("]");
        return sb.toString();
    }
}