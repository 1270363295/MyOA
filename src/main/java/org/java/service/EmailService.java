package org.java.service;

import org.java.entity.Email;

import java.util.List;
import java.util.Map;

public interface EmailService {
    /**
     * 收件箱
     * @param map
     * @return
     */
    List<Email> showRecEmail(Map<String, Object> map);

    /**
     * 收件箱邮件个数
     * @return
     */
    int recEmailCount(String recipients);

    /**
     * 发件箱
     * @param map
     * @return
     */
    List<Email> showSendEmail(Map<String, Object> map);

    /**
     * 发件箱邮件个数
     * @return
     */
    int sendEmailCount(String addresser);

    /**
     * 删除邮件
     * @param eid
     * @return
     */
    int delEmail(int eid);

    /**
     * 显示邮件详情
     * @param eid
     * @return
     */
    Email showDetail(int eid);

    /**
     * 草稿箱
     * @param map
     * @return
     */
    List<Email> showDrafts(Map<String, Object> map);

    /**
     * 草稿箱邮件个数
     * @return
     */
    int draftsCount(String addresser);

    /**
     * 修改邮件
     * @param map
     * @return
     */
    int updateEmail(Map<String, Object> map);

    /**
     * 显示编辑草稿
     * @param eid
     * @return
     */
    Email showUpdateEmail(Integer eid);

    /**
     * 功能描述:
     * 回收站条数
     * @Param:
     * @Return:
     * @Author: 你的小张同志
     * @Date: 2019/9/22 1:44
     */
    int queryEmailsCount();

    /**
     * 功能描述:
     * 回收站显示
     * @Param:
     * @Return:
     * @Author: 你的小张同志
     * @Date: 2019/9/22 1:44
     */
    List<Email> queryAllEmails(Map<String, Object> map);

    /**
     * 功能描述:
     * 还原邮件
     * @Param:
     * @Return:
     * @Author: 你的小张同志
     * @Date: 2019/9/22 2:01
     */
    int restoreEmails(Integer eid);


    /**
     * 功能描述:
     * 回收站删除邮件
     * @Param: [eid]
     * @Return: int
     * @Author: 你的小张同志
     * @Date: 2019/9/22 2:11
     */
    int recycleBinDelEmail(Integer eid);



    /**
     * 不带附件发送邮件
     */
    int writeEmail(Map<String, Object> map);


    /**
     * 新建邮件放到草稿箱
     */
    int createDrafts(Map<String, Object> map);


    /**
     * 带附件发送邮件
     */
    int writeEmailWithAcc(Map<String, Object> map);


    /**
     * 根据eid查询附件名和路径
     */
    Email findAccessory(int eid);

//    /**
//     * 查询所有用户
//     */
//    List<Map<String,Object>> showAllEmp();
}
