package org.java.service.impl;

import org.java.dao.ScheduleMapper;
import org.java.service.ScheduleService;
import org.java.vo.ScheduleVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
    ScheduleMapper scheduleMapper;

	@Override
	public int add(ScheduleVO scheduleVO) {
		return scheduleMapper.insert(scheduleVO);
	}

	@Override
	public int updateByPrimaryKey(ScheduleVO scheduleVO) {
		return scheduleMapper.updateByPrimaryKey(scheduleVO);
	}

	@Override
	public List<ScheduleVO> lis(String emp_name) {
		return scheduleMapper.list(emp_name);
	}

	@Override
	public int del(Integer primaryKey,String emp_name) {
		return scheduleMapper.deleteByPrimaryKey(primaryKey,emp_name);
	}

}
