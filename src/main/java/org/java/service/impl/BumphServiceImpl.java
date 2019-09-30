package org.java.service.impl;

import org.java.dao.BumphMapper;
import org.java.service.BumphService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author ：温戴
 * @date ：Created in 2019/9/24 18:26
 * @description：
 */
@Service
public class BumphServiceImpl implements BumphService {
    @Autowired
    private BumphMapper bumphMapper;

    @Override
    public void addBumph(Map map) {
        bumphMapper.addBumph(map);
    }

    //分页的方法
    @Override
    public List<Map> finfPage(Map map) {
        List<Map> list = bumphMapper.findPage(map);
        return list;
    }
    //总条数
    @Override
    public int findCount(Map map) {

        return bumphMapper.findCount(map);
    }

     //查询未提交任务分页
    @Override
    public List<Map> findBumph(Map map) {
        List<Map> list = bumphMapper.findBumph(map);
        return list;
    }

    //查询未提交任务总页数
    @Override
    public int findCountBumph(Map map) {
        int count = bumphMapper.findCountBumph(map);
        return count;
    }

    //完成任务
    @Override
    public void updTask(Integer id, Integer state) {
        bumphMapper.updateState(id,state);
    }

    //删除任务
    @Override
    public void delTask(Integer id) {
         bumphMapper.delTask(id);
    }

    //个人任务未提交前修改任务
    @Override
    public void updBumph(Map map) {
         bumphMapper.updateBumph(map);
    }

    //查询领导的任务
    @Override
    public List<Map> selectMAngerTask(Map map) {
        List<Map> list = bumphMapper.MangerTask(map);
        return list;
    }

    @Override
    public int MangerTaskCount(Map map) {
         int count=bumphMapper.MangerTaskCount(map);
        return count;
    }


    @Override
    public Map findByTd(Integer id) {
        Map map = bumphMapper.selectById(id);
        return map;
    }
}
