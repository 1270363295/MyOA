package org.java.service;

import java.util.List;
import java.util.Map;

/**
 * @author ：温戴
 * @date ：Created in 2019/9/27 19:53
 * @description：
 */

public interface HistoryService {

    void  addHis(Map map);

    List<Map> selectHis(Integer id);
}
