<%--
  Created by IntelliJ IDEA.
  User: wed12
  Date: 2019/9/23
  Time: 19:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>添加订单-客户关系管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="../../static/css/font.css">
    <link rel="stylesheet" href="../../static/css/weadmin.css">
    <script src="../../lib/layui/layui.js" charset="utf-8"></script>
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
        <a><cite>流程部署</cite></a>
      </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="weadmin-body">
    <form action="${pageContext.request.contextPath}/deploy.do" method="post" enctype="multipart/form-data" class="layui-form">
        BPMN文件：<input type="file" name="bpmn"  /><br />
        PNG文件：<input type="file" name="png" /><br />
        <input type="submit" value="提交" class="layui-btn layui-btn-sm layui-btn-normal"/>
    </form>
    <table border="1"  lay-filter="test" class="layui-table" id="tablePage">

    </table>

</div>
<script>
    layui.extend({
        admin: '{/}../../static/js/admin'
    });
    layui.use(['form', 'admin', 'jquery', 'table', 'layer'], function() {
        var form = layui.form,
            admin = layui.admin,
            $ = layui.jquery,
            table = layui.table,
            layer = layui.layer;

        //分页
        table.render({
            elem: '#tablePage'
            ,url:'${pageContext.request.contextPath}/selectProcessDefinition.do'
            ,page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                //,curr: 5 //设定初始在第 5 页
                ,groups: 1 //只显示 1 个连续页码
// 				          ,first: true
// 				          ,last: true
                ,id:'tablePage'
                ,limits:[3,6,9]
                ,limit:3
                ,response:{
                    code:'code',
                    count:'count'
                }
            }
            ,cols: [[
                {field:'id',align:'center', title: '流程定义id'}
                ,{field:'deploymentId',align:'center', title: '流程部署id'}
                ,{field:'key',align:'center', title: '流程定义Key'}
                ,{field:'vsersion',align:'center', title: '版本'}
                ,{field:'resourceName',align:'center', title: 'BPMN',sort: true}
                ,{field:'diagramResourceName',align:'center', title: 'PNG', templet:'#switchTpl'}
                ,{field:'score', align:'center',title: '删除',toolbar:"#barDemo"}
            ]]
        });
    });
</script>
</body>

</html>
