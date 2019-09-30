package org.java.dao;

import org.apache.ibatis.annotations.Param;
import org.java.vo.ScheduleVO;

import java.util.List;

public interface ScheduleMapper {

	int insert(ScheduleVO scheduleVO);

	int updateByPrimaryKey(ScheduleVO scheduleVO);

	List<ScheduleVO> list(String emp_name);

	int deleteByPrimaryKey(@Param("id") Integer id, @Param("emp_name") String emp_name);

}
