package org.java.realm;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.java.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Map;

/**
 * @author ：温戴
 * @date ：Created in 2019/9/16 15:08
 * @description：shiro授权认证
 */
public class MyRealm extends AuthorizingRealm {
    @Autowired
    private EmployeeService employeService;
    //授权
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        return null;
    }

    //认证
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        System.out.println("------进入认证-------");
        //获取用户名
        String name=(String)token.getPrincipal();
        System.out.println(".............."+name);
        //判断用户名是否存在
        Map<String, Object> map = employeService.selectEmp(name);
        if (map == null) {
            //用户名不存在
            return  null;
        }
        String pwd =(String)map.get("emp_pwd");
        //指定盐
        String salt = "accp";
        //返回认证的对象
        SimpleAuthenticationInfo info=new SimpleAuthenticationInfo(map,pwd,ByteSource.Util.bytes(salt),"myreal");
        return info;
    }
}
