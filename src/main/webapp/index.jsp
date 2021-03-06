<%--
  Created by IntelliJ IDEA.
  User: wed12
  Date: 2019/9/3
  Time: 17:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <title>办公自动化系统</title>

    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>

</head>
<body>

<!-- 顶部开始 -->
<div class="container">
    <div class="logo">
        <a href="./index.jsp">OA办公自动化系统</a>
    </div>
    <div class="left_open">
        <!-- <i title="展开左侧栏" class="iconfont">&#xe699;</i> -->
        <i title="展开左侧栏" class="layui-icon layui-icon-shrink-right"></i>
  <%--定位当前位置--%>
    </div>
    <ul class="layui-nav left fast-add" lay-filter="">
        <li class="layui-nav-item">
            <div class="weather" pc>
                <div id="tp-weather-widget"></div>
                <script>(function(T,h,i,n,k,P,a,g,e){g=function(){P=h.createElement(i);a=h.getElementsByTagName(i)[0];P.src=k;P.charset="utf-8";P.async=1;a.parentNode.insertBefore(P,a)};T["ThinkPageWeatherWidgetObject"]=n;T[n]||(T[n]=function(){(T[n].q=T[n].q||[]).push(arguments)});T[n].l=+new Date();if(T.attachEvent){T.attachEvent("onload",g)}else{T.addEventListener("load",g,false)}}(window,document,"script","tpwidget","//widget.seniverse.com/widget/chameleon.js"))</script>
                <script>tpwidget("init", {
                    "flavor": "slim",
                    "location": "WX4FBXXFKE4F",
                    "geolocation": "enabled",
                    "language": "zh-chs",
                    "unit": "c",
                    "theme": "chameleon",
                    "container": "tp-weather-widget",
                    "bubble": "disabled",
                    "alarmType": "badge",
                    "color": "#FFFFFF",
                    "uid": "U9EC08A15F",
                    "hash": "039da28f5581f4bcb5c799fb4cdfb673"
                });
                tpwidget("show");</script>
            </div>
        </li>
    </ul>

    <ul class="layui-nav right" lay-filter="">
        <li class="layui-nav-item">
            <a href="javascript:;">
                <img src="img/face.jpg" width="35" height="35" class="layui-circle">
               <c:if test="${user.duty_id==1}">
                  [董事长]${user.emp_name}
               </c:if>
                <c:if test="${user.duty_id==2}">
                    [部门主管]${user.emp_name}
                </c:if>
                <c:if test="${user.duty_id==3}">
                    [部门经理]${user.emp_name}
                </c:if>
                <c:if test="${user.duty_id==4}">
                    [普通员工]${user.emp_name}
                </c:if>

            </a>
            <dl class="layui-nav-child">
                <!-- 二级菜单 -->
                <dd>
                    <a onclick="WeAdminShow('个人信息','#')">个人信息</a>
                </dd>
                <dd>
                    <a onclick="WeAdminShow('切换帐号','./login.jsp')">切换帐号</a>
                </dd>
                <dd>
                    <a class="loginout" href="${pageContext.request.contextPath}/logout.do">退出</a>
                </dd>
            </dl>
        </li>
        <li class="layui-nav-item to-index">
            <a href="https://www.jiuwei.com/" target="_blank">前台首页</a>
        </li>
    </ul>

</div>
<!-- 顶部结束 -->
<!-- 中部开始 -->
<!-- 左侧菜单开始 -->
<div class="left-nav">
    <div id="side-nav">

    </div>
</div>
<!-- <div class="x-slide_left"></div> -->
<!-- 左侧菜单结束 -->
<!-- 右侧主体开始 -->
<div class="page-content">
    <div class="layui-tab tab" lay-filter="wenav_tab" id="WeTabTip" lay-allowclose="true">
        <ul class="layui-tab-title" id="tabName">
            <li>我的桌面</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <iframe src='./pages/welcome.jsp' frameborder="0" scrolling="yes" class="weIframe"></iframe>
            </div>
        </div>
    </div>
</div>
<div class="page-content-bg"></div>
<!-- 右侧主体结束 -->
<!-- 中部结束 -->
<!-- 底部开始 -->
<div class="footer">
    <div class="copyright">Copyright ©2018 WeAdmin v1.0 All Rights Reserved</div>
</div>

<!--Tab菜单右键弹出菜单-->
<ul class="rightMenu" id="rightMenu">
    <li data-type="fresh">刷新</li>
    <li data-type="current">关闭当前</li>
    <li data-type="other">关闭其它</li>
    <li data-type="all">关闭所有</li>
</ul>

<!-- 底部结束 -->
<script type="text/javascript">
    //			layui扩展模块的两种加载方式-示例
    //		    layui.extend({
    //			  admin: '{/}../../static/js/admin' // {/}的意思即代表采用自有路径，即不跟随 base 路径
    //			});
    //			//使用拓展模块
    //			layui.use('admin', function(){
    //			  var admin = layui.admin;
    //			});
    layui.config({
        base: '${pageContext.request.contextPath}/static/js/'
        ,version: '101100'
    }).extend({ //设定模块别名
        admin: 'admin'
        ,menu: 'menu'
    });
    layui.use(['jquery', 'admin', 'menu'], function(){
        var $ = layui.jquery,
            admin = layui.admin,
            menu = layui.menu;


        $(function(){
            /*加载菜单栏*/
         menu.getMenu('${pageContext.request.contextPath}/json/menu.json');

            $.ajax({
                url:"${pageContext.request.contextPath}/first.do",
                dataType:"text",
                success:function(data){

                }
            });
        });
    });

</script>

</body>
</html>
