package org.java.dao;

import java.util.List;
import java.util.Map;

/**
 * @author ：温戴
 * @date ：Created in 2019/9/27 19:45
 * @description：
 */
public interface HistoryMapper {
    //添加
    void addComment(Map map);
    //查询
    List<Map> selectHistoryById(Integer id);

}
