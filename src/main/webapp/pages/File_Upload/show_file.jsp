<%--
  Created by IntelliJ IDEA.
  User: 你的小张同志
  Date: 2019/9/16 18:59
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>顯示文件</title>
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
                <button id="uploadFile" lay-event="uploadFile" class="layui-btn">上传文件</button>
            </div>

            <div class="layui-btn-group demoTable" style="margin-left: 20px;margin-bottom: 20px">
                <button id="showMyFiles" lay-event="showMyFiles" class="layui-btn">自己的文件</button>
            </div>

            <div class="layui-btn-group demoTable" style="margin-left: 20px;margin-bottom: 20px">
                <button id="updManyFiles" lay-event="updManyFiles" class="layui-btn">批量删除</button>
            </div>

            <div id="table">
                <table id="showFile" lay-filter="showFile"></table>
            </div>

            <div>

                <script type="text/html" id="fileOperation">

                    <a id="check" lay-event="check" class="layui-btn layui-btn-normal layui-btn-xs">
                        <i class="layui-icon layui-icon-search"></i>备注
                    </a>

                    <a id="download" lay-event="download"
                       class="layui-btn layui-btn-warm layui-btn-xs">
                        <i class="layui-icon layui-icon-add-1"></i>下载
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
            , url: '<c:url value="/ShowFile.do"/>' //模拟接口
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
                , url: '<c:url value="/overloadQuery.do"/>' //模拟接口
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
                , url: '<c:url value="/ShowFile.do"/>' //模拟接口
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


        //------------------------以下為查看按鈕點擊事件------------------------------------------------------------------------------------

        function updateStateByPrimaryKey(fileId) {
            $.get('<c:url value="/updateStateByPrimaryKey.do"/>',
                {"fileId": fileId},
                function (msg) {
                    if(msg=="成功"){
                        location.href="show_file.jsp";
                    }
                })
        }

        function downloadFiles(fileUrl,fileName) {

            var form=$("<form>");//定义一个form表单
            form.attr("style","display:none");
            form.attr("target","");
            form.attr("method","post");
            form.attr("action","${pageContext.request.contextPath}/downloadFiles.do");//请求url
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

        table.on('tool(showFile)', function(obj){

            var data = obj.data;

            // alert(data);
            // alert(data.fileName);

            if(obj.event === 'check'){

                layer.msg(data.remark,{
                    time: 20000, //20s后自动关闭
                    btnAlign: 'c',
                    btn: ['确定']
                });
            }else if (obj.event === "delFile"){
                layer.confirm('你确定删除这个文件吗?', {icon: 2, title:'提示'}, function (index) {
                    updateStateByPrimaryKey(data.fileId);
                    layer.close(index);
                });
            } else if (obj.event === "download"){
                downloadFiles(data.fileUrl,data.fileName);
            }

        });


        //------------------------以下為上傳文件點擊事件------------------------------------------------------------------------------------

        $("#uploadFile").click(function () {
            layer.open({
                type: 2 //此处以iframe举例
                ,title: '上传文件'
                ,area: ['900', '700px']
                ,shade: 0
                ,maxmin: true
                ,offset: 'auto'
                ,content: 'upload.jsp'
                ,btn: ['確定', '关闭'] //只是为了演示
                ,yes: function(){
                    layer.closeAll();
                    location.href="show_file.jsp";
                }
                ,btn2: function(){
                    layer.closeAll();
                    location.href="show_file.jsp";
                }
            });
        })


        //------------------------以下為顯示自己的文件點擊事件------------------------------------------------------------------------------------

        $("#showMyFiles").click(function () {
            // 搜索条件
            var userName=${sessionScope.user.emp_name};
            alert(userName);
            table.reload('showFile', {
                elem: '#showFile'
                , method: 'post'
                , where: {
                    'userName': userName,
                }
                , url: '<c:url value="/showMyFiles.do"/>' //模拟接口
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
        })

    //------------------------批量修改------------------------------------------------------------------------------------

        function updManyFiles(fileIds) {
            $.get('<c:url value="/updManyFiles.do"/>',
                {"fileIds": fileIds},
                function (msg) {
                    if(msg=="成功"){
                        location.href="show_file.jsp";
                    }
                })
        }


        $("#updManyFiles").click(function(){
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
                    updManyFiles(fileIds);
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
