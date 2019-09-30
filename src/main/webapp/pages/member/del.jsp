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

</head>

<body>
<h3>你当前的位置是：员工列表</h3><br><br><br>

<div class="demoTable">
    员工姓名：
    <div class="layui-inline">
        <input class="layui-input" name="name" id="name" autocomplete="off">
    </div>
    部门：
    <div class="layui-inline">
        <select  lay-filter="depart" id="depid" name="depid">
        </select>
    </div>
    性别：
    <div class="layui-inline">
        <select  lay-filter="sex" id="sex" name="sex">
        </select>
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit" id="edit" href="${pageContext.request.contextPath}/sel/{{d.emp_id}}.do">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<table  id="mytab" width="60%" class="layui-table" lay-filter="test">
</table>
<script type="text/javascript">
    layui.use(['table', 'form','element','jquery'], function () {
        var table = layui.table;
        var form= layui.form;
        var $=layui.jquery;
        $.getJSON("${pageContext.request.contextPath}/info.do", function (data) {
            var option = '<option value="">--请选择--</option>';

            $.each(data.depart,function (i, d) {
                option += '<option value="' +d.dep_id + '">' +d.dep_name+ '</option>'
            });
            $('#depid').html(option);
            //必须重新渲染
            form.render('select');
        });
        $.getJSON("${pageContext.request.contextPath}/info.do", function (data) {
            var option = '<option value="">性别</option>';

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

        table.render({
            elem: '#mytab'
            , url: '${pageContext.request.contextPath}/showAll.do'
            ,toolbar: '#toolbarDemo'
            , type: 'get'
            , cols: [[
                {field: 'emp_id', title: "编号", width: 100}
                , {field: 'emp_name', title: "姓名", width: 120}
                , {field:  'emp_geender', width: 100, title: '性别'}
                , {field: 'emp_email', width: 200, title: '邮件'}
                , {field: 'emp_uname', width: 100, title: '用户名'}
                , {field: 'emp_pwd', width: 100, title: '密码'}
                , {field: 'sta_name', width: 100, title: '用户状态'}
                , {field: 'duty_name', width: 100, title: '岗位'}
                , {field: 'dep_name', width: 120, title: '所属部门'}
                , {fixed: 'right', title: '操作', toolbar: '#barDemo', minWidth: 150}

            ]]
            /*判断性别*/
            ,done: function(res, curr, count) {
                $("[data-field='emp_geender']").children().each(function () {
                    if ($(this).text() == 0) {
                        $(this).text("女")
                    }
                    else if ($(this).text() == 1) {
                        $(this).text("男")
                    }
                });
            }
            , page: true
            , id: 'tab'
            ,limits: [3,6, 9 ]
            ,limit:3
            ,response: {
                code: 'code',// 对应 code
                count: 'count', // 对应 count
            }
        });
        var $ = layui.$, active = {
            reload: function(){
                var name = $('#name');
                var depid=$('#depid');
                var geender=$('#sex');
                //执行重载
                table.reload('tab', {
                    url: '${pageContext.request.contextPath}/inquire.do'
                    ,page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        name: name.val()
                        ,depid: depid.val()
                        ,geender: geender.val()
                    }
                });
            }
        }
        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

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
                            '${pageContext.request.contextPath}/delByid/'+data.emp_id+'.do',
                        type: 'POST',
                        success: function (data) {
                            if (data == '删除成功') {
                                obj.del();
                                layer.close(index);
                            }
                            location.reload();
                        }
                    });
                });
            }
            else  if(layEvent ==='edit'){//编辑

            }
        });
    });
</script>
</body>
</html>