<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/21
  Time: 16:59
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>回收站</title>
    <script src="<c:url value="/js/jquery-1.12.4.js"/>"></script>
    <link rel="stylesheet" href="../../static/css/font.css">
    <link rel="stylesheet" href="../../static/css/weadmin.css">
    <script src="<c:url value="/lib/layui/layui.js"/>"></script>
    <link rel="stylesheet" type="text/css" href="<c:url value="/lib/layui/css/layui.css"/>">

    <style type="text/css">
        .layui-form-switch {
            width: 55px;
        }
        .layui-form-switch em {
            width: 40px;
        }
        body{overflow-y: scroll;}

        .layui-table-cell .layui-form-checkbox[lay-skin="primary"]{
            top: 50%;
            transform: translateY(-50%);
        }

    </style>
</head>
<body>

<div class="layui-fluid" style="margin-top: 75px;margin-left: 118px">
    <div class="layui-card">

        <div>

            <a id="recycleBinDelEmails" lay-event="recycleBinDelEmails" class="layui-btn layui-btn-xs">
                <i class="layui-icon layui-icon-delete"></i>刪除
            </a>

        </div>

        <table id="test" lay-filter="test" class="layui-hide" height=100 >


            <script type="text/html" id="fileOperation">

                <a id="restore" lay-event="restore" class="layui-btn layui-btn-warm layui-btn-xs">
                    <i class="layui-icon layui-icon-search"></i>还原
                </a>

                <a id="recycleBinDelEmail" lay-event="recycleBinDelEmail" class="layui-btn layui-btn-danger layui-btn-xs">
                    <i class="layui-icon layui-icon-close"></i>删除
                </a>

            </script>
        </table>

    </div>
</div>

<script>

    layui.use(['form','table','layer','laydate','layedit'], function(){
        var $ = layui.$
            ,table = layui.table
            ,form = layui.form
            ,layer = layui.layer
            ,laydate = layui.laydate
            ,layedit = layui.layedit;

        table.render({
            height:450,
            width:1210,
            elem: '#test',
            cellMinWidth: 80,
            url: '<c:url value="/showRecycleBinFile.do"/>' //模拟接口
            ,
            cols: [
                [{
                    type:'checkbox'
                },{
                    field: 'title',title: '主题',width:400, align:'center'
                }, {
                    field: 'recipients',title: '收件人',width:150, align:'center'
                }, {
                    field: 'sendtime',title: '发件时间',width:300, align:'center'
                }, {
                    field: 'typeName',title: '文件级别',width:100, align:'center'
                }, {
                    title: '操作', align: 'center', toolbar: '#fileOperation', width: 200
                }]
            ]
            ,page: true
            // 表格ID，必须设置，重载部分需要用到
            , id: 'test'
            ,limits: [5,10, 15, 20, 25]
            ,limit: 5
            ,text: '对不起，加载出现异常！'
            ,response: {
                statusName: 'code',// 对应 code
                msgName: 'msg', // 对应 msg
                countName: 'count', // 对应 count
                dataName: 'data'  // 对应 data
            }
            ,text:{none: '无数据'}
        });

        function restoreEmails(eid) {
            $.get('<c:url value="/restoreEmails.do"/>',
                {"eid": eid},
                function (msg) {
                    if(msg=="成功"){
                        location.href="recycleBin.jsp";
                    }
                })
        }

        function recycleBinDelEmail(eid) {
            $.get('<c:url value="/recycleBinDelEmail.do"/>',
                {"eid": eid},
                function (msg) {
                    if(msg=="成功"){
                        location.href="recycleBin.jsp";
                    }
                })
        }

        table.on('tool(test)', function(obj){

            var data = obj.data;

            // alert(data.eid);

            if(obj.event === 'restore'){
                layer.confirm('你确定还原这个文件吗?', {icon: 2, title:'提示'}, function (index) {
                    restoreEmails(data.eid);
                    layer.close(index);
                });
            }else if(obj.event === 'recycleBinDelEmail'){
                layer.confirm('你确定删除这个文件吗?', {icon: 2, title:'提示'}, function (index) {
                    recycleBinDelEmail(data.eid);
                    layer.close(index);
                });
            }

        });



        function recycleBinDelEmails(eids) {
            $.get('<c:url value="/recycleBinDelEmails.do"/>',
                {"eids": eids},
                function (msg) {
                    if(msg=="成功"){
                        location.href="recycleBin.jsp";
                    }
                })
        }


        $("#recycleBinDelEmails").click(function(){
            var checkStatus = table.checkStatus('test'),
                data = checkStatus.data,
                eids = "";
            if(data.length > 0) {
                for (var i in data) {
                    eids+=data[i].eid+",";
                    alert(eids);
                }
                console.log(eids);
                layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index) {
                    recycleBinDelEmails(eids);
                    layer.close(index);
                })
            }else{
                layer.msg("请选择需要删除的数据");
            }
        })

    });


</script>

</body>
</html>
