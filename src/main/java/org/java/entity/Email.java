package org.java.entity;

import java.io.Serializable;
import java.util.Date;

public class Email implements Serializable {
    /**
     * 邮件id，主键
     */
    private Integer eid;

    /**
     * 发件人
     */
    private String addresser;

    /**
     * 收件人
     */
    private String recipients;

    /**
     * 标题
     */
    private String title;

    /**
     * 内容
     */
    private String content;

    /**
     * 重要程度id
     */
    private Integer typeid;

    /**
     * 发件时间
     */
    private String sendtime;

    /**
     * 邮件类型（草稿，非草稿，回收站）
     */
    private Integer form;

    /**
     * 文件重要程度
     */
    private String typeName;

    /**
     * 附件名
     */
    private String accessory_name;

    /**
     * 附件路径
     */
    private String accessory_url;

    private static final long serialVersionUID = 1L;

    public Integer getEid() {
        return eid;
    }

    public void setEid(Integer eid) {
        this.eid = eid;
    }

    public String getAddresser() {
        return addresser;
    }

    public void setAddresser(String addresser) {
        this.addresser = addresser;
    }

    public String getRecipients() {
        return recipients;
    }

    public void setRecipients(String recipients) {
        this.recipients = recipients;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getTypeid() {
        return typeid;
    }

    public void setTypeid(Integer typeid) {
        this.typeid = typeid;
    }

    public String getSendtime() {
        return sendtime;
    }

    public void setSendtime(String sendtime) {
        this.sendtime = sendtime;
    }

    public Integer getForm() {
        return form;
    }

    public void setForm(Integer form) {
        this.form = form;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getAccessory_name() {
        return accessory_name;
    }

    public void setAccessory_name(String accessory_name) {
        this.accessory_name = accessory_name;
    }

    public String getAccessory_url() {
        return accessory_url;
    }

    public void setAccessory_url(String accessory_url) {
        this.accessory_url = accessory_url;
    }

    @Override
    public String toString() {
        return "Email{" +
                "eid=" + eid +
                ", addresser='" + addresser + '\'' +
                ", recipients='" + recipients + '\'' +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", typeid=" + typeid +
                ", sendtime='" + sendtime + '\'' +
                ", form=" + form +
                ", typeName='" + typeName + '\'' +
                ", accessory_name='" + accessory_name + '\'' +
                ", accessory_url='" + accessory_url + '\'' +
                '}';
    }

    public Email() {
    }

    public Email(Integer eid, String addresser, String recipients, String title, String content, Integer typeid, String sendtime, Integer form, String typeName, String accessory_name, String accessory_url) {
        this.eid = eid;
        this.addresser = addresser;
        this.recipients = recipients;
        this.title = title;
        this.content = content;
        this.typeid = typeid;
        this.sendtime = sendtime;
        this.form = form;
        this.typeName = typeName;
        this.accessory_name = accessory_name;
        this.accessory_url = accessory_url;
    }
}