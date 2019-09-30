<%--
  Created by IntelliJ IDEA.
  User: wed12
  Date: 2019/9/24
  Time: 22:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="UTF-8">
    <title>添加订单-客户关系管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
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
<div class="weadmin-nav">
			<span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">公文管理</a>
        <a><cite>公文审核</cite></a>
      </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="weadmin-body">

    <table border="1"  lay-filter="test" class="layui-table" id="tablePage">

    </table>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="edit">审核</a>
    </script>
</div>
<script>
    layui.extend({
        admin: '${pageContext.request.contextPath}/static/js/admin'
    });
    layui.use(['form', 'admin', 'jquery', 'table', 'layer','util'], function() {
        var form = layui.form,
            admin = layui.admin,
            $ = layui.jquery,
            table = layui.table,
            layer = layui.layer,
             util=layui.util;
         //表格分页 上级进行审核
        table.render({
            elem: '#tablePage'
            ,url:'${pageContext.request.contextPath}/MangerTask.do'
            ,page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                //,curr: 5 //设定初始在第 5 页
                ,groups: 1 //只显示 1 个连续页码
// 				          ,first: true
// 				          ,last: true
                ,id:'tablePage'
                ,limits:[3,6,9]
                ,limit:10
                ,response:{
                    code:'code',
                    count:'count'
                }
            }
            ,cols: [[
                {field:'id',align:'center',title: '编号', sort: true},
                {filed:'content',hide:true}
                ,{field:'title',align:'center', title: '标题'}
                ,{field:'emp_name',align:'center', title: '拟稿人'}
                ,{field:'time',align:'center', title: '拟稿时间',sort: true,templet:function(d) {return util.toDateString(d.servicetable_createdate,"yyyy-MM-dd HH:mm:ss");}}
                ,{field:'typeid',align:'center', title: '紧急程度',templet:setState}
                ,{field:'typeid',align:'center', title: '操作',toolbar:"#barDemo"}
            ]]
            // ,done: function(res, curr, count) {
            //     $("[data-field='typeid']").children().each(function () {
            //         if ($(this).text() == 0) {
            //             $(this).text("普通")
            //         }
            //         else if ($(this).text() == 1) {
            //             $(this).text("紧急")
            //         }
            //     });
            // }
        });

        //设置状态
        function setState(data) {
            var state=data.typeid;
            if (state==0){
                return "<span>普通</span>";
            }else {
                return  "<span style='color: red;'>紧急</span>";
            }
        }
        //监听行工具事件
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据

                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'detail'){
                //获取当前列的编号
               var id=data.id;
                $.get({
                    url:'${pageContext.request.contextPath}/completeTask/'+id+".do"
                    ,dateType:'text'
                    ,success:function(data){
                        layer.msg('提交成功！');
                        parent.location.reload();
                    }

                });
                /*进项审核*/
            } else if(layEvent === 'edit'){
                layer.open({
                    title:"领导审核",
                    type:2,//0-4 默认为0
                    content:'${pageContext.request.contextPath}/comment/'+data.id+'.do',
                    skin:'layui-layer-molv',
                    area:['800px','500px'], //设置宽高
                    btnAlign: 'c',	//设置下面的按钮的对齐方式  l  c   r
                    closeBtn:2,  //可以写1  2  boolean   false=不显示关闭按钮
                    shadeClose:true,//点击弹出层之外的位置是否自动关闭
                    maxmin:true,//是否显示最大化和最小化的按钮
                    resize:true//设置是否允许拉伸
                });

            }
        });

    });
</script>
</body>

</html>