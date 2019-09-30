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
<div class="weadmin-body">
    <%--公文草拟>--%>
    <div align="cneter">
        <form action="${pageContext.request.contextPath}/addbump.do" method="post" class="layui-form">

            <div class="layui-form-item">
                <label class="layui-form-label">草拟人</label>
                <div class="layui-input-block">
                    <input type="text" name="title" lay-verify="title" class="layui-input"
                           value="${map.emp_name}" disabled>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">所属部门</label>
                <div class="layui-input-block">
                    <c:if test="${map.dep_id==1}">
                        <input type="text" name="title" lay-verify="title" disabled value="开发部" class="layui-input">
                    </c:if>
                    <c:if test="${map.dep_id==2}">
                        <input type="text" name="title" lay-verify="title" disabled value="销售部" class="layui-input">
                    </c:if>
                    <c:if test="${map.dep_id==3}">
                        <input type="text" name="title" lay-verify="title" disabled value="人事部" class="layui-input">
                    </c:if>
                    <c:if test="${map.dep_id==4}">
                        <input type="text" name="title" lay-verify="title" disabled value="财务部" class="layui-input">
                    </c:if>
                    <c:if test="${map.dep_id==5}">
                        <input type="text" name="title" lay-verify="title" disabled value="行政部" class="layui-input">
                    </c:if>

                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">公文主题</label>
                <div class="layui-input-block">
                    <input type="text" name="title" lay-verify="title" autocomplete="off" value="${map.title}"
                           class="layui-input" disabled>
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">公文内容</label>
                <div class="layui-input-block">
                    <textarea  class="layui-textarea" name="content" disabled>${map.content}</textarea>
                </div>
            </div>

            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">批注</label>
                <div class="layui-input-block">
                    <textarea placeholder="请输入内容" class="layui-textarea" name="pz"></textarea>
                </div>
            </div>

            <div class="layui-col-lg-offset2" align="center">
                <button type="button" id="ok" class="layui-btn layui-btn-normal">同意</button>
                <button type="button" id="reject" class="layui-btn layui-btn-warm">驳回</button>
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


        //同意点击事件
     $("#ok").click(function(){
           //获取当前任务的主键
         var id=${map.id};
         //获取批注内容
         var content = $("[name='pz']").val();
        $.ajax({
            url:'${pageContext.request.contextPath}/comment.do',
            data:{'id':id,'content':content},
            dataType:'text',
            type:'post',
            success:function(data){
                layer.msg('提交成功！');
                parent.location.reload();
            }
        })



     });
      //驳回事件
        $("#reject").click(function () {
            var id=${map.id};
            //获取批注内容
            var content = $("[name='pz']").val();

            $.ajax({
                url:'${pageContext.request.contextPath}/reject.do',
                data:{'id':id,'content':content},
                dataType:'text',
                type:'post',
                success:function(data){
                    layer.msg('已驳回！');
                    parent.location.reload();
                }
            })

        });

    });
</script>
</body>
</html>

