<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/16
  Time: 19:52
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>发件箱</title>
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

            <a id="sc" lay-event="sc" class="layui-btn layui-btn-xs">
                <i class="layui-icon layui-icon-delete"></i>刪除
            </a>

        </div>

        <table id="test" lay-filter="test" class="layui-hide" height=100 >

            <script type="text/html" id="fileOperation">

                <a id="check" lay-event="check" class="layui-btn layui-btn-normal layui-btn-xs">
                    <i class="layui-icon layui-icon-search"></i>查看
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
            url: '<c:url value="/sendEmail.do"/>' //模拟接口
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
                    field: 'typeName',title: '文件级别',width:150, align:'center'
                }, {
                    title: '操作', align: 'center', toolbar: '#fileOperation', width: 150
                }]
            ]
            ,page: true
            // 表格ID，必须设置，重载部分需要用到
            , id: 'tableOne'
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


        //按钮操作
        function deleteEmail(eids) {
            $.get('<c:url value="/del.do"/>',
                {"eids": eids},
                function (msg) {
                    if(msg=="成功"){
                        location.href="sendEmail.jsp";
                    }
                })
        }

        $("#sc").click(function(){
            var checkStatus = table.checkStatus('tableOne'),
                data = checkStatus.data,
                eids = "";
            if(data.length > 0) {
                for (var i in data) {
                    eids+=data[i].eid+",";
                    //alert(eids);
                }
                console.log(eids);
                layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index) {
                    deleteEmail(eids);
                    layer.close(index);
                })
            }else{
                layer.msg("请选择需要删除的数据");
            }
        })

        //查看
        table.on('tool(test)', function(obj){

            var data = obj.data;

            $.ajax({
                url: '<c:url value="/showDetail.do"/>',
                type:'post',
                dataType:'text',
                data: '&eid='+data.eid
            })

            if (obj.event === 'check') {
                layer.open({
                    type: 2,
                    offset: 'auto',
                    title: '邮件详情',
                    area: ['1718px', '882px'],
                    fix: false, //不固定
                    shadeClose: false, //点击遮罩关闭
                    content: 'detail.jsp',

                })
            }
        });

    });


</script>



</body>


</html>
