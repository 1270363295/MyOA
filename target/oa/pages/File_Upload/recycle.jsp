<%--
  Created by IntelliJ IDEA.
  User: 你的小张同志
  Date: 2019/9/19 22:20
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="<c:url value="/js/jquery-1.9.1.min.js"/>"></script>
    <script src="<c:url value="/lib/layui/layui.js"/>"></script>
    <link rel="stylesheet" type="text/css" href="<c:url value="/lib/layui/css/layui.css"/>">
    <style>
        #table{
            margin-left: 400px;
        }
    </style>
    <style>
        .layui-table-cell .layui-form-checkbox[lay-skin="primary"]{
            top: 50%;
            transform: translateY(-50%);
        }
    </style>
</head>
<body>

<div>
    <div class="layui-fluid">
        <div class="layui-card">

            <div class="layui-form layuiadmin-card-header-auto" lay-filter="layadmin-userfront-formlist"
                 style="margin-left: 470px;margin-top: 100px">
                <div class="layui-form-item">

                    <div class="layui-inline">
                        <label class="layui-form-label">文件名：</label>
                        <div class="layui-input-block" style="width: 150px;">
                            <input id="fileName" name="fileName"
                                   type="text" placeholder="请输入文件名" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-inline">
                        <label class="layui-form-label">上传人：</label>
                        <div class="layui-input-block" style="width: 150px;">
                            <input id="userName" name="userName"
                                   type="text" placeholder="请输入上传人" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-inline">
                        <button id="search" class="layui-btn layui-btn-normal"
                                lay-filter="LAY-user-front-search">
                            <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                        </button>
                    </div>

                    <div class="layui-inline">
                        <button id="overload" class="layui-btn"
                                lay-filter="overload">
                            <i class="layui-icon layui-icon-refresh"></i>
                        </button>
                    </div>

                </div>
            </div>

            <div class="layui-btn-group demoTable" style="margin-left: 400px;margin-bottom: 20px">
                <button id="delManyFiles" lay-event="delManyFiles" class="layui-btn">批量删除</button>
            </div>

            <div class="layui-btn-group demoTable" style="margin-left: 20px;margin-bottom: 20px">
                <button id="restoreManyFiles" lay-event="restoreManyFiles" class="layui-btn">批量还原</button>
            </div>

            <div id="table">
                <table id="showFile" lay-filter="showFile"></table>
            </div>

            <div>

                <script type="text/html" id="fileOperation">

                    <a id="restore" lay-event="restore" class="layui-btn layui-btn-warm layui-btn-xs">
                        <i class="layui-icon layui-icon-search"></i>还原
                    </a>

                    <a id="delFile" lay-event="delFile" class="layui-btn layui-btn-danger layui-btn-xs">
                        <i class="layui-icon layui-icon-close"></i>删除
                    </a>

                </script>

            </div>

        </div>
    </div>
</div>


