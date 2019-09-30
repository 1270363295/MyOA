<%@ page  isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>管理员登录-WeAdmin Frame型后台管理系统-WeAdmin 1.0</title>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>

</head>
<body class="login-bg">
    
    <div class="login">
        <div class="message">WeAdmin 1.0-管理登录</div>
        <div id="darkbannerwrap"></div>

        <%--使用shiro进行登录--%>
        <form method="post" action="${pageContext.request.contextPath}/login.do" class="layui-form" >
            <input name="username" placeholder="用户名"  type="text" lay-verify="required" class="layui-input" >
            <hr class="hr15">
            <input name="password" lay-verify="required" placeholder="密码"  type="password" class="layui-input">
            <hr class="hr15">
            <input class="loginin" value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit">
            <hr class="hr20" >
            <div style="color: red">
                 <%--这里输入登陆的错误信息--%>
                ${msg}
            </div>
        </form>
    </div>

    <script type="text/javascript">
        
        	layui.extend({
				admin: '${pageContext.request.contextPath}/static/js/admin'
			});
            layui.use(['form','admin'], function(){
              var form = layui.form
              	,admin = layui.admin;
              // layer.msg('玩命卖萌中', function(){
              //   //关闭后的操作
              //   });
              //监听提交

            });   
    </script>  
    <!-- 底部结束 -->
</body>
</html>