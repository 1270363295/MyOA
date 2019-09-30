<%--
  Created by IntelliJ IDEA.
  User: st
  Date: 2019/9/6
  Time: 8:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>添加用户</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <script src="${pageContext.request.contextPath}/lib/layui/layui.all.js"></script>
</head>
<body>
<div class="weadmin-body">
    <h1>编辑用户信息</h1>

    <form action="" method="post" class="layui-form"  id="upd">
        <c:forEach items="${emp}" var="e">
            <input type="hidden" name="id" id="id" value="${e.emp_id}">
            <div class="layui-form-item">
                <label class="layui-form-label">姓名：</label>
                <div class="layui-input-inline">
                    <input type="text" name="name"  value="${e.emp_name}" required lay-verify="required">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">性别：</label>
                <div class="layui-input-inline">
                    <select  lay-filter="sex" id="sex" name="sex"  >
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">Email:</label>
                <div class="layui-input-inline">
                    <input type="email" name="email" value="${e.emp_email}" required lay-verify="email">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">用户状态:</label>
                <div class="layui-input-inline">
                    <select  lay-filter="satae" id="state"  name="state"></select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">用户名：</label>
                <div class="layui-input-inline">
                    <input type="text" name="uname" value="${e.emp_uname}"required lay-verify="uname" value="">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">密码：</label>
                <div class="layui-input-inline">
                    <input type="password" name="pwd" value="${e.emp_pwd}"  required lay-verify="pwd">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">所属部门：</label>
                <div class="layui-input-inline">
                    <select  lay-filter="depart" id="depart" name="depart"></select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">职位</label>
                <div class="layui-input-inline">
                    <select  lay-filter="duty" id="duty" name="duty"></select>
                </div>
            </div>
            <div class="layui-upload">
                <button type="button" required class="layui-btn" id="test1">上传图片</button>
                <input type="hidden" id="img_url" name="img" value=""/>
                <div class="layui-upload-list">
                    <img class="layui-upload-img" id="demo1" >
                    <p id="demoText"></p>
                </div>
            </div>

            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">文本域</label>
                <div class="layui-input-block">
                    <textarea name="remark" required class="layui-textarea">${e.emp_remark}</textarea></div>
            </div>
            <button class="layui-btn layui-btn-xs" id="get" lay-submit="" lay-filter="demo2" >确定</button>&nbsp;
            <button type="reset" class="layui-btn layui-btn-primary layui-btn-xs">重置</button>&nbsp;
        </c:forEach>
    </form>

</div>
<script>
    layui.use(['form','upload','jquery'],function() {
        var form = layui.form;
        var $ = layui.jquery
            ,upload = layui.upload;
        //部门
        $.getJSON("${pageContext.request.contextPath}/info.do", function (data) {
            var option ="";

            $.each(data.depart,function (i, d) {
                option += '<option value="' +d.dep_id + '">' +d.dep_name+ '</option>'
            });
            $('#depart').html(option);
            //必须重新渲染
            form.render('select');
        });
        //性别
        $.getJSON("${pageContext.request.contextPath}/info.do", function (data) {
            var option = "";
            $.each(data.sex, function (i, s) {
                if (s.emp_geender==1){
                    option += '<option value="' +s.emp_geender + '">男</option>'
                } else  if (s.emp_geender==0) {
                    option += '<option value="' +s.emp_geender + '">女</option>'
                }
            });
            $('#sex').html(option);
            //必须重新渲染
            form.render('select');
        });
        //用户状态
        $.getJSON("${pageContext.request.contextPath}/info.do", function (res) {
            var option ="";

            $.each(res.sta,function (i, s) {
                    option += '<option value="' + s.sta_id + '" selected>' + s.sta_name + '</option>'
                });
            $('#state').html(option);
            //必须重新渲染
            form.render('select');
        });
        //职位
        $.getJSON("${pageContext.request.contextPath}/info.do", function (data) {
            var option="";

            $.each(data.duty,function (i, d) {
                option += '<option value="' +d.duty_id + '">' +d.duty_name+ '</option>'
            });
            $('#duty').html(option);
            //必须重新渲染
            form.render('select');
        });
        //普通图片上传
        var uploadInst = upload.render({
            elem: '#test1'     /*根据绑定id，打开本地图片*/
            ,url: '${pageContext.request.contextPath}/upload.do'  /*上传后台接受接口*/
            ,accept:"image"//指定上传的文件类型
            ,auto: false        /*true为选中图片直接提交，false为不提交根据bindAction属性上的id提交*/
            ,bindAction: '#get' //选完文件后不自动上传
            ,drag:true
            ,multiple: false
            ,size:2048
            ,auto: false
            ,choose:function(obj){
                obj.preview(function(index, file, result){
                    //预读本地文件示例，不支持ie8
                    console.log(file);

                    console.log(result);
                    $("#img_url").val(file.name);
                    $('#demo1').attr('src', result); //图片链接（base64）
                });
            }
            ,done: function(res){
                //如果上传失败
                if(res.code != 0){
                    return layer.msg('上传失败');
                }
                //上传成功
                alert("上传成功"+res.url);
                /*document.getElementById("img_url").value = res.url;*/
                console.log(res.url);

            }
            ,error: function() {
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function () {
                    uploadInst.upload();
                });
            }
        });
        //自定义验证规则
        //失去焦点时判断值为空不验证，一旦填写必须验证

        //监听提交
        form.on('submit(demo2)', function(data) {
            data.img=$("#img_url").val();

            $.ajax({
                url: '${pageContext.request.contextPath}/add.do',
                type: 'POST',
                data:$("#upd").serialize(),
                // 告诉$不要去处理发送的数据

                error : function(request) {
                    layer.alert('操作失败', {
                        icon: 2,
                        title:"提示"
                    });
                },
                success: function (result) {
                    if (result.code == 0) {
                        layer.msg('保存成功', {icon: 1, time: 1000});
                        location.href='${pageContext.request.contextPath}/pages/member/del.jsp';
                        //location.href='${pageContext.request.contextPath}/pages/member/add.jsp';
                    } else {
                        layer.msg('保存失败！' + result.msg, {icon: 2, time: 1000});
                    }
                },
                error: function (result, type) {
                    layer.msg('保存失败！', {icon: 2, time: 1000});
                }
            });
            //阻止表单跳转
            return false;
        });
    });
</script>
</body>

</html>