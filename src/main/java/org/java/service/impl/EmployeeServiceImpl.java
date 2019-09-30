package org.java.service.impl;

import org.java.dao.DepartmentMapper;
import org.java.dao.DutyMapper;
import org.java.dao.EmployeeMapper;
import org.java.dao.EmployeestatusMapper;
import org.java.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author ：温戴
 * @date ：Created in 2019/9/18 18:38
 * @description：
 */
@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;
    @Override
    public Map<String, Object> selectEmp(String name) {
        Map<String, Object> map = employeeMapper.selectEmp(name);
        return map;
    }
    @Autowired
    private DepartmentMapper departmentMapper;
    @Autowired
    private DutyMapper dutyMapper;
    @Autowired
    private EmployeestatusMapper employeestatusMapper;

    //查询所有的部门信息
    @Override
    public List<Map> selDepartName() {
        return departmentMapper.selDepartName();
    }
    //查询所有的员工的职位
    @Override
    public List<Map> selDutyName() {
        return dutyMapper.selDutyName();
    }
    //查询所有的员工的在职信息
    @Override
    public List<Map> selStaName() {
        return employeestatusMapper.selStaName();
    }

    @Override
    public List<Map> showAll(int page, int limit) {
        return employeeMapper.showAll(page,limit);
    }
    //查询总行数
    @Override
    public Integer selTotal() {
        return employeeMapper.selTotal();
    }

    @Override
    public List<Map> inquire(int page, int limit, Map condition) {

        return employeeMapper.inquire(page, limit, condition);

    }

    @Override
    public void addEmp(Map term) {

        employeeMapper.addEmp(term);

    }

    @Override
    public void delByid(int id) {
        employeeMapper.delByid(id);

    }

    @Override
    public void updateEmp(Map data) {
        employeeMapper.updateEmp(data);
    }

    @Override
    public List<Map> selByid(int id) {
        return employeeMapper.selByid(id);
    }

    @Override
    public List<Integer> selSex() {
        return employeeMapper.selSex();
    }

}
