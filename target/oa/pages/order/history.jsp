<%--
  Created by IntelliJ IDEA.
  User: wed12
  Date: 2019/9/24
  Time: 18:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="UTF-8">
    <title>显示公文-自动办公系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
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

<div class="weadmin-body">

    <table border="1"  lay-filter="test" class="layui-table" id="tablePage">

    </table>

</div>
<script>
    layui.extend({
        admin: '${pageContext.request.contextPath}/static/js/admin'
    });
    layui.use(['form', 'admin', 'jquery', 'table', 'layer','laydate','util'], function() {
        var form = layui.form,
            admin = layui.admin,
            $ = layui.jquery,
            table = layui.table,
            layer = layui.layer,
            laydate = layui.laydate,
            util=layui.util;

        //表格分页
        table.render({
            elem: '#tablePage'
            ,url:'${pageContext.request.contextPath}/showHis.do'
            ,page:false
            ,cols: [[
                {field:'emp_name',align:'center',title: '审核人'}
                ,{field:'comment_time',align:'center', title: '审核时间',templet:function(d) {return util.toDateString(d.servicetable_createdate,"yyyy-MM-dd HH:mm:ss");}}
                ,{field:'comment',align:'center', title: '审批意见'}
            ]]
            ,where :{
                 id:${id}
            }

        });
    });
</script>
</body>

</html>