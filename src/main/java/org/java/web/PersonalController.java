package org.java.web;

import org.apache.commons.lang.RandomStringUtils;
import org.java.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Date;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: 你的小张同志
 * Date: 2019/9/23 11:31
 */
@Controller
public class PersonalController {

    @Autowired
    private FileService fileService;

    /**
     * 注释的代码可以忽略
     * @throws
     */
    @RequestMapping(value="/uploadPhoto",method = RequestMethod.POST)
    @ResponseBody
    public String cropper(@RequestParam("file") String file,
                          HttpServletRequest request, HttpSession session) throws Exception {

        Decoder decoder = Base64.getDecoder();
        // 去掉base64编码的头部 如："data:image/jpeg;base64," 如果不去，转换的图片不可以查看
        file = file.substring(23);
        //解码
        byte[] imgByte = decoder.decode(file);

            /*//在tomcat目录下创建picture文件夹保存图片
            String path = request.getSession().getServletContext()
                    .getRealPath("");
            String contextPath = request.getContextPath();
            path = path.replace(contextPath.substring(1), "")  + "picture";
            File dir = new File(path);
            if (!dir.exists()) {// 判断文件目录是否存在
                dir.mkdirs();
            }
                    //因为windows和linux路径不同，window：D:\dir   linux:opt/java
            //System.getProperty("file.separator")能根据系统的不同获取文件路径的分隔符
            String fileName = getFileName();
            path = path + System.getProperty("file.separator") + fileName;
                    */

        try {
            //
            //
            //划重点，从session中取值
            //
            Map user = (Map) session.getAttribute("user");
            String emp_name = (String) user.get("emp_name");
//            String emp_name = "刘强东";
            //
            //
            //
            //
            //
            String emp_photo="E:\\文件上传\\头像\\"+emp_name+".jpg";
            //输出文件路径
            FileOutputStream out = new FileOutputStream(emp_photo);
            out.write(imgByte);
            out.close();

            fileService.updEmp_photo(emp_photo,emp_name);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "success";

            /*String url = request.getScheme() + "://" + request.getServerName()
                    + ":" + request.getServerPort() + "/picture/" + fileName;
            return url; */
    }

    /**
     * 创建文件名称 内容：时间戳+随机数
     *
     * @param @return
     * @throws
     */
    private String getFileName() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String timeStr = sdf.format(new Date());
        String str = RandomStringUtils.random(5,
                "abcdefghijklmnopqrstuvwxyz1234567890");
        String name = timeStr + str + ".jpg";
        return name;
    }

}
