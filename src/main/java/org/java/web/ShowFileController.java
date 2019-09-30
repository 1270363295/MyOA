package org.java.web;

import org.java.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.*;

/**
 * Created by IntelliJ IDEA.
 * User: 你的小张同志
 * Date: 2019/9/18 15:46
 */
@Controller
public class ShowFileController {

    @Autowired
    private FileService fileService;

    /**
     * 功能描述:
     * 显示
     * @Param: [page, limit]
     * @Return: java.util.Map<java.lang.String,java.lang.Object>
     * @Author: 你的小张同志
     * @Date: 2019/9/23 16:40
     */
    @ResponseBody
    @RequestMapping(value = "/ShowFile", method = RequestMethod.GET)
    public Map<String, Object> showFiles(int page, int limit){

        //把数据传到 mapper 文件中，通过以下两个条件来查询
        Map<String, Object> map = new HashMap<>();
        map.put("page", (page - 1) * limit);
        map.put("limit", limit);

        //將需要返回的數據放入 resultMap 中
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("code", 0);
        resultMap.put("msg", "");
        resultMap.put("count", 17);
        resultMap.put("count", fileService.queryFilesCount());
        resultMap.put("status", 0);
        resultMap.put("total", 180);
        resultMap.put("data",fileService.queryAllFiles(map));

        return resultMap;

    }


