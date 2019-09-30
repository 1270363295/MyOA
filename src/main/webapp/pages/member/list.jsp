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
    <title>
        部门管理
    </title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <script src="${pageContext.request.contextPath}/lib/layui/layui.all.js"></script>

    <style>
        table tr th td{
            text-align: center;
        }
        #info{
            display: none;
        }
        #updData{
            display: none;
        }
    </style>
</head>
<body>
<h3>你当前的位置是：部门管理</h3><br><br><br>
<button type="button" class="layui-btn" id="add">
    <i class="layui-icon">&#xe608;</i>新增部门
</button>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit" id="edit" >编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<table  id="mytab" width="60%" class="layui-table" lay-filter="test">
</table>
</div>
<div class="layui-card"  id="info">
    <div class="layui-card-header">部门信息</div>
    <div class="layui-card-body">
        <form action="${pageContext.request.contextPath}/addDepart.do" method="post"  class="layui-form" id="addform">
            部门名称:<input type="text" name="name" required lay-verify="required"  autocomplete="off" >&nbsp;
            联系电话:<input type="tel" name="phone" required lay-verify="phone"  autocomplete="off" >&nbsp;
            传真号码:<input type="text" name="fax" required lay-verify="fax"  autocomplete="off" >&nbsp;
            <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>&nbsp;&nbsp;
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>&nbsp;&nbsp;
        </form>
    </div>
</div>
<div class="layui-card"  id="updData">
    <div class="layui-card-header">修改部门信息</div>
    <div class="layui-card-body">
        <form action="${pageContext.request.contextPath}/updateData.do" method="post"  class="layui-form" id="updform">
            <input type="hidden" name="id" value="" id="depid">
            部门名称:<input type="text" name="name" required lay-verify="required"  autocomplete="off" >&nbsp;
            联系电话:<input type="tel" name="phone" required lay-verify="phone"  autocomplete="off" >&nbsp;
            传真号码:<input type="text" name="fax" required lay-verify="fax"  autocomplete="off" >&nbsp;
            <button class="layui-btn layui-btn-xs" id="update" lay-submit="" lay-filter="demo2" >确定</button>&nbsp;
            <button type="reset" class="layui-btn layui-btn-primary layui-btn-xs">取消</button>&nbsp;
        </form>
    </div>
</div>
<script>
    layui.use(['table', 'form','jquery'], function () {
        var table = layui.table;
        var form= layui.form;
        var $=layui.jquery;


        $("#add").click(function (){
            $("#info").toggle();

        });

        //自定义验证规则
        form.verify({
            phone: [
                /^\d{8}|\d{11}$/
                , '电话必须是8或者11位的纯数字'
            ]
            , fax:[
                /^\d{8}|\d{11}$/
                , '传真必须是8或者11位的纯数字'
            ]
        });
        //监听submit提交事件
        form.on('submit(demo1)', function(data){
            $.ajax({
                url: '${pageContext.request.contextPath}/addDepart.do',
                type: 'POST',
                data:$("#addform").serialize(),
                dataType:"text",
                success: function(data) {
                    alert("进入");
                    if (data == '添加成功') {
                        location.reload();
                    }
                }
            });

            //阻止表单跳转
            return false;
        });
        form.on('submit(demo2)', function(data){
        $.ajax({
            url: '${pageContext.request.contextPath}/updateData.do',
            type: 'POST',
            data:$("#updform").serialize(),
            dataType:"text",
            success: function(data) {
                if (data == '修改成功') {

                    location.reload();
                }
            }
        });
            return false;
        });
        table.render({
            elem: '#mytab'
            , url: '${pageContext.request.contextPath}/show.do'
            ,toolbar: '#toolbarDemo'
            , type: 'get'
            , cols: [[
                {field: 'dep_id', title: "序号", width: 150}
                , {field: 'dep_name', title: "部门", width: 150}
                , {field: 'dep_phone', width: 200, title: '联系电话'}
                , {field: 'dep_fax', width: 200, title: '传真号码'}
                , {fixed: 'right', title: '操作', toolbar: '#barDemo', minWidth: 200}
            ]]
            , page: true
            , id: 'table'
            ,limits: [3,6, 9 ]
            ,limit:3
            ,response: {
                code: 'code',// 对应 code
                count: 'count', // 对应 count
            }
        });

        var active = {
            reload: function () {
                //执行重载
                table.reload('table', {
                    url:
                        '${pageContext.request.contextPath}/show.do',
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                });
            }
        };

        //监听工具条
        table.on('tool(test)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            if (layEvent === 'del') { //删除
                layer.confirm('真的删除么', function (index) {
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
                        url:
                            '${pageContext.request.contextPath}/delByid1/'+data.dep_id+'.do',
                        type: 'POST',
                        success: function (data) {
                            if (data.flag) {
                                layer.msg("删除失败", {icon: 5});
                            }else {
                                obj.del();
                                layer.close(index);
                            }
                        }
                    });
                });
            }
            else  if(layEvent ==='edit'){//编辑
                $("#updData").toggle();
                $("#depid").val(data.dep_id);

            }
        });
    });
</script>
</body>
</html>
