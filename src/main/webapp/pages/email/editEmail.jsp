<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/21
  Time: 17:03
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>邮件编辑</title>
    <script src="<c:url value="/js/jquery-1.12.4.js"/>"></script>
    <link rel="stylesheet" href="../../static/css/font.css">
    <link rel="stylesheet" href="../../static/css/weadmin.css">
    <script src="<c:url value="/lib/layui/layui.js"/>"></script>
    <link rel="stylesheet" type="text/css" href="<c:url value="/lib/layui/css/layui.css"/>">

    <style>
        .container {
            width: 1200px;
            margin: 100px auto;
        }
        table{
            width: 100%;
        }
    </style>
</head>
<body>
<form class="layui-form layui-form-pane" style="margin-top: 75px; margin-left: 400px">
    <div class="layui-form-item">
        <%--    发件人    --%>
        <div class="layui-inline" style="margin-top: 30px">
            <label class="layui-form-label">发件人：</label>
            <div class="layui-input-inline" style="width: 615px">
                <input id="addresser" name="addresser" lay-verify="required" value="${sessionScope.showUpdateEmail.addresser}"
                       type="text" autocomplete="off" class="layui-input"  placeholder="从数据库导入" readonly="readonly">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <%--     主题   --%>
        <div class="layui-inline">
            <label class="layui-form-label">主题：</label>
            <div class="layui-input-inline" style="width: 615px">
                <input id="title" name="title" lay-verify="required" value="${sessionScope.showUpdateEmail.title}"
                       type="text" autocomplete="off" class="layui-input" placeholder="从数据库导入">
            </div>
        </div>
    </div>

    <%--    接收人   --%>
    <div class="layui-form-item">
        <label class="layui-form-label">接收人：</label>
        <div class="layui-input-block" style="width: 615px">
            <input id="recipients" name="recipients" lay-verify="required" value="${sessionScope.showUpdateEmail.recipients}"
                   type="text" autocomplete="off" placeholder="从数据库导入" class="layui-input">
        </div>
    </div>


    <%--    编辑时间    --%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">编辑时间：</label>
            <div class="layui-input-inline" style="width: 615px">
                <input id="sendtime" name="sendtime" lay-verify="required" value="${sessionScope.showUpdateEmail.sendtime}"
                       type="text" autocomplete="off" class="layui-input" placeholder="从数据库导入" readonly="readonly">
            </div>
        </div>
    </div>

    <%--    内容   --%>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label" style="width: 723px">内容：</label>
        <div class="layui-input-block" style="width: 723px">
            <textarea id="content" name="content"
                      lay-verify="required" placeholder="从数据库导入" class="layui-textarea"></textarea>
        </div>
    </div>

    <%--     文件级别   --%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">文件级别：</label>
            <div class="layui-input-inline" style="width: 615px">
                <input id="typeName" name="typeName" lay-verify="required" value="${sessionScope.showUpdateEmail.typeName}"
                       type="text" autocomplete="off" class="layui-input" placeholder="从数据库导入" readonly="readonly">
            </div>
        </div>
    </div>


    <div class="layui-form-item" style="margin-left: 500px">
        <a id="edit" lay-event="edit" class="layui-btn layui-btn-normal layui-btn-sm">
            <i class="layui-icon layui-icon-search"></i>保存
        </a>


        <a id="send" lay-event="send" class="layui-btn layui-btn-danger layui-btn-sm">
            <i class="layui-icon layui-icon-close"></i>发送
        </a>

        <a id="back" lay-event="back" class="layui-btn layui-btn-sm">
            <i class="layui-icon layui-icon-close"></i>返回
        </a>
    </div>
</form>

<script>
    layui.use(['form','table','layer','laydate','layedit'], function() {
        var $ = layui.$
            , table = layui.table
            , form = layui.form
            , layer = layui.layer
            , laydate = layui.laydate
            , layedit = layui.layedit;


        $("#back").click(function () {
            window.parent.location.reload();
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index); //再执行关闭
        })



        $("#edit").click(function () {
            var  title=$('#title').val();
            var  recipients=$('#recipients').val();
            var  content=$('#content').val();
            $.ajax({
                url: '<c:url value="/edit.do"/>',
                type:'post',
                dataType:'text',
                data: '&title='+title+'&recipients='+recipients+'&content='+content
            })
        })


    });


    $(function () {
        $("#content").val('${sessionScope.showUpdateEmail.content}');
    })
</script>
</body>
</html>
