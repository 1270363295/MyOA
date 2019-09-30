package org.java.web;

import org.java.service.ScheduleService;
import org.java.vo.ScheduleVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * 日程相关接口
 * 
 * @author 40279
 *
 */
@Controller
@RequestMapping("schedule")
public class ScheduleController {

	@Autowired
	private ScheduleService scheduleService;

	@ResponseBody
	@PostMapping("add.do")
	public Integer add(ScheduleVO scheduleVO, HttpSession session) {
		Map user = (Map) session.getAttribute("user");
		String emp_name = (String) user.get("emp_name");
		scheduleVO.setEmp_name(emp_name);
		return scheduleService.add(scheduleVO);
	}

	@ResponseBody
	@GetMapping("list.do")
	public List<ScheduleVO> list(HttpSession session) throws Exception {
		Map user = (Map) session.getAttribute("user");
		String emp_name = (String) user.get("emp_name");
//		String emp_name="刘强东";
		return scheduleService.lis(emp_name);
	}

	@ResponseBody
	@PostMapping("update.do")
	public Integer update(ScheduleVO scheduleVO,HttpSession session) {
//		System.out.println(JSONObject.toJSONString(scheduleVO));
		Map user = (Map) session.getAttribute("user");
		String emp_name = (String) user.get("emp_name");
		scheduleVO.setEmp_name(emp_name);
		return scheduleService.updateByPrimaryKey(scheduleVO);
	}

	@ResponseBody
	@PostMapping("del.do")
	public Integer del(Integer id,HttpSession session) {
		Map user = (Map) session.getAttribute("user");
		String emp_name = (String) user.get("emp_name");
//		String emp_name="刘强东";
		return scheduleService.del(id,emp_name);
	}
}
