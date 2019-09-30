package org.java.service.impl;

import org.java.dao.HistoryMapper;
import org.java.service.HistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author ：温戴
 * @date ：Created in 2019/9/27 19:53
 * @description：
 */
@Service
public class HistoryServiceImpl implements HistoryService {
    @Autowired
    private HistoryMapper historyMapper;
    @Override
    public void addHis(Map map) {
          historyMapper.addComment(map);
    }

    @Override
    public List<Map> selectHis(Integer id) {
        List<Map> list = historyMapper.selectHistoryById(id);
        return list;
    }
}
