package org.java.web;

import org.java.service.BumphService;
import org.java.service.HistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author ：温戴
 * @date ：Created in 2019/9/24 18:18
 * @description：公文的controller
 */
@Controller
public class BumphController {
    @Autowired
    private BumphService bumphService;

    @Autowired
    private HistoryService historyService;
    //添加任务
    @RequestMapping("addbump")
    public String addBumph(@RequestParam Map map, HttpSession session) {
        Map user = (Map) session.getAttribute("user");
        int userid = (int) user.get("emp_id");
        int dep_id = (int) user.get("dep_id");
        map.put("time", new Date());
        map.put("userid", userid);
        map.put("state", 0);
        map.put("dep_id", dep_id);
        System.out.println(map);
        bumphService.addBumph(map);

        return "/pages/order/add";
    }

    //分页
    @RequestMapping("listPage")
    @ResponseBody
    public Map loadPage(@RequestParam Map map, HttpSession session) {
        System.out.println("参数-----------------------"+map);
        Map user = (Map) session.getAttribute("user");
        //设置用户只能查询当前部门的公文
        int dep_id = (int) user.get("dep_id");
        map.put("dep_id", dep_id);

        //获取总行数
        Integer count = bumphService.findCount(map);
        //每页多少条
        Integer size = Integer.parseInt(map.get("limit").toString());
        //当前页数
        Integer pageNo = Integer.parseInt(map.get("page").toString());
        //总页数
        Integer pageCount = (count - 1) / size + 1;

        Integer page = (pageNo - 1) * size;

        map.put("page", page);
        map.put("size", size);
        //获取分页的数据
        List<Map> list = bumphService.finfPage(map);
        //组装json

        Map<String, Object> map2 = new HashMap<String, Object>();
        map2.put("code", 0);
        map2.put("msg", "");
        map2.put("count", count);
        map2.put("data", list);

        return map2;

    }

    //查询个人当前的未提交任务 分页
    @RequestMapping("currentTask")
    @ResponseBody
    public Map listBumph(@RequestParam Map map, HttpSession session) {
        Map user = (Map) session.getAttribute("user");
        int emp_id = (int) user.get("emp_id");


        //设置当前的用户
        map.put("emp_id", emp_id);

        //获取总行数
        Integer count = bumphService.findCountBumph(map);
        //每页多少条
        Integer size = Integer.parseInt(map.get("limit").toString());
        //当前页数
        Integer pageNo = Integer.parseInt(map.get("page").toString());
        //总页数
        Integer pageCount = (count - 1) / size + 1;

        Integer page = (pageNo - 1) * size;

        map.put("page", page);
        map.put("size", size);
        //获取分页的数据
        List<Map> list = bumphService.findBumph(map);
        //组装json

        Map<String, Object> map2 = new HashMap<String, Object>();
        map2.put("code", 0);
        map2.put("msg", "");
        map2.put("count", count);
        map2.put("data", list);

        return map2;
    }

    //提交任务
    @RequestMapping("completeTask/{id}")
    @ResponseBody
    public String completeTask(@PathVariable("id") Integer id) {

        //代表部门经理审核
        int state = 1;
        bumphService.updTask(id, state);
        return "pages/order/achive";
    }

    //删除任务
    @RequestMapping("delTask/{id}")
    @ResponseBody
    public String delTask(@PathVariable("id") Integer id) {
        bumphService.delTask(id);
        return "ok";
    }

    //修改任务
    @RequestMapping("updbump")
    public String updaBumph(@RequestParam Map map) {

        System.out.println("修改的任务" + map);

        bumphService.updBumph(map);

        return "pages/order/add";
    }

    //领导审核任务
    @RequestMapping("MangerTask")
    @ResponseBody
    public Map taskMager(HttpSession session, @RequestParam Map map) {
        //获取当前管理的职务id 和 部门id
        Map user = (Map) session.getAttribute("user");
        //职务id   2部门主管      3部门经理
        int duty_id = (int) user.get("duty_id");
        //获取部门
        int dep_id = (int) user.get("dep_id");
        int stateid = 0;
        if (duty_id == 2) {
            //查询主管  状态为2
            stateid = 2;
        } else if (duty_id == 3) {
            //查询 部门经理 状态为 1
            stateid = 1;
        }

        //获取数据
        map.put("dep_id", dep_id);
        map.put("stateid", stateid);

        //获取总行数
        Integer count = bumphService.MangerTaskCount(map);
        //每页多少条
        Integer size = Integer.parseInt(map.get("limit").toString());
        //当前页数
        Integer pageNo = Integer.parseInt(map.get("page").toString());
        //总页数
        Integer pageCount = (count - 1) / size + 1;

        Integer page = (pageNo - 1) * size;

        map.put("page", page);
        map.put("size", size);
        //获取分页的数据
        List<Map> list = bumphService.selectMAngerTask(map);
        //组装json

        Map<String, Object> map2 = new HashMap<String, Object>();
        map2.put("code", 0);
        map2.put("msg", "");
        map2.put("count", count);
        map2.put("data", list);

        return map2;
    }
    //审核中转
    @RequestMapping("/comment/{id}")
    public  String loadCommet(@PathVariable("id") Integer id,Model model){
        //查询公文的信息
        Map map = bumphService.findByTd(id);
        model.addAttribute("map", map);
        //返回显示的页面
        return  "/pages/order/comment";
    }

    //添加历史信息   同意
    @RequestMapping("comment")
    @ResponseBody
    public String addHist(@RequestParam Map map,HttpSession session) {
          //历史表添加一条信息
        Map user = (Map) session.getAttribute("user");
        //审核人
        int emp_id = (int) user.get("emp_id");
        //获取职位信息
        int duty_id = (int) user.get("duty_id");
        System.out.println("职位信息："+duty_id);
        Integer state=null;
        //主管身份
        if (duty_id==2){
            state=3;
            //部门经理身份
        }else if (duty_id==3){
            state=2;
        }

        map.put("emp_id", emp_id);
        map.put("time", new Date());
        historyService.addHis(map);
        //获取公文id
        Integer  id= Integer.parseInt(map.get("id").toString());
        //修改公文表的审核状态
        bumphService.updTask(id,state);
        return  "ok";
    }
    //驳回事件
    @RequestMapping("reject")

    public String  reject(@RequestParam Map map,HttpSession session){
        System.out.println(map);
        //历史表添加一条信息
        Map user = (Map) session.getAttribute("user");
        int emp_id = (int) user.get("emp_id");
        map.put("emp_id", emp_id);
        map.put("time", new Date());
        historyService.addHis(map);
        //获取公文id
        Integer  id= Integer.parseInt(map.get("id").toString());
        //修改公文表的审核状态   重新提交
        bumphService.updTask(id,0);
        return  "ok";
    }
    //查看审核意见
    @RequestMapping("/TaskComment/{id}")
    public String taskComment(@PathVariable("id") Integer id,Model model){

        model.addAttribute("id", id);

        return  "/pages/order/history";
    }

    //加载历史信息
    @RequestMapping("showHis")
    @ResponseBody
    public  Map loadHis(@RequestParam Map map){

        Integer id = Integer.parseInt(map.get("id").toString());
        //从历史表中查询审核信息
        List<Map> list = historyService.selectHis(id);

        Map<String, Object> map2 = new HashMap<String, Object>();
        map2.put("code", 0);
        map2.put("msg", "");
        map2.put("count", list.size());
        map2.put("data",list);
        return  map2;
    }

}
