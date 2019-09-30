<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/21
  Time: 11:52
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>邮件详情</title>
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
<form class="layui-form layui-form-pane" style="margin-top: 150px; margin-left: 500px">
    <div class="layui-form-item">
        <%--    发件人    --%>
        <div class="layui-inline">
            <label class="layui-form-label">发件人：</label>
            <div class="layui-input-inline" style="width: 615px">
                <input id="addresser" name="addresser" lay-verify="required" value="${sessionScope.detail.addresser}"
                       type="text" autocomplete="off" class="layui-input"  placeholder="从数据库导入" readonly="readonly">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <%--     主题   --%>
        <div class="layui-inline">
            <label class="layui-form-label">主题：</label>
            <div class="layui-input-inline" style="width: 615px">
                <input id="title" name="title" lay-verify="required" value="${sessionScope.detail.title}"
                       type="text" autocomplete="off" class="layui-input" placeholder="从数据库导入">
            </div>
        </div>
    </div>

    <%--    接收人   --%>
    <div class="layui-form-item">
        <label class="layui-form-label">接收人：</label>
        <div class="layui-input-block" style="width: 615px">
            <input id="recipients" name="recipients" lay-verify="required" value="${sessionScope.detail.recipients}"
                   type="text" autocomplete="off" placeholder="从数据库导入" class="layui-input">
        </div>
    </div>


    <%--    发送时间    --%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">发送时间：</label>
            <div class="layui-input-inline" style="width: 615px">
                <input id="sendtime" name="sendtime" lay-verify="required" value="${sessionScope.detail.sendtime}"
                       type="text" autocomplete="off" class="layui-input" placeholder="从数据库导入">
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
                <input id="typeName" name="typeName" lay-verify="required" value="${sessionScope.detail.typeName}"
                       type="text" autocomplete="off" class="layui-input" placeholder="从数据库导入" readonly="readonly">
            </div>
        </div>
    </div>

    <%--     附件名   --%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">附件名：</label>
            <div class="layui-input-inline" style="width: 615px">
                <input id="accessory_name" name="accessory_name" lay-verify="required" value="${sessionScope.detail.accessory_name}"
                       type="text" autocomplete="off" class="layui-input" placeholder="无附件" readonly="readonly">
            </div>
        </div>
    </div>

    <div class="layui-form-item" style="margin-left: 610px">
        <a id="download" lay-event="download" class="layui-btn">
            <i class="layui-icon layui-icon-download-circle"></i>下载附件
        </a>
    </div>


    <div class="layui-form-item" style="margin-left: 640px">
        <a id="back" lay-event="back" class="layui-btn">
            <i class="layui-icon layui-icon-return"></i>返回
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



            function downloadFiles(fileUrl,fileName) {

                var form=$("<form>");//定义一个form表单
                form.attr("style","display:none");
                form.attr("target","");
                form.attr("method","post");
                form.attr("action","${pageContext.request.contextPath}/downloadaccessory.do");//请求url
                var input1=$("<input>");
                input1.attr("type","hidden");
                input1.attr("name","fileName");//设置属性的名字
                input1.attr("value",fileName);//设置属性的值
                var input2=$("<input>");
                input2.attr("type","hidden");
                input2.attr("name","fileUrl");//设置属性的名字
                input2.attr("value",fileUrl);//设置属性的值
                $("body").append(form);//将表单放置在web中
                form.append(input1);
                form.append(input2);
                form.submit();//表单提交

            }


            //点击下载附件
            $("#download").click(function () {
                downloadFiles('${sessionScope.accessory.accessory_url}','${sessionScope.accessory.accessory_name}');
            });

            $("#back").click(function () {
                window.parent.location.reload();
                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                parent.layer.close(index); //再执行关闭
            })



        });


        $(function () {
            $("#content").val('${sessionScope.detail.content}');
        })
    </script>


</body>
</html>
