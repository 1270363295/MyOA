package org.java.web;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.ibatis.annotations.Param;
import org.java.entity.Email;
import org.java.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;

@Controller
public class EmailController {

    @Autowired
    private EmailService emailService;

    /**
     * 收件箱(当前登陆的人为收件人)
     * @param page
     * @param limit
     * @return
     */
    @ResponseBody
    @RequestMapping("recEmail")
    public Map<String,Object> showRecEmail(int page, int limit, HttpSession session){
        System.out.println("显示收件箱");
        Map user = (Map) session.getAttribute("user");
        String name = (String) user.get("emp_name");
        //把数据传到mapper文件中，通过以下两个条件来查询
        Map<String, Object> map = new HashMap<>();
        map.put("page", (page - 1) * limit);
        map.put("limit", limit);
        map.put("name",name);


        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("code", 0);
        resultMap.put("msg", "");
        //显示收件箱的邮件
        System.out.println(emailService.showRecEmail(map));
        resultMap.put("count", emailService.recEmailCount(name));
        resultMap.put("status", 0);
        resultMap.put("total", 180);
        resultMap.put("data", emailService.showRecEmail(map));

        return resultMap;
    }

    /**
     * 发件箱(当前登陆的人为发件人)
     * @param page
     * @param limit
     * @return
     */
    @ResponseBody
    @RequestMapping("sendEmail")
    public Map<String,Object> showSendEmail(int page, int limit, HttpSession session){
        System.out.println("显示发件箱");
        Map user = (Map) session.getAttribute("user");
        String name = (String) user.get("emp_name");

        //把数据传到mapper文件中，通过以下两个条件来查询
        Map<String, Object> map = new HashMap<>();
        map.put("page", (page - 1) * limit);
        map.put("limit", limit);
        map.put("name",name);

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("code", 0);
        resultMap.put("msg", "");
        //显示收件箱的邮件
        System.out.println(emailService.showSendEmail(map));
        resultMap.put("count", emailService.sendEmailCount(name));
        resultMap.put("status", 0);
        resultMap.put("total", 180);
        resultMap.put("data", emailService.showSendEmail(map));

        return resultMap;
    }

    /**
     * 删除邮件(实际为修改状态为2回收站)
     */
    @ResponseBody
    @RequestMapping("del")
    public void del(String eids, HttpServletResponse response) throws IOException {
        System.out.println("删除邮件");
        List delList = new ArrayList();
        String[] strs = eids.split(",");
        for (String str : strs) {
            delList.add(str);
        }
        Iterator it1 = delList.iterator();
        while(it1.hasNext()){
//            System.out.println(it1.next());
            int eid = Integer.parseInt((String) it1.next());
            emailService.delEmail(eid);
        }
        renderData(response,"成功");
    }


    /**
     * 显示邮件详情
     * @return
     */
    @ResponseBody
    @RequestMapping("showDetail")
    public void showDetail(int eid, HttpSession session){
        System.out.println("eid是："+eid);
        Email email = emailService.showDetail(eid);
        System.out.println(email);
        session.setAttribute("detail",email);
        session.setAttribute("one",email.getAddresser());

        Email accessory = emailService.findAccessory(eid);
        session.setAttribute("accessory",accessory);


    }


    /**
     * 分页显示草稿箱
     * @param page
     * @param limit
     * @return
     */
    @ResponseBody
    @RequestMapping("drafts")
    public Map<String,Object> showDrafts(int page, int limit, HttpSession session){
        System.out.println("显示草稿箱");
        Map user = (Map) session.getAttribute("user");
        String name = (String) user.get("emp_name");

        //把数据传到mapper文件中，通过以下两个条件来查询
        Map<String, Object> map = new HashMap<>();
        map.put("page", (page - 1) * limit);
        map.put("limit", limit);
        map.put("name",name);

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("code", 0);
        resultMap.put("msg", "");
        //显示草稿箱的邮件
        System.out.println(emailService.showDrafts(map));
        resultMap.put("count", emailService.draftsCount(name));
        resultMap.put("status", 0);
        resultMap.put("total", 180);
        resultMap.put("data", emailService.showDrafts(map));

        return resultMap;
    }

    /**
     * 显示草稿箱邮件详情
     * @param eid
     * @param response
     * @param session
     * @throws IOException
     */
    @ResponseBody
    @RequestMapping("showUpdateEmail")
    public void showUpdateEmail(int eid, HttpServletResponse response, HttpSession session) throws IOException {
        Email showUpdateEmail = emailService.showUpdateEmail(eid);
        System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        System.out.println(eid);
        session.setAttribute("showUpdateEmail",showUpdateEmail);
        renderData(response,"成功");

    }

