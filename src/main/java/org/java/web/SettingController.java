package org.java.web;

import org.apache.shiro.crypto.hash.Md5Hash;
import org.java.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: 你的小张同志
 * Date: 2019/9/23 16:24
 */
@Controller
public class SettingController {

    @Autowired
    private FileService fileService;

    @ResponseBody
    @RequestMapping(value = "/updPwd", method = RequestMethod.POST)
    public void updPwd(String password, HttpServletResponse response,HttpSession session) throws IOException {

//        System.out.println(password);

        String salt= "accp";

        Md5Hash md5 = new Md5Hash(password,salt,3);

//        System.out.println(md5.toString());

        String pwd = md5.toString();

        //
        //
        //划重点，从session中取值
        //
        //
        Map user = (Map) session.getAttribute("user");
        String emp_name = (String) user.get("emp_name");
//        String emp_name = "刘强东";
        //
        //
        //
        //
        //

//        Map<String,Object> map = new HashMap<>();
//
//        map.put("pwd",pwd);
//        map.put("emp_name",emp_name);

        fileService.updPwd(pwd,emp_name);

        renderData(response,"成功");

    }

    @ResponseBody
    @RequestMapping(value = "/updName", method = RequestMethod.POST)
    public void updName(String name, HttpServletResponse response, HttpSession session) throws IOException {

//        System.out.println(name);

        //
        //
        //划重点，从session中取值
        //
        //
        Map user = (Map) session.getAttribute("user");
        String emp_name = (String) user.get("emp_name");
//        String emp_name = "刘强东";
        //
        //
        //
        //
        //

//        Map<String,Object> map = new HashMap<>();
//
//        map.put("name",name);
//        map.put("emp_name",emp_name);

        fileService.updName(name,emp_name);

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
