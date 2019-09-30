package org.java.service;

import org.java.entity.File;

import java.util.List;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: 你的小张同志
 * Date: 2019/9/17 19:17
 */
public interface FileService {

    /**
     * 功能描述:
     * 上传文件
     * @Param: [record]
     * @Return: int
     * @Author: 你的小张同志
     * @Date: 2019/9/17 19:45
     */
    void uploadFile(File record);

    /**
     * 功能描述:
     * 查询数据库是否有相同名称的文件
     * @Param: [fileName]
     * @Return: int
     * @Author: 你的小张同志
     * @Date: 2019/9/18 19:41
     */
    int querySameFile(String fileName);

    /**
     * 功能描述:
     * 查詢條數
     * @Param: []
     * @Return: int
     * @Author: 你的小张同志
     * @Date: 2019/9/18 15:51
     */
    int queryFilesCount();

    /**
     * 功能描述:
     * 查詢所有的
     * @Param: [map]
     * @Return: java.util.List<org.java.entity.File>
     * @Author: 你的小张同志
     * @Date: 2019/9/18 15:58
     */
    List<File> queryAllFiles(Map<String, Object> map);

    /**
     * 功能描述:
     * 查詢分頁條數
     * @Param: []
     * @Return: java.util.List<org.java.entity.File>
     * @Author: 你的小张同志
     * @Date: 2019/9/19 9:42
     */
    int overloadQueryFilesCount(Map<String, Object> map);

    /**
     * 功能描述:
     * 查詢分頁
     * @Param: [map]
     * @Return: java.util.List<org.java.entity.File>
     * @Author: 你的小张同志
     * @Date: 2019/9/19 9:59
     */
    List<File> overloadQueryFiles(Map<String, Object> map);

    /**
     * 功能描述:
     * 查询留言
     * @Param: [fileId]
     * @Return: java.lang.String
     * @Author: 你的小张同志
     * @Date: 2019/9/19 10:57
     */
    String queryRemark(Integer fileId);

    /**
     * 功能描述:
     * 修改状态
     * @Param: [fileId]
     * @Return: int
     * @Author: 你的小张同志
     * @Date: 2019/9/19 22:41
     */
    int updateStateByPrimaryKey(Integer fileId);

    /**
     * 功能描述:
     * 显示自己的数据条数
     * @Param: [map]
     * @Return: int
     * @Author: 你的小张同志
     * @Date: 2019/9/19 20:16
     */
    int showMyFilesCount(Map<String, Object> map);

    /**
     * 功能描述:
     * 显示自己的数据
     * @Param: [map]
     * @Return: java.util.List<org.java.entity.File>
     * @Author: 你的小张同志
     * @Date: 2019/9/19 20:16
     */
    List<File> showMyFiles(Map<String, Object> map);

    /**
     * 功能描述:
     * 显示回收站所有条数
     * @Param: []
     * @Return: int
     * @Author: 你的小张同志
     * @Date: 2019/9/18 15:56
     */
    int recycleQueryFilesCount();

    /**
     * 功能描述:
     * 显示回收站所有数据
     * @Param: [map]
     * @Return: java.util.List<org.java.entity.File>
     * @Author: 你的小张同志
     * @Date: 2019/9/18 15:58
     */
    List<File> recycleQueryAllFiles(Map<String, Object> map);

    /**
     * 功能描述:
     * 查询回收站的条数
     * @Param: [map]
     * @Return: int
     * @Author: 你的小张同志
     * @Date: 2019/9/19 9:44
     */
    int recycleOverloadQueryFilesCount(Map<String, Object> map);

    /**
     * 功能描述:
     * 查询回收站所有数据
     * @Param: [map]
     * @Return: java.util.List<org.java.entity.File>
     * @Author: 你的小张同志
     * @Date: 2019/9/19 9:59
     */
    List<File> recycleOverloadQueryFiles(Map<String, Object> map);

    /**
     * 功能描述:
     * 删除
     * @Param: [fileId]
     * @Return: int
     * @Author: 你的小张同志
     * @Date: 2019/9/19 19:35
     */
    int deleteByPrimaryKey(Integer fileId);

    /**
     * 功能描述:
     * 还原文件
     * @Param: [fileId]
     * @Return: int
     * @Author: 你的小张同志
     * @Date: 2019/9/19 22:41
     */
    int reductionFiles(Integer fileId);

    /**
     * 功能描述:
     * 修改密码
     * @Param: [pwd, emp_name]
     * @Return: void
     * @Author: 你的小张同志
     * @Date: 2019/9/23 16:30
     */
    void updPwd(String pwd, String emp_name);

    /**
     * 功能描述:
     * 修改昵称
     * @Param: [name, emp_name]
     * @Return: void
     * @Author: 你的小张同志
     * @Date: 2019/9/23 16:30
     */
    void updName(String name, String emp_name);

    /**
     * 功能描述:
     * 修改照片
     * @Param: [emp_photo, emp_name]
     * @Return: void
     * @Author: 你的小张同志
     * @Date: 2019/9/23 16:30
     */
    void updEmp_photo(String emp_photo, String emp_name);

}
