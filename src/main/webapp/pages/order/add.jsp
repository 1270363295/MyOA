<%--
  Created by IntelliJ IDEA.
  User: wed12
  Date: 2019/9/24
  Time: 16:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
    <meta charset="UTF-8">
    <title>添加订单-客户关系管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<div class="weadmin-nav">
			<span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">公文管理</a>
        <a><cite>公文草拟</cite></a>
      </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right"
       href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="weadmin-body">
    <%--公文草拟>--%>
    <div align="cneter">
        <form action="${pageContext.request.contextPath}/addbump.do" method="post" class="layui-form">

            <div class="layui-form-item">
                <label class="layui-form-label">草拟人</label>
                <div class="layui-input-block">
                    <input type="text" name="title" lay-verify="title" class="layui-input"
                           value="${sessionScope.user.emp_name}" disabled>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">所属部门</label>
                <div class="layui-input-block">
                    <c:if test="${user.dep_id==1}">
                        <input type="text" name="title" lay-verify="title" disabled value="开发部" class="layui-input">
                    </c:if>
                    <c:if test="${user.dep_id==2}">
                        <input type="text" name="title" lay-verify="title" disabled value="销售部" class="layui-input">
                    </c:if>
                    <c:if test="${user.dep_id==3}">
                        <input type="text" name="title" lay-verify="title" disabled value="人事部" class="layui-input">
                    </c:if>
                    <c:if test="${user.dep_id==4}">
                        <input type="text" name="title" lay-verify="title" disabled value="财务部" class="layui-input">
                    </c:if>
                    <c:if test="${user.dep_id==5}">
                        <input type="text" name="title" lay-verify="title" disabled value="行政部" class="layui-input">
                    </c:if>

                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">公文主题</label>
                <div class="layui-input-block">
                    <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入主题"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">公文内容</label>
                <div class="layui-input-block">
                    <textarea placeholder="请输入内容" class="layui-textarea" name="content"></textarea>
                </div>
            </div>
            <div class="layui-form-item" pane="">
                <label class="layui-form-label">紧急程度</label>
                <div class="layui-input-block">
                    <input type="radio" name="type" value="0" title="普通" checked="true">
                    <input type="radio" name="type" value="1" title="紧急">
                </div>
            </div>
            <div class="layui-col-lg-offset3">
                <button type="submit" class="layui-btn layui-btn-normal">提交</button>
                <button type="reset" class="layui-btn layui-btn-warm">重置</button>
            </div>

        </form>
    </div>



</div>
<script>
    layui.extend({
        admin: '${pageContext.request.contextPath}/static/js/admin'
    });
    layui.use(['form', 'admin', 'jquery', 'table', 'layer','util'], function () {
        var form = layui.form,
            admin = layui.admin,
            $ = layui.jquery,
            table = layui.table,
            layer = layui.layer,
            util=layui.util;




    });
</script>
</body>
</html>

