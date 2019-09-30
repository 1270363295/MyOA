package org.java.service;

import java.util.List;
import java.util.Map;

public interface DepartmentService {
  //查询所有部门
    public List<Map> showAll(int page, int limit);
    //添加
   public  boolean  addDepart(Map term);
  //查询总页数
   public  Integer selTotal();
  //删除
    public  boolean delByid(int id);
    //修改
  public  boolean  updateDate(Map data);

}