    /**
     * 功能描述:
     * 查询分页
     * @Param: [map]
     * @Return: java.util.Map<java.lang.String,java.lang.Object>
     * @Author: 你的小张同志
     * @Date: 2019/9/19 10:50
     */
    @RequestMapping(value = "overloadQuery", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
    @ResponseBody
    public Map<String,Object> queryFiles(@RequestParam Map<String, Object> map){

        Map<String, Object> resultMap = new HashMap<>();

        resultMap.put("code", 0);

        resultMap.put("msg", "");

        resultMap.put("data", fileService.overloadQueryFiles(map));
        resultMap.put("count", fileService.overloadQueryFilesCount(map));

        resultMap.put("status", 0);
        resultMap.put("total", 180);

        return resultMap;

    }

    /**
     * 功能描述:
     * 修改,放进回收站
     * @Param: [jsonString, session]
     * @Return: void
     * @Author: 你的小张同志
     * @Date: 2019/9/19 18:59
     */
    @ResponseBody
    @RequestMapping(value = "updateStateByPrimaryKey", method = RequestMethod.GET)
    public void updateStateByPrimaryKey(int fileId, HttpServletResponse response) throws IOException {

        fileService.updateStateByPrimaryKey(fileId);

        renderData(response,"成功");

    }

    /**
     * 功能描述:
     * 显示自己的文件
     * @Param: [map]
     * @Return: java.util.Map<java.lang.String,java.lang.Object>
     * @Author: 你的小张同志
     * @Date: 2019/9/19 23:08
     */
    @RequestMapping(value = "showMyFiles", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
    @ResponseBody
    public Map<String,Object> showMyFiles(@RequestParam Map<String, Object> map){

        Map<String, Object> resultMap = new HashMap<>();

        resultMap.put("code", 0);

        resultMap.put("msg", "");

        resultMap.put("data", fileService.showMyFiles(map));
        resultMap.put("count", fileService.showMyFilesCount(map));

        resultMap.put("status", 0);
        resultMap.put("total", 180);

        return resultMap;

    }

    /**
     * 功能描述:
     * 回收站显示
     * @Param: [page, limit]
     * @Return: java.util.Map<java.lang.String,java.lang.Object>
     * @Author: 你的小张同志
     * @Date: 2019/9/19 23:09
     */
    @ResponseBody
    @RequestMapping(value = "/recycleShowFile", method = RequestMethod.GET)
    public Map<String, Object> recycleShowFiles(int page, int limit){

        //把数据传到 mapper 文件中，通过以下两个条件来查询
        Map<String, Object> map = new HashMap<>();
        map.put("page", (page - 1) * limit);
        map.put("limit", limit);

        //將需要返回的數據放入 resultMap 中
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("code", 0);
        resultMap.put("msg", "");
        resultMap.put("count", 17);
        resultMap.put("count", fileService.recycleQueryFilesCount());
        resultMap.put("status", 0);
        resultMap.put("total", 180);
        resultMap.put("data",fileService.recycleQueryAllFiles(map));

        return resultMap;

    }


    /**
     * 功能描述:
     * 查询回收站显示
     * @Param: [map]
     * @Return: java.util.Map<java.lang.String,java.lang.Object>
     * @Author: 你的小张同志
     * @Date: 2019/9/19 10:50
     */
    @RequestMapping(value = "rcycleOverloadQuery", method = RequestMethod.POST, produces = "application/json; " +
            "charset=utf-8")
    @ResponseBody
    public Map<String,Object> rcycleQueryFiles(@RequestParam Map<String, Object> map){

        Map<String, Object> resultMap = new HashMap<>();

        resultMap.put("code", 0);

        resultMap.put("msg", "");

        System.out.println(fileService.recycleOverloadQueryFiles(map));

        resultMap.put("data", fileService.recycleOverloadQueryFiles(map));
        resultMap.put("count", fileService.recycleOverloadQueryFilesCount(map));

        resultMap.put("status", 0);
        resultMap.put("total", 180);

        return resultMap;

    }

    /**
     * 功能描述:
     * 删除
     * @Param: [jsonString, session]
     * @Return: void
     * @Author: 你的小张同志
     * @Date: 2019/9/19 18:59
     */
    @ResponseBody
    @RequestMapping(value = "deleteByPrimaryKey", method = RequestMethod.GET)
    public void deleteByPrimaryKey(int fileId, HttpServletResponse response) throws IOException {

        fileService.deleteByPrimaryKey(fileId);

        renderData(response,"成功");

    }

    /**
     * 功能描述:
     * 還原
     * @Param: [jsonString, session]
     * @Return: void
     * @Author: 你的小张同志
     * @Date: 2019/9/19 18:59
     */
    @ResponseBody
    @RequestMapping(value = "reductionFiles", method = RequestMethod.GET)
    public void reductionFiles(int fileId, HttpServletResponse response) throws IOException {

        System.out.println(fileId);

        fileService.reductionFiles(fileId);

        renderData(response,"成功");

    }

    /**
     * 功能描述:
     * 下載
     * @Param: []
     * @Return: void
     * @Author: 你的小张同志
     * @Date: 2019/9/20 8:11
     */
    @ResponseBody
    @RequestMapping(value = "downloadFiles", method = RequestMethod.POST)
    public void downloadFiles(String fileUrl, String fileName, HttpServletResponse response) throws IOException {

        System.out.println(fileUrl);
        System.out.println(fileName);

        String path = fileUrl+"\\"+fileName;
        System.out.println(path);

        //得到要下载的文件
        File file = new File(path);
        if (!file.exists()) {
            System.out.println("您要下载的资源已被删除！！");
            return;
        }
        //转码，免得文件名中文乱码
        fileName = URLEncoder.encode(fileName,"UTF-8");
        System.out.println(fileName);
        //设置文件下载头
        response.addHeader("Content-Disposition", "attachment;filename=" + fileName);
        //1.设置文件ContentType类型，这样设置，会自动判断下载文件类型
        response.setContentType("multipart/form-data");
        // 读取要下载的文件，保存到文件输入流
        FileInputStream in = new FileInputStream(path);
        // 创建输出流
        OutputStream out = response.getOutputStream();
        // 创建缓冲区
        // 缓冲区的大小设置是个迷  我也没搞明白
        byte buffer[] = new byte[1024];
        int len = 0;
        //循环将输入流中的内容读取到缓冲区当中
        while((len = in.read(buffer)) > 0){
            out.write(buffer, 0, len);
        }
        //关闭文件输入流
        in.close();
        // 关闭输出流
        out.close();

    }

    /**
     * 功能描述:
     * 批量修改,放进回收站
     * @Param: [fileIds, response]
     * @Return: void
     * @Author: 你的小张同志
     * @Date: 2019/9/20 16:58
     */
    @ResponseBody
    @RequestMapping(value = "/updManyFiles",method = RequestMethod.GET)
    public void updManyFiles(String fileIds, HttpServletResponse response) throws IOException {
        List delList = new ArrayList();
        String[] strs = fileIds.split(",");
        for (String str : strs) {
            delList.add(str);
        }
        Iterator it1 = delList.iterator();
        while(it1.hasNext()){
            int fileId = Integer.parseInt((String) it1.next());
            fileService.updateStateByPrimaryKey(fileId);
        }
        renderData(response,"成功");
    }

    /**
     * 功能描述:
     * 批量删除
     * @Param: [fileIds, response]
     * @Return: void
     * @Author: 你的小张同志
     * @Date: 2019/9/20 16:57
     */
    @ResponseBody
    @RequestMapping(value = "/delManyFiles",method = RequestMethod.GET)
    public void delManyFiles(String fileIds, HttpServletResponse response) throws IOException {
        List delList = new ArrayList();
        String[] strs = fileIds.split(",");
        for (String str : strs) {
            delList.add(str);
        }
        Iterator it1 = delList.iterator();
        while(it1.hasNext()){
            int fileId = Integer.parseInt((String) it1.next());
            fileService.deleteByPrimaryKey(fileId);
        }
        renderData(response,"成功");
    }

    /**
     * 功能描述:
     * 批量还原
     * @Param: [fileIds, response]
     * @Return: void
     * @Author: 你的小张同志
     * @Date: 2019/9/20 16:57
     */
    @ResponseBody
    @RequestMapping(value = "/restoreManyFiles",method = RequestMethod.GET)
    public void restoreManyFiles(String fileIds, HttpServletResponse response) throws IOException {
        List delList = new ArrayList();
        String[] strs = fileIds.split(",");
        for (String str : strs) {
            delList.add(str);
        }
        Iterator it1 = delList.iterator();
        while(it1.hasNext()){
            int fileId = Integer.parseInt((String) it1.next());
            fileService.reductionFiles(fileId);
        }
        renderData(response,"成功");
    }

    //专门用于发送信息的方法
    private void renderData(HttpServletResponse response, String data) throws IOException {

        response.setContentType("text/plain;charset=UTF-8");
        //发送信息
        response.getWriter()
                .write(data);

    }

}
