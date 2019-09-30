package org.java.service;

import java.util.List;
import java.util.Map;

/**
 * @author ：温戴
 * @date ：Created in 2019/9/24 18:26
 * @description：
 */

public interface BumphService {

    void  addBumph(Map map);

    List<Map> finfPage(Map map);

    int  findCount(Map map);

    //查询个人的当前的任务
    List<Map> findBumph(Map map);

    int findCountBumph(Map map);
    //完成任务
    void updTask(Integer id,Integer state);
    //删除
    void delTask(Integer id);
    //修改个人任务
    void updBumph(Map map);

    //查询领导的任务
    List<Map> selectMAngerTask(Map map);
    int MangerTaskCount(Map map);

    //查询公文
    Map findByTd(Integer id);
}
