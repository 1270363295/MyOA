package org.java.web;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.java.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author ：温戴
 * @date ：Created in 2019/9/16 18:31
 * @description：用户的控制器
 */
@Controller
@MultipartConfig
public class EmployeeController {
    @Autowired
    private ServletContext cxt;

    @Autowired
    private EmployeeService employeeService;

    //跳转到登陆页面
    //认证失败也会跳转到该界面
    @RequestMapping("login")
    public String login(HttpServletRequest request, Model model) throws Exception {
        String msg = (String) request.getAttribute("shiroLoginFailure");
        System.out.println("-----------------------------" + msg);
        if (msg != null) {
            //用户登录失败进入
            if (msg.endsWith("UnknownAccountException")) {
                throw new Exception("用户名不存在！");
            }
            if (msg.endsWith("IncorrectCredentialsException")) {
                throw new Exception("密码错误！");
            }
        }
        //跳转到登录界面
        return "login";
    }

    //登陆成功后跳转
    @RequestMapping("first")
    public String go(HttpSession session) {
        System.out.println("--------------登陆成功后进入");
        Subject subject = SecurityUtils.getSubject();  //获得认证的主体
        //从主体中获取用户的信息
        Map map= (Map) subject.getPrincipal();

        session.setAttribute("user",map);
        //获取用户信息
        System.out.println(map);
        return "index";
    }
    //分页
    @RequestMapping(value="showAll",produces="application/json;charset=utf-8")
    @ResponseBody
    public  Map showAll(@RequestParam("page")int page, @RequestParam("limit") int limit){
        Map map=new HashMap();
        Integer count=employeeService.selTotal();
        int Max=(count-1)/limit+1;
        List<Map> list=employeeService.showAll((page-1)*limit,limit);
        map.put("data",list);
        map.put("count",count);
        map.put("code",0);
        return  map;
    }


    @RequestMapping(value="/info")
    @ResponseBody
    public Map selInfo(){
        Map map=new HashMap();
        List<Map> depart=employeeService.selDepartName();
        List<Map> sta=employeeService.selStaName();
        List<Map> duty=employeeService.selDutyName();
        List<Integer> sex=employeeService.selSex();
        map.put("depart",depart);
        map.put("duty",duty);
        map.put("sta",sta);
        map.put("sex",sex);
        map.put("code",0);
        return  map;
    }

    //多条件查询带分页
    @RequestMapping(value="inquire",produces ="application/json;charset=utf-8")
    @ResponseBody
    public Map inquire(@RequestParam("page")int page, @RequestParam("limit") int limit,
                       @RequestParam("name") String name , @RequestParam("depid")String depid , @RequestParam("geender")String geender  ){
        Map map=new HashMap();
        Integer count=employeeService.selTotal();
        int Max=(count-1)/limit+1;
        Map condition=new HashMap();
        condition.put("name", name);
        condition.put("depid", depid);
        condition.put("geender", geender);
        List<Map> list=employeeService.inquire((page-1)*limit,limit,condition);
        map.put("data",list);
        map.put("count",count);
        map.put("code",0);
        return  map;
    }

    @RequestMapping(value="add")
    @ResponseBody
    public Map  add(@RequestParam(value = "id",required = false)Integer id ,@RequestParam("name") String name, @RequestParam("sex") int sex,
                    @RequestParam("email") String email, @RequestParam("uname") String uname, @RequestParam("pwd") String pwd,
                    @RequestParam("state") int  state, @RequestParam("duty") int  duty, @RequestParam("depart") int  depart
            , @RequestParam("img") String img, @RequestParam("remark") String remark
    ) {
        String path=cxt.getRealPath("upload");
        Map<String, Object> res = new HashMap<>();
        Map trem=new HashMap();
        trem.put("name", name);
        trem.put("sex", sex);
        trem.put("email", email);
        trem.put("uname", uname);
        trem.put("pwd", pwd);
        trem.put("state", state);
        trem.put("duty", duty);
        trem.put("depart", depart);
        trem.put("remark", remark);
        trem.put("img",path+img);
        res.put("data","");
        res.put("code",0);
        if(id==null){
            employeeService.addEmp(trem);
        }else {
            trem.put("id",id);
            employeeService.updateEmp(trem);
        }
        return res;
    }

    @RequestMapping(value = "/upload" ,method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> upload(@RequestParam("file") MultipartFile file
    ) throws IOException {
        //如果文件内容不为空，则写入上传路径
        Map<String, Object> res = new HashMap<>();
        if (!file.isEmpty()) {
            //上传文件路径
            String path=cxt.getRealPath("upload");
            System.out.println("文件名称:"+file.getOriginalFilename());
            //上传文件名
            String filename = file.getOriginalFilename();
            File filepath = new File(path, filename);

            //判断路径是否存在，没有就创建一个
            if (!filepath.getParentFile().exists()) {
                filepath.getParentFile().mkdirs();
            }

            //将上传文件保存到一个目标文档中
            File file1 = new File(path,filename);
            file.transferTo(file1);

            System.out.println(file1);
            //返回的是一个url对象
            res.put("url", file1);
            res.put("data","");
            res.put("code",0);
            return res;
        } else {
            res.put("data","");
            res.put("code",-1);
            return res;
        }

    }

    //根据id查询员工信息
    @RequestMapping("sel/{id}")
    public String selByid(@PathVariable("id") int id, Model model){
        // Map map=new HashMap();
        List<Map> list = employeeService.selByid(id);
//        map.put("emp",list);
//        map.put("code",0);
        model.addAttribute("emp",list);
        model.addAttribute("code",0);
        return "/pages/member/update";
    }
    //删除
    @RequestMapping(value ="delByid/{id}",method = RequestMethod.POST)
    @ResponseBody
    public  String delByid(@PathVariable("id") int id) {
        employeeService.delByid(id);
        return"删除成功";

    }

}
