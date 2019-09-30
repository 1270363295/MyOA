package org.java.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface DepartmentMapper {
    //查询所有分页显示
    public List<Map> showAll(@Param("page") int page, @Param("limit") int limit);
    //查询所有总行数
    public  Integer selTotal();
    //添加
    public int  addDepart(@Param("map") Map term);
    //删除
    public  int delByid(@Param("id") int id);
    //修改
    public  int updateDate(@Param("map") Map data);

    //查询所有的部门信息
    public  List<Map> selDepartName();

}
