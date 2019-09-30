package org.java.service.impl;

import org.java.dao.DepartmentMapper;
import org.java.dao.EmployeeMapper;
import org.java.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
@Service
public class DepartmentServiceImpl implements DepartmentService {


    @Autowired
    private DepartmentMapper departmentMapper;
    @Autowired
    private EmployeeMapper employeeMapper;

    //查询总行数
    @Override
    public Integer selTotal() {
        return departmentMapper.selTotal();
    }

    @Override
    public boolean delByid(int id) {

        boolean flag=false;
        //如果部门下面有功则不猛删除
        if(employeeMapper.selexist(id)>0){

            flag=false;
        }else {
            //如果删除成功，返回true，删除失败返回false
            if (departmentMapper.delByid(id) > 0) {
                flag=true;

            } else {
                flag=false;
            }
        }
        return flag;
    }

    //修改
    @Override
    public boolean updateDate(Map data) {
        if (departmentMapper.updateDate(data)>0){
            return true;
        }else {
            return  false;
        }
    }

    @Override
    //如果添加成功，返回true，删除失败返回false
    public boolean  addDepart(Map term) {
        if (departmentMapper.addDepart(term)>0){
            return true;
        }else {
            return  false;
        }

    }

    //显示所有带分页
    @Override
    public List<Map> showAll(int page, int limit) {

        return departmentMapper.showAll(page,limit);
    }
}
