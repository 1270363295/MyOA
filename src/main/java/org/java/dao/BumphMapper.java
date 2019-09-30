package org.java.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author ：温戴
 * @date ：Created in 2019/9/24 18:19
 * @description：
 */
public interface BumphMapper {
      //添加公文
     void addBumph(Map map);
       //查询分页
     List<Map> findPage(Map map);

    //查总条数
    int findCount(Map map);

     //查询个人的任务
     List<Map>  findBumph(Map map);

     //查询个人任务 总数
     int  findCountBumph(Map map);
     //修改状态
     void updateState(@Param("id") Integer id,@Param("state") Integer state);

     //删除任务
      void delTask(Integer id);
      //修改任务
      void  updateBumph(Map map);
       //查询领导任务
      List<Map>  MangerTask(Map map);
      //查询领导任务总条数
      int  MangerTaskCount(Map map);
      //查询公文
       Map selectById(Integer id);
}