<script>

    layui.use(['form','table','layer','laydate','layedit'], function() {
        var $ = layui.$
            , table = layui.table
            , form = layui.form
            , layer = layui.layer
            , laydate = layui.laydate
            , layedit = layui.layedit;

        //------------------------以下為分頁查詢------------------------------------------------------------------------------------

        //表格
        table.render({
            height: 473 //容器高度
            , width: 834 //容器高度
            , elem: '#showFile'
            , url: '<c:url value="/recycleShowFile.do"/>' //模拟接口
            , page: true
            // 表格ID，必须设置，重载部分需要用到
            , id: 'showFile'
            , limits: [10, 15, 20, 25]
            , limit: 10
            /**
             * response:{
                statusName: '自定义的参数名称' ,// 对应 code
                msgName: '自定义的参数名称' , // 对应 msg
                countName: '自定义的参数名称' , // 对应 count
                dataName: '自定义的参数名称' // 对应 data
                }
             */
            , response: {
                statusName: 'code',// 对应 code
                msgName: 'mag', // 对应 msg
                countName: 'count', // 对应 count
                dataName: 'data'  // 对应 data
            }
            , text: {none: '无数据'}
            , cols: [[
                {type: 'checkbox'}
                , {field: 'fileId', align: 'center', title: 'id', width: 46}
                , {field: 'fileName', align: 'center', title: '文件名', width: 252}
                , {field: 'username', align: 'center', title: '上传人', width: 170}
                , {title: '操作', align: 'center', toolbar: '#fileOperation', width: 312}
            ]]
        });

        //------------------------以下為查詢按鈕的點擊事件------------------------------------------------------------------------------------

        // 执行搜索，表格重载
        $('#search').click(function () {
            // 搜索条件
            var fileName = $('#fileName').val();
            var userName = $('#userName').val();
            table.reload('showFile', {
                elem: '#showFile'
                , method: 'post'
                , where: {
                    'fileName': fileName,
                    'userName': userName
                }
                , url: '<c:url value="/rcycleOverloadQuery.do"/>' //模拟接口
                , page: true
                , limits: [5, 10, 15, 20, 25]
                , limit: 10
                , text: '对不起，加载出现异常！'
                /**
                 * response:{
                    statusName: '自定义的参数名称' ,// 对应 code
                    msgName: '自定义的参数名称' , // 对应 msg
                    countName: '自定义的参数名称' , // 对应 count
                    dataName: '自定义的参数名称' // 对应 data
                    }
                 */
                , response: {
                    statusName: 'code',// 对应 code
                    msgName: 'mag', // 对应 msg
                    countName: 'count', // 对应 count
                    dataName: 'data'  // 对应 data
                }
                , text: {none: '无数据'}
                , cols: [[
                    {type: 'checkbox'}
                    , {field: 'fileId', align: 'center', title: 'id', width: 46}
                    , {field: 'fileName', align: 'center', title: '文件名', width: 252}
                    , {field: 'username', align: 'center', title: '上传人', width: 170}
                    , {title: '操作', align: 'center', toolbar: '#fileOperation', width: 312}

                ]]
            });
        });


        //------------------------以下為重置按鈕的點擊事件------------------------------------------------------------------------------------


        $("#overload").click(function () {
            $('#fileName').val("");
            $('#userName').val("");
            //表格
            table.render({
                height: 473 //容器高度
                , width: 834 //容器高度
                , elem: '#showFile'
                , url: '<c:url value="/recycleShowFile.do"/>' //模拟接口
                , page: true
                // 表格ID，必须设置，重载部分需要用到
                , id: 'showFile'
                , limits: [10, 15, 20, 25]
                , limit: 10
                /**
                 * response:{
                statusName: '自定义的参数名称' ,// 对应 code
                msgName: '自定义的参数名称' , // 对应 msg
                countName: '自定义的参数名称' , // 对应 count
                dataName: '自定义的参数名称' // 对应 data
                }
                 */
                , response: {
                    statusName: 'code',// 对应 code
                    msgName: 'mag', // 对应 msg
                    countName: 'count', // 对应 count
                    dataName: 'data'  // 对应 data
                }
                , text: {none: '无数据'}
                , cols: [[
                    {type: 'checkbox'}
                    , {field: 'fileId', align: 'center', title: 'id', width: 46}
                    , {field: 'fileName', align: 'center', title: '文件名', width: 252}
                    , {field: 'username', align: 'center', title: '上传人', width: 170}
                    , {title: '操作', align: 'center', toolbar: '#fileOperation', width: 312}
                ]]
            });

        });

        //------------------------以下為重置按鈕的點擊事件------------------------------------------------------------------------------------

        function deleteByPrimaryKey(fileId) {
            $.get('<c:url value="/deleteByPrimaryKey.do"/>',
                {"fileId": fileId},
                function (msg) {
                    if(msg=="成功"){
                        location.href="recycle.jsp";
                    }
                })
        }

        function reductionFiles(fileId) {
            $.get('<c:url value="/reductionFiles.do"/>',
                {"fileId": fileId},
                function (msg) {
                    if(msg=="成功"){
                        location.href="recycle.jsp";
                    }
                })
        }

        table.on('tool(showFile)', function(obj){

            var data = obj.data;

            if (obj.event === "restore"){
                layer.confirm('你确定还原这个文件吗?', {icon: 3, title:'提示'}, function (index) {
                    reductionFiles(data.fileId);
                    layer.close(index);
                });
            }else if (obj.event === "delFile"){
                layer.confirm('你确定删除这个文件吗?', {icon: 2, title:'提示'}, function (index) {
                    deleteByPrimaryKey(data.fileId);
                    layer.close(index);
                });
            }

        });

        //------------------------批量删除------------------------------------------------------------------------------------

        function delManyFiles(fileIds) {
            $.get('<c:url value="/delManyFiles.do"/>',
                {"fileIds": fileIds},
                function (msg) {
                    if(msg=="成功"){
                        location.href="recycle.jsp";
                    }
                })
        }


        $("#delManyFiles").click(function(){
            var checkStatus = table.checkStatus('showFile'),
                data = checkStatus.data,
                fileIds = "";
            if(data.length > 0) {
                for (var i in data) {
                    fileIds+=data[i].fileId+",";
                    // alert(fileIds);
                }
                console.log(fileIds);
                layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index) {
                    delManyFiles(fileIds);
                    layer.close(index);
                })
            }else{
                layer.msg("请选择需要删除的数据");
            }
        })


        function restoreManyFiles(fileIds) {
            $.get('<c:url value="/restoreManyFiles.do"/>',
                {"fileIds": fileIds},
                function (msg) {
                    if(msg=="成功"){
                        location.href="recycle.jsp";
                    }
                })
        }

        $("#restoreManyFiles").click(function(){
            var checkStatus = table.checkStatus('showFile'),
                data = checkStatus.data,
                fileIds = "";
            if(data.length > 0) {
                for (var i in data) {
                    fileIds+=data[i].fileId+",";
                    // alert(fileIds);
                }
                console.log(fileIds);
                layer.confirm('确定还原选中的数据？', {icon: 3, title: '提示信息'}, function (index) {
                    restoreManyFiles(fileIds);
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
