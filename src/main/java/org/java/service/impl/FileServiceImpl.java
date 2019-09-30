package org.java.service.impl;

import org.java.dao.FileMapper;
import org.java.entity.File;
import org.java.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: 你的小张同志
 * Date: 2019/9/17 19:18
 */
@Service
public class FileServiceImpl implements FileService {

    @Autowired
    private FileMapper fileMapper;

    /**
     * 功能描述:
     * 文件上傳
     * @Param: [record]
     * @Return: void
     * @Author: 你的小张同志
     * @Date: 2019/9/18 15:51
     */
    @Override
    public void uploadFile(File record) {
        fileMapper.uploadFile(record);
    }

    /**
     * 功能描述:
     * 查询数据库是否有相同名称的文件
     * @Param: [fileName]
     * @Return: int
     * @Author: 你的小张同志
     * @Date: 2019/9/18 19:41
     */
    @Override
    public int querySameFile(String fileName) {
        return fileMapper.querySameFile(fileName);
    }

    /**
     * 功能描述:
     * 查詢條數
     * @Param: []
     * @Return: int
     * @Author: 你的小张同志
     * @Date: 2019/9/18 15:51
     */
    @Override
    public int queryFilesCount() {
        return fileMapper.queryFilesCount();
    }

    /**
     * 功能描述:
     * 查詢所有文件
     * @Param: [map]
     * @Return: java.util.List<org.java.entity.File>
     * @Author: 你的小张同志
     * @Date: 2019/9/18 15:58
     */
    @Override
    public List<File> queryAllFiles(Map<String, Object> map) {
        return fileMapper.queryAllFiles(map);
    }

    /**
     * 功能描述:
     * 查詢分頁條數
     * @Param: []
     * @Return: java.util.List<org.java.entity.File>
     * @Author: 你的小张同志
     * @Date: 2019/9/19 9:42
     */
    @Override
    public int overloadQueryFilesCount(Map<String, Object> map) {
        return fileMapper.overloadQueryFilesCount(map);
    }

    /**
     * 功能描述:
     * 查詢分頁
     * @Param: [map]
     * @Return: java.util.List<org.java.entity.File>
     * @Author: 你的小张同志
     * @Date: 2019/9/19 9:59
     */
    @Override
    public List<File> overloadQueryFiles(Map<String, Object> map) {
        Integer page = Integer.parseInt( map.get("page").toString());
        Integer limit = Integer.parseInt( map.get("limit").toString());
        map.put("start", (page - 1) * limit);
        map.put("limit", limit);
        return fileMapper.overloadQueryFiles(map);
    }

    /**
     * 功能描述:
     * 查询留言
     * @Param: [fileId]
     * @Return: java.lang.String
     * @Author: 你的小张同志
     * @Date: 2019/9/19 10:57
     */
    @Override
    public String queryRemark(Integer fileId) {
        return fileMapper.queryRemark(fileId);
    }

    @Override
    public int updateStateByPrimaryKey(Integer fileId) {
        return fileMapper.updateStateByPrimaryKey(fileId);
    }

    /**
     * 功能描述:
     * 显示自己的数据条数
     * @Param: [map]
     * @Return: int
     * @Author: 你的小张同志
     * @Date: 2019/9/19 20:16
     */
    @Override
    public int showMyFilesCount(Map<String, Object> map) {
        return fileMapper.showMyFilesCount(map);
    }

    /**
     * 功能描述:
     * 显示自己的数据
     * @Param: [map]
     * @Return: java.util.List<org.java.entity.File>
     * @Author: 你的小张同志
     * @Date: 2019/9/19 20:16
     */
    @Override
    public List<File> showMyFiles(Map<String, Object> map) {
        Integer page = Integer.parseInt( map.get("page").toString());
        Integer limit = Integer.parseInt( map.get("limit").toString());
        map.put("start", (page - 1) * limit);
        map.put("limit", limit);
        return fileMapper.showMyFiles(map);
    }

    /**
     * 功能描述:
     * 回收站数据条数
     * @Param: []
     * @Return: int
     * @Author: 你的小张同志
     * @Date: 2019/9/19 23:04
     */
    @Override
    public int recycleQueryFilesCount() {
        return fileMapper.recycleQueryFilesCount();
    }

    /**
     * 功能描述:
     * 回收站数据显示
     * @Param: [map]
     * @Return: java.util.List<org.java.entity.File>
     * @Author: 你的小张同志
     * @Date: 2019/9/19 23:04
     */
    @Override
    public List<File> recycleQueryAllFiles(Map<String, Object> map) {
        return fileMapper.recycleQueryAllFiles(map);
    }

    /**
     * 功能描述:
     * 查询回收站数据条数
     * @Param: [map]
     * @Return: int
     * @Author: 你的小张同志
     * @Date: 2019/9/19 23:04
     */
    @Override
    public int recycleOverloadQueryFilesCount(Map<String, Object> map) {
        return fileMapper.recycleOverloadQueryFilesCount(map);
    }

    /**
     * 功能描述:
     * 查询回收站数据显示
     * @Param: [map]
     * @Return: java.util.List<org.java.entity.File>
     * @Author: 你的小张同志
     * @Date: 2019/9/19 23:05
     */
    @Override
    public List<File> recycleOverloadQueryFiles(Map<String, Object> map) {
        Integer page = Integer.parseInt( map.get("page").toString());
        Integer limit = Integer.parseInt( map.get("limit").toString());
        map.put("start", (page - 1) * limit);
        map.put("limit", limit);
        return fileMapper.recycleOverloadQueryFiles(map);
    }

    /**
     * 功能描述:
     * 删除
     * @Param: [fileId]
     * @Return: int
     * @Author: 你的小张同志
     * @Date: 2019/9/19 19:35
     */
    @Override
    public int deleteByPrimaryKey(Integer fileId) {
        return fileMapper.deleteByPrimaryKey(fileId);
    }

    /**
     * 功能描述:
     * 还原文件
     * @Param: [fileId]
     * @Return: int
     * @Author: 你的小张同志
     * @Date: 2019/9/19 23:07
     */
    @Override
    public int reductionFiles(Integer fileId) {
        return fileMapper.reductionFiles(fileId);
    }

    /**
     * 功能描述:
     * 修改密码
     * @Param: [pwd, emp_name]
     * @Return: void
     * @Author: 你的小张同志
     * @Date: 2019/9/23 16:30
     */
    @Override
    public void updPwd(String pwd,String emp_name) {
        fileMapper.updPwd(pwd,emp_name);
    }

    /**
     * 功能描述:
     * 修改昵称
     * @Param: [name, emp_name]
     * @Return: void
     * @Author: 你的小张同志
     * @Date: 2019/9/23 16:30
     */
    @Override
    public void updName(String name,String emp_name) {
        fileMapper.updName(name,emp_name);
    }

    /**
     * 功能描述:
     * 修改照片
     * @Param: [emp_photo, emp_name]
     * @Return: void
     * @Author: 你的小张同志
     * @Date: 2019/9/23 16:30
     */
    @Override
    public void updEmp_photo(String emp_photo, String emp_name) {
        fileMapper.updEmp_photo(emp_photo,emp_name);
    }

}
