package org.java.web;

import org.java.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    //分页
    @RequestMapping(value = "/show",produces="application/json;charset=utf-8")
    @ResponseBody
    public Map show(@RequestParam("page")int page,@RequestParam("limit") int limit){
        Map map=new HashMap();
        //最大的总行数
        Integer total = departmentService.selTotal();
        int Maxtotal=(total-1)/limit+1;
        List<Map> list = departmentService.showAll((page-1)*limit,limit);
        map.put("data", list);
        map.put("code", 0);
        map.put("count",total);
        return  map;
    }
    //添加
    @RequestMapping(value = "addDepart",method=RequestMethod.POST,produces="text/plain;charset=utf-8")
    @ResponseBody
    public  String addDepart(@RequestParam("name") String name,@RequestParam("phone") String phone,
                             @RequestParam("fax") String fax ) {
        Map trem = new HashMap();
        trem.put("name", name);
        trem.put("phone", phone);
        trem.put("fax", fax);
        boolean flag = departmentService.addDepart(trem);

        if (flag==true){
            return "添加成功";
        }else {
            return "添加失败";
        }

    }
    //删除
    @RequestMapping("delByid1/{dep_id}")
    @ResponseBody
    public  Map<String,Object> delByid(@PathVariable("dep_id") int id) {
        boolean flag = departmentService.delByid(id);
        Map map = new HashMap();
        map.put("flag", flag);
        return map;
    }
    //修改
    @ResponseBody
    @RequestMapping(value ="updateData",method =RequestMethod.POST,produces="text/plain;charset=utf-8")
    public  String updateData(@RequestParam("name") String name,@RequestParam("phone") String phone,
                              @RequestParam("fax") String fax,@RequestParam("id") int id) {
        Map data = new HashMap();
        data.put("name", name);
        data.put("phone", phone);
        data.put("fax", fax);
        data.put("id",id);
        boolean flag = departmentService.updateDate(data);

        if (flag==true){
            return "修改成功";
        }else {
            return "修改成功";
        }

    }

}
