package org.java.service.impl;

import org.java.dao.EmailMapper;
import org.java.entity.Email;
import org.java.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class EmailServiceImpl implements EmailService {

    @Autowired
    private EmailMapper emailMapper;

    /**
     * 分页显示收件箱所有邮件
     * @param map
     * @return
     */
    @Override
    public List<Email> showRecEmail(Map<String,Object> map) {
        return emailMapper.showRecEmail(map);
    }

    /**
     * 收件箱邮件数量
     * @return
     */
    @Override
    public int recEmailCount(String recipients) {
        return emailMapper.recEmailCount(recipients);
    }

    /**
     *分页显示发件箱所有邮件
     * @param map
     * @return
     */
    @Override
    public List<Email> showSendEmail(Map<String, Object> map) {

        return emailMapper.showSendEmail(map);
    }

    /**
     * 发件箱邮件数量
     * @return
     */
    @Override
    public int sendEmailCount(String addresser) {
        return emailMapper.sendEmailCount(addresser);
    }

    /**
     * 删除邮件(实际为修改状态为2的已删除)
     * @param eid
     * @return
     */
    @Override
    public int delEmail(int eid) {
        return emailMapper.delEmail(eid);
    }

    /**
     * 邮件详情
     * @param eid
     * @return
     */
    @Override
    public Email showDetail(int eid) {
        return emailMapper.showDetail(eid);
    }

    /**
     * 草稿箱邮件分页显示
     * @param map
     * @return
     */
    @Override
    public List<Email> showDrafts(Map<String, Object> map) {
        return emailMapper.showDrafts(map);
    }

    /**
     * 草稿箱邮件个数
     * @return
     */
    @Override
    public int draftsCount(String addresser) {
        return emailMapper.draftsCount(addresser);
    }

    /**
     * 编辑邮件
     * @param map
     * @return
     */
    @Override
    public int updateEmail(Map<String,Object> map) {
        return emailMapper.updateEmail(map);
    }

    /**
     * 显示编辑草稿
     * @param eid
     * @return
     */
    @Override
    public Email showUpdateEmail(Integer eid) {
        return emailMapper.showUpdateEmail(eid);
    }


    /**
     * 功能描述:
     * 回收站条数
     * @Param:
     * @Return:
     * @Author: 你的小张同志
     * @Date: 2019/9/22 1:44
     */
    @Override
    public int queryEmailsCount() {
        return emailMapper.queryEmailsCount();
    }

    /**
     * 功能描述:
     * 回收站显示
     * @Param:
     * @Return:
     * @Author: 你的小张同志
     * @Date: 2019/9/22 1:44
     */
    @Override
    public List<Email> queryAllEmails(Map<String, Object> map) {
        return emailMapper.queryAllEmails(map);
    }

    /**
     * 功能描述:
     * 还原邮件
     * @Param:
     * @Return:
     * @Author: 你的小张同志
     * @Date: 2019/9/22 2:01
     */
    @Override
    public int restoreEmails(Integer eid) {
        return emailMapper.restoreEmails(eid);
    }

    /**
     * 功能描述:
     * 回收站删除邮件
     * @Param: [eid]
     * @Return: int
     * @Author: 你的小张同志
     * @Date: 2019/9/22 2:11
     */
    @Override
    public int recycleBinDelEmail(Integer eid) {
        return emailMapper.recycleBinDelEmail(eid);

    }

    /**
     * 不带附件发邮件
     * @param map
     * @return
     */
    @Override
    public int writeEmail(Map<String,Object> map) {
        return emailMapper.insertEmail(map);
    }


    /**
     * 新建邮件放入草稿箱
     * @param map
     * @return
     */
    @Override
    public int createDrafts(Map<String, Object> map) {
        return emailMapper.insertDrafts(map);
    }


    /**
     * 带附件发送邮件
     * @param map
     * @return
     */
    @Override
    public int writeEmailWithAcc(Map<String, Object> map) {
        return emailMapper.insertAccessory(map);
    }


    /**
     * 根据eid查询附件名和路径
     */
    @Override
    public Email findAccessory(int eid) {
        return emailMapper.findAccessory(eid);
    }


//    /**
//     * 查询所有用户
//     * @return
//     */
//    @Override
//    public List<Map<String,Object>> showAllEmp() {
//        return emailMapper.showAllEmp();
//    }


}
