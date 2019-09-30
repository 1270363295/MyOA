<%--
  Created by IntelliJ IDEA.
  User: 你的小张同志
  Date: 2019/9/23 11:28
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>基于cropper.js的图片裁剪</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cropper.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ImgCropping.css">
    <link rel="stylesheet" type="text/css" href="<c:url value="/lib/layui/css/layui.css"/>">

    <style>
        .str {
            width: 150px;
            height: 200px;
            border: solid 1px #e3e3e3;
            padding: 5px;
            margin-top: 10px
        }
    </style>

</head>

<body>

<div style="margin-left: 690px;margin-top: 80px">
    <div class="str">
        <img id="finalImg" src="" width="100%">
    </div>
    <label title="上传图片" for="chooseImg" class="l-btn choose-btn" style="margin-top: 20px">
        <input type="file" accept="image/jpg,image/jpeg,image/png" name="file" id="chooseImg" class="hidden" onchange="selectImg(this)">
        重新选择头像
    </label>
</div>

<div style="margin-top: 30px;margin-left: 565px">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">修改密码：</label>
            <div class="layui-input-inline">
                <input type="password" id="password" name="password" lay-verify="password" autocomplete="off"
                       class="layui-input" placeholder="密码不能少于6位">
            </div>
        </div>
        <button type="button" id="passwordTj" class="layui-btn layui-btn-normal">确定</button>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">修改昵称：</label>
            <div class="layui-input-inline">
                <input type="text" id="name" name="name" lay-verify="name" autocomplete="off" class="layui-input">
            </div>
        </div>
        <button type="button" id="nameTj" class="layui-btn layui-btn-warm">确定</button>
    </div>
</div>

<!--图片裁剪框 start-->
<div style="display: none" class="tailoring-container">
    <div class="black-cloth" onclick="closeTailor(this)"></div>
    <div class="tailoring-content">
        <div class="tailoring-content-one">

            <div class="close-tailoring" onclick="closeTailor(this)">×</div>
        </div>

        <div class="tailoring-content-two">
            <div class="tailoring-box-parcel">
                <img id="tailoringImg">
            </div>
            <div class="preview-box-parcel">
                <p>图片预览：</p>
                <div class="square previewImg"></div>
                <!--  <div class="circular previewImg"></div>-->
            </div>
        </div>

        <div class="tailoring-content-three">
            <button class="l-btn cropper-reset-btn">复位</button>
            <button class="l-btn cropper-rotate-btn">旋转</button>
            <button class="l-btn cropper-scaleX-btn">换向</button>
            <button class="l-btn sureCut" id="sureCut">确定</button>
        </div>
    </div>
</div>
<!--图片裁剪框 end-->

