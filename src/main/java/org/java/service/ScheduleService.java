package org.java.service;

import org.java.vo.ScheduleVO;

import java.util.List;

public interface ScheduleService {

	public int add(ScheduleVO scheduleVO);

	public int updateByPrimaryKey(ScheduleVO scheduleVO);

	public List<ScheduleVO> lis(String emp_name);

	public int del(Integer primaryKey, String emp_name);
}