    /**
     * 对草稿箱中的邮件进行编辑
     * @param title
     * @param recipients
     * @param content
     * @param response
     * @param session
     * @throws IOException
     */
    @ResponseBody
    @RequestMapping("edit")
    public void edit(String title,String recipients,String content,HttpServletResponse response,HttpSession session) throws IOException {

        System.out.println("编辑邮件");
        System.out.println(title);
        System.out.println(recipients);
        System.out.println(content);
        Email showUpdateEmail= (Email) session.getAttribute("showUpdateEmail");
        System.out.println(showUpdateEmail.getEid());
        Map<String,Object> map = new HashMap<>();
        map.put("recipients",recipients);
        map.put("title",title);
        map.put("content",content);
        map.put("eid",showUpdateEmail.getEid());

        emailService.updateEmail(map);

        renderData(response,"成功");

    }

    /**
     * 功能描述:
     * 回收站显示
     * @Param: [page, limit]
     * @Return: java.util.Map<java.lang.String,java.lang.Object>
     * @Author: 你的小张同志
     * @Date: 2019/9/22 2:26
     */
    @ResponseBody
    @RequestMapping(value = "/showRecycleBinFile", method = RequestMethod.GET)
    public Map<String, Object> showFiles(int page, int limit){

        //把数据传到 mapper 文件中，通过以下两个条件来查询
        Map<String, Object> map = new HashMap<>();
        map.put("page", (page - 1) * limit);
        map.put("limit", limit);

        //將需要返回的數據放入 resultMap 中
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("code", 0);
        resultMap.put("msg", "");
        resultMap.put("count", emailService.queryEmailsCount());
        resultMap.put("status", 0);
        resultMap.put("total", 180);
        resultMap.put("data",emailService.queryAllEmails(map));

        return resultMap;

    }

    /**
     * 功能描述:
     * 还原邮件
     * @Param: [fileId, response]
     * @Return: void
     * @Date: 2019/9/22 2:00
     */
    @ResponseBody
    @RequestMapping(value = "restoreEmails", method = RequestMethod.GET)
    public void restoreEmails(int eid,HttpServletResponse response) throws IOException {

        System.out.println(eid);

        emailService.restoreEmails(eid);

        renderData(response,"成功");

    }