<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/cropper.min.js"></script>
<script src="<c:url value="/lib/layui/layui.js"/>"></script>
<script type="text/javascript">
    //弹出框水平垂直居中
    (window.onresize = function() {
        var win_height = $(window).height();
        var win_width = $(window).width();
        if (win_width <= 768) {
            $(".tailoring-content").css(
                {
                    "top" : (win_height - $(".tailoring-content")
                        .outerHeight()) / 2,
                    "left" : 0
                });
        } else {
            $(".tailoring-content").css(
                {
                    "top" : (win_height - $(".tailoring-content")
                        .outerHeight()) / 2,
                    "left" : (win_width - $(".tailoring-content")
                        .outerWidth()) / 2
                });
        }
    })();

    // 选择文件触发事件
    function selectImg(file) {
        //文件为空，返回
        if (!file.files || !file.files[0]) {
            return;
        }
        $(".tailoring-container").toggle();
        var reader = new FileReader();
        reader.onload = function(evt) {
            var replaceSrc = evt.target.result;
            // 更换cropper的图片
            $('#tailoringImg').cropper('replace', replaceSrc, false);// 默认false，适应高度，不失真
        }
        reader.readAsDataURL(file.files[0]);
    }
    // cropper图片裁剪
    $('#tailoringImg').cropper({
        aspectRatio : 1 / 1,// 默认比例
        preview : '.previewImg',// 预览视图
        guides : false, // 裁剪框的虚线(九宫格)
        autoCropArea : 0.5, // 0-1之间的数值，定义自动剪裁区域的大小，默认0.8
        movable : false, // 是否允许移动图片
        dragCrop : true, // 是否允许移除当前的剪裁框，并通过拖动来新建一个剪裁框区域
        movable : true, // 是否允许移动剪裁框
        resizable : true, // 是否允许改变裁剪框的大小
        zoomable : false, // 是否允许缩放图片大小
        mouseWheelZoom : false, // 是否允许通过鼠标滚轮来缩放图片
        touchDragZoom : true, // 是否允许通过触摸移动来缩放图片
        rotatable : true, // 是否允许旋转图片
        crop : function(e) {
            // 输出结果数据裁剪图像。
        }
    });
    // 旋转
    $(".cropper-rotate-btn").on("click", function() {
        $('#tailoringImg').cropper("rotate", 45);
    });
    // 复位
    $(".cropper-reset-btn").on("click", function() {
        $('#tailoringImg').cropper("reset");
    });
    // 换向
    var flagX = true;
    $(".cropper-scaleX-btn").on("click", function() {
        if (flagX) {
            $('#tailoringImg').cropper("scaleX", -1);
            flagX = false;
        } else {
            $('#tailoringImg').cropper("scaleX", 1);
            flagX = true;
        }
        flagX != flagX;
    });

    // 确定按钮点击事件
    $("#sureCut").on("click", function() {
        if ($("#tailoringImg").attr("src") == null) {
            return false;
        } else {
            var cas = $('#tailoringImg').cropper('getCroppedCanvas');// 获取被裁剪后的canvas
            var base64 = cas.toDataURL('image/jpeg'); // 转换为base64

            $("#finalImg").prop("src", base64);// 显示图片
            uploadFile(encodeURIComponent(base64))//编码后上传服务器
            closeTailor();// 关闭裁剪框
        }
    });

    // 关闭裁剪框
    function closeTailor() {
        $(".tailoring-container").toggle();
    }

    //ajax请求上传
    function uploadFile(file) {
        $.ajax({
            url : '<c:url value="/uploadPhoto.do"/>',
            type : 'POST',
            data : "file=" + file,
            async : true,
            success : function(data) {
                console.log(data);
            }
        });
    }
</script>

<script>
    layui.use(['form','table','layer','laydate','layedit'], function() {
        var $ = layui.$
            , table = layui.table
            , form = layui.form
            , layer = layui.layer
            , laydate = layui.laydate
            , layedit = layui.layedit;

        $("#nameTj").click(function () {
            var name = $("#name").val();
            if (name=="" || name==null){
                layer.msg("请输入需要修改的昵称",{
                    time: 20000, //20s后自动关闭
                    btnAlign: 'c',
                    btn: ['确定']
                });
                return;
            }
            $.ajax({
                type:"POST",
                url: '<c:url value="/updName.do"/>',
                data: "&name="+name,
                success:function (msg) {
                    if (msg=="成功"){
                        layer.msg("修改成功！！！",{
                            time: 20000, //20s后自动关闭
                            btnAlign: 'c',
                            btn: ['确定']
                        });
                    }
                    $("#name").val("");
                }
            })
        })

        $("#passwordTj").click(function () {
                var password = $("#password").val();
                if (password=="" || password==null){
                    layer.msg("请输入需要修改的密码",{
                        time: 20000, //20s后自动关闭
                        btnAlign: 'c',
                        btn: ['确定']
                    });
                    return;
                }
                if ($("#password").val().length<6){
                    layer.msg("密码不能小于6位",{
                        time: 20000, //20s后自动关闭
                        btnAlign: 'c',
                        btn: ['确定']
                    });
                    $("#password").val("");
                    return;
                }

                $.ajax({
                    type:"POST",
                    url: '<c:url value="/updPwd.do"/>',
                    data: "&password="+password,
                    success:function (msg) {
                        if (msg=="成功"){
                            layer.msg("修改成功！！！",{
                                time: 20000, //20s后自动关闭
                                btnAlign: 'c',
                                btn: ['确定']
                            });
                        }
                        $("#password").val("");
                    }
                })
            })
    });
</script>
</body>
</html>
