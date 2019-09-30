package org.java.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author ：温戴
 * @date ：Created in 2019/9/17 18:54
 * @description：员工的mapper
 */
public interface EmployeeMapper {
     Map<String,Object> selectEmp(@Param("name") String name);

     //查询该部门下面是否有员工
     public  int selexist(@Param("id") int id);
     public  List<Map> showAll(@Param("page") int page, @Param("limit") int limit);
     public  Integer selTotal();
     public List<Integer> selSex();
     public  List<Map> inquire(@Param("page") int page,@Param("limit") int limit,@Param("map")Map condition);
     //添加
     public int  addEmp(@Param("map") Map term);
     //删除
     public  int delByid(@Param("id") int id);
     //修改
     public  int updateEmp(@Param("map") Map data);

     //根据id查询员工信息
     public  List<Map> selByid(@Param("id") int id);
}