    /**
     * 功能描述:
     * 回收站删除邮件
     * @Param: [eid]
     * @Return: int
     * @Author: 你的小张同志
     * @Date: 2019/9/22 2:11
     */
    @ResponseBody
    @RequestMapping(value = "recycleBinDelEmail", method = RequestMethod.GET)
    public void recycleBinDelEmail(int eid,HttpServletResponse response) throws IOException {

        System.out.println(eid);

        emailService.recycleBinDelEmail(eid);

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
    @RequestMapping(value = "/recycleBinDelEmails",method = RequestMethod.GET)
    public void recycleBinDelEmails(String eids,HttpServletResponse response) throws IOException {
        List delList = new ArrayList();
        String[] strs = eids.split(",");
        for (String str : strs) {
            delList.add(str);
        }
        Iterator it1 = delList.iterator();
        while(it1.hasNext()){
            int eid = Integer.parseInt((String) it1.next());
            emailService.recycleBinDelEmail(eid);
        }
        renderData(response,"成功");
    }

    /**
     * 不带附件发邮件
     * @param recipients
     * @param title
     * @param content
     * @param typeid
     * @param response
     * @throws IOException
     */
    @ResponseBody
    @RequestMapping("writeEmail")
    public void writeEmail(String recipients, String title, String content, int typeid, HttpServletResponse response,HttpSession session) throws IOException {
        System.out.println("发送邮件");

        Map user = (Map) session.getAttribute("user");
        String name = (String) user.get("emp_name");

        System.out.println(recipients);
        System.out.println(title);
        System.out.println(content);
        System.out.println(typeid);
        Map<String,Object> map = new HashMap<>();
        map.put("recipients",recipients);
        map.put("title",title);
        map.put("content",content);
        map.put("typeid",typeid);
        map.put("name",name);

        emailService.writeEmail(map);

        renderData(response,"邮件发送成功！");

    }


    /**
     * 新建邮件到草稿箱
     * @param recipients
     * @param title
     * @param content
     * @param typeid
     * @param response
     * @throws IOException
     */
    @ResponseBody
    @RequestMapping("createDrafts")
    public void createDrafts(String recipients, String title, String content, int typeid, HttpServletResponse response,HttpSession session) throws IOException {
        System.out.println("添加邮件到草稿箱");

        Map user = (Map) session.getAttribute("user");
        String name = (String) user.get("emp_name");

        System.out.println(recipients);
        System.out.println(title);
        System.out.println(content);
        System.out.println(typeid);
        Map<String,Object> map = new HashMap<>();
        map.put("recipients",recipients);
        map.put("title",title);
        map.put("content",content);
        map.put("typeid",typeid);
        map.put("name",name);

        emailService.createDrafts(map);

        renderData(response,"已添加到草稿箱");

    }


    /**
     * 带附件发送邮件
     * @param recipients
     * @param title
     * @param content
     * @param typeid
     * @param request
     * @param response
     * @throws IOException
     */
    @ResponseBody
    @RequestMapping("writeEmailWithAcc")
    public void writeEmailWithAcc(String recipients, String title, String content, int typeid, HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
        System.out.println("带附件上传");


        //得到上传文件的保存目录，将上传的文件存放于WEB-INF目录下，不允许外界直接访问，保证上传文件的安全
        String savePath = "E:\\文件上传\\上传文件的保存目录";
        //上传时生成的临时文件保存目录
        String tempPath = "E:\\文件上传\\临时文件保存目录";
        File tmpFile = new File(tempPath);
        if (!tmpFile.exists()) {
            //创建临时目录
            tmpFile.mkdir();
        }

        //消息提示
        String message = "";
        try{
            //使用Apache文件上传组件处理文件上传步骤：
            //1、创建一个DiskFileItemFactory工厂
            DiskFileItemFactory factory = new DiskFileItemFactory();
            //设置工厂的缓冲区的大小，当上传的文件大小超过缓冲区的大小时，就会生成一个临时文件存放到指定的临时目录当中。
            //设置缓冲区的大小为100KB，如果不指定，那么缓冲区的大小默认是10KB
            factory.setSizeThreshold(1024*100);
            //设置上传时生成的临时文件的保存目录
            factory.setRepository(tmpFile);
            //2、创建一个文件上传解析器
            ServletFileUpload upload = new ServletFileUpload(factory);
            //监听文件上传进度
            upload.setProgressListener(new ProgressListener(){
                @Override
                public void update(long pBytesRead, long pContentLength, int arg2) {
                    System.out.println("文件大小为：" + pContentLength + ",当前已处理：" + pBytesRead);
                    /**
                     * 文件大小为：14608,当前已处理：4096
                     文件大小为：14608,当前已处理：7367
                     文件大小为：14608,当前已处理：11419
                     文件大小为：14608,当前已处理：14608
                     */
                }
            });
            //解决上传文件名的中文乱码
            upload.setHeaderEncoding("UTF-8");
            //3、判断提交上来的数据是否是上传表单的数据
            if(!ServletFileUpload.isMultipartContent(request)){
                //按照传统方式获取数据
                return;
            }

            //设置上传单个文件的大小的最大值，目前是设置为1024*1024字节，也就是1MB
            upload.setFileSizeMax(1024*1024*31);
            //设置上传文件总量的最大值，最大值=同时上传的多个文件的大小的最大值的和，目前设置为10MB
            upload.setSizeMax(1024*1024*10);
            //4、使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合，每一个FileItem对应一个Form表单的输入项
            List<FileItem> list = upload.parseRequest(request);
            //
            int size=0;
            for(FileItem item : list){
                //如果fileitem中封装的是普通输入项的数据
                if(item.isFormField()){
                    String name = item.getFieldName();
                    //解决普通输入项的数据的中文乱码问题
                    String value = item.getString("UTF-8");
                    //value = new String(value.getBytes("iso8859-1"),"UTF-8");
                    System.out.println(name + "=" + value);
                }else{//如果fileitem中封装的是上传文件
                    //得到上传的文件名称，
                    String filename = item.getName();

                    System.out.println(filename);
                    if(filename==null || filename.trim().equals("")){
                        continue;
                    }
                    //注意：不同的浏览器提交的文件名是不一样的，有些浏览器提交上来的文件名是带有路径的，如：  c:\a\b\1.txt，而有些只是单纯的文件名，如：1.txt
                    //处理获取到的上传文件的文件名的路径部分，只保留文件名部分
                    filename = filename.substring(filename.lastIndexOf("\\")+1);
                    //得到上传文件的扩展名
                    String fileExtName = filename.substring(filename.lastIndexOf(".")+1);
                    //如果需要限制上传的文件类型，那么可以通过文件的扩展名来判断上传的文件类型是否合法
                    System.out.println("上传的文件的扩展名是："+fileExtName);
                    //获取item中的上传文件的输入流
                    InputStream in = item.getInputStream();
                    //得到文件保存的名称
//                    String saveFilename = makeFileName(filename);
                    String saveFilename = filename;
                    //得到文件的保存目录
                    String realSavePath = makePath(saveFilename, savePath);
                    //创建一个文件输出流
                    FileOutputStream out = new FileOutputStream(realSavePath + "\\" + saveFilename);
                    //创建一个缓冲区
                    byte buffer[] = new byte[1024];
                    //判断输入流中的数据是否已经读完的标识
                    int len = 0;
                    //循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
                    while((len=in.read(buffer))>0){
                        //使用FileOutputStream输出流将缓冲区的数据写入到指定的目录(savePath + "\\" + filename)当中
                        out.write(buffer, 0, len);
                    }
                    //关闭输入流
                    in.close();
                    //关闭输出流
                    out.close();
                    //删除处理文件上传时生成的临时文件
                    //item.delete();

                    Map<String,Object> map = new HashMap<>();
                    map.put("accessory_name",filename);
                    map.put("accessory_url",realSavePath);

                    Map user = (Map) session.getAttribute("user");
                    String name = (String) user.get("emp_name");

                    System.out.println(recipients);
                    System.out.println(title);
                    System.out.println(content);
                    System.out.println(typeid);
                    map.put("recipients",recipients);
                    map.put("title",title);
                    map.put("content",content);
                    map.put("typeid",typeid);
                    map.put("name",name);

                    System.out.println(map);

                    emailService.writeEmailWithAcc(map);

                    renderData(response,"邮件发送成功！");

                }
            }
        }catch (FileUploadBase.FileSizeLimitExceededException e) {
            e.printStackTrace();
            renderData(response,"单个附件超出最大值");
            return;
        }catch (FileUploadBase.SizeLimitExceededException e) {
            e.printStackTrace();
            renderData(response,"上传附件的总的大小超出限制的最大值");
            return;
        }catch (Exception e) {
            e.printStackTrace();
            renderData(response,"附件上传失败");
            return;
        }
    }


    /**
     * @Method: makeFileName
     * @Description: 生成上传文件的文件名，文件名以：uuid+"_"+文件的原始名称
     * @param filename 文件的原始名称
     * @return uuid+"_"+文件的原始名称
     */
    private String makeFileName(String filename){  //2.jpg
        //为防止文件覆盖的现象发生，要为上传文件产生一个唯一的文件名
        return UUID.randomUUID().toString() + "_" + filename;
    }

    /**
     * 为防止一个目录下面出现太多文件，要使用hash算法打散存储
     * @Method: makePath
     * @Description:
     *
     * @param filename 文件名，要根据文件名生成存储目录
     * @param savePath 文件存储路径
     * @return 新的存储目录
     */
    private String makePath(String filename,String savePath){
        //得到文件名的hashCode的值，得到的就是filename这个字符串对象在内存中的地址
        int hashcode = filename.hashCode();
        //0--15
        int dir1 = hashcode&0xf;
        //0-15
        int dir2 = (hashcode&0xf0)>>4;
        //构造新的保存目录
        //upload\2\3  upload\3\5
        String dir = savePath + "\\" + dir1 + "\\" + dir2;
        //File既可以代表文件也可以代表目录
        File file = new File(dir);
        //如果目录不存在
        if(!file.exists()){
            //创建目录
            file.mkdirs();
        }
        return dir;
    }


    /**
     * 下載附件
     * @Param: []
     * @Return: void
     * @Date: 2019/9/20 8:11
     */
    @ResponseBody
    @RequestMapping(value = "downloadaccessory", method = RequestMethod.POST)
    public void downloadaccessory(@Param("fileUrl") String fileUrl, @Param("fileName") String fileName, HttpServletResponse response,HttpSession session) throws IOException {
        Email email = (Email) session.getAttribute("accessory");
        System.out.println(email.getAccessory_url());
        System.out.println(email.getAccessory_name());
//        System.out.println(fileUrl);
//        System.out.println(fileName);
//
        String path = email.getAccessory_url()+"\\"+email.getAccessory_name();
//        System.out.println("路径");
//        System.out.println(path);

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

//    /**
//     * 查询所有用户
//     * @param model
//     */
//    @ResponseBody
//    @RequestMapping("showAllEmp")
//    public List<Map<String,Object>> showAllEmp(Model model,HttpServletResponse response){
//        System.out.println(emailService.showAllEmp());
//        List<Map<String,Object>> employees = emailService.showAllEmp();
//        model.addAttribute("emp",employees);
//        return employees;
//    }


    /**
     * 专门用于发送信息的方法
     * @param response
     * @param data
     * @throws IOException
     */
    private void renderData(HttpServletResponse response, String data) throws IOException {

        response.setContentType("text/plain;charset=UTF-8");
        //发送信息
        response.getWriter().write(data);

    }
}
