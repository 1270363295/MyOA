package org.java.dao;


import org.java.entity.Email;

import java.util.List;
import java.util.Map;

public interface EmailMapper {
    int deleteByPrimaryKey(Integer eid);

    int insert(Email record);

    int insertSelective(Email record);

    Email selectByPrimaryKey(Integer eid);

    int updateByPrimaryKeySelective(Email record);

    int updateByPrimaryKey(Email record);

    /**
     * 分页显示收件箱
     */
    List<Email> showRecEmail(Map<String, Object> map);


    /**
     * 分页显示发件箱
     */
    List<Email> showSendEmail(Map<String, Object> map);

    /**
     * 收件箱邮件个数
     * @return
     */
    int recEmailCount(String recipients);

    /**
     * 发件箱邮件个数
     * @return
     */
    int sendEmailCount(String addresser);

    /**
     * 删除邮件(实际是修改状态为2的已删除)
     */
    int delEmail(int eid);


    /**
     * 显示邮件详情
     */
    Email showDetail(int eid);

    /**
     * 分页显示草稿箱
     */
    List<Email> showDrafts(Map<String, Object> map);

    /**
     * 草稿箱邮件个数
     */
    int draftsCount(String addresser);

    /**
     * 修改草稿箱中的邮件详情
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
     * 写邮件
     */
    int insertEmail(Map<String, Object> map);

    /**
     * 新建邮件到草稿箱
     */
    int insertDrafts(Map<String, Object> map);


    /**
     * 发送附件
     */
    int insertAccessory(Map<String, Object> map);

    /**
     * 根据eid得到附件名和路径
     */
    Email findAccessory(int eid);

//    /**
//     * 查询所有用户
//     */
//    List<Map<String,Object>> showAllEmp();
}