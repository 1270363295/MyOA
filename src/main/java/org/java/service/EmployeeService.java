package org.java.service;

import java.util.List;
import java.util.Map;

/**
 * @author ：温戴
 * @date ：Created in 2019/9/17 19:33
 * @description：员工的service
 */

public interface EmployeeService {
    Map<String,Object> selectEmp(String name);

    public List<Map> showAll(int page, int limit);
    //查询总页数
    public  Integer selTotal();
    //查询所有的部门信息
    public  List<Map> selDepartName();
    //查询所有的员工的职位
    public List<Map> selDutyName();
    //查询所有的员工的在职信息
    public List<Map> selStaName();
    //查询所有的性别
    public List<Integer> selSex();

    List<Map> inquire(int page, int limit, Map condition);
    //添加
    public void  addEmp( Map term);
    //删除
    public  void delByid( int id);
    //修改
    public  void updateEmp( Map data);

    //根据id查询员工信息
    public  List<Map> selByid( int id);
}
