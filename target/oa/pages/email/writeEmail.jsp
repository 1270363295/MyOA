<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/21
  Time: 17:16
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>写邮件</title>
    <script src="<c:url value="/js/jquery-1.12.4.js"/>"></script>
    <link rel="stylesheet" href="../../static/css/font.css">
    <link rel="stylesheet" href="../../static/css/weadmin.css">
    <script src="<c:url value="/lib/layui/layui.js"/>"></script>
    <link rel="stylesheet" type="text/css" href="<c:url value="/lib/layui/css/layui.css"/>">

    <style>
        .layui-table-cell .layui-form-checkbox[lay-skin="primary"]{
            top: 50%;
            transform: translateY(-50%);
        }

        .fileBox{margin:50px;}
        .fileInputP{display:inline-block;width:200px;height:30px;border-radius:5px;overflow:hidden;position:relative;}
        .fileInputP i{display:inline-block;width:200px;height:30px;color:#fff;background:#7d8f33;text-align:center;line-height:30px;}
        #fileInput{position:absolute;left:0;top:0;right:0;bottom:0;opacity:0;}
        #fileSpan{display:inline-block;width:300px;height:150px;border:2px dashed #ccc;text-align:center;line-height:150px;}

        .fileList_parent{margin:50px;display:none;}
        .fileList_parent th{background:#dadada;font-weight:bold;}
        .fileList_parent th,.fileList_parent td{padding:5px;}
        .fileList tr:nth-of-type(2n){background:#dadada;}

        .progressParent{width:200px;height:20px;border-radius:5px;background:#ccc;overflow:hidden;position:relative;}
        .progress{width:0%;height:20px;background:#7d8f33;}
        .progressNum{display:inline-block;width:100%;height:20px;text-align:center;line-height:20px;color:#fff;position:absolute;left:0;top:0;}

        #fileBtn{margin-left:50px;display:none;}
    </style>
</head>

<body>
<form class="layui-form layui-form-pane" style="margin-top: 100px; margin-left: 350px">
    <%--    发件人    --%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 150px">发件人：</label>
            <div class="layui-input-inline" style="width: 575px">
                <input id="addresser" name="addresser" lay-verify="required"
                       type="text" autocomplete="off" class="layui-input" value="${user.emp_name}" disabled>
            </div>
        </div>
    </div>

    <%--    收件人    --%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 150px">收件人：</label>
            <div class="layui-input-inline" style="width: 575px">
                <input id="recipients" name="recipients" lay-verify="required"
                       type="text" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <%--     主题   --%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 150px">主题：</label>
            <div class="layui-input-inline" style="width: 575px">
                <input id="title" name="title" lay-verify="required"
                       type="text" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <%--    内容   --%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 150px" >内容：</label>
            <div class="layui-input-block" style="width: 615px">
            <textarea id="content" name="content"
                      lay-verify="required" class="layui-textarea"></textarea>
            </div>
        </div>
    </div>

    <%--     文件级别   --%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 150px">是否重要文件</label>
        <div class="layui-input-block" style="margin-top: 10px">
            <input type="checkbox" id="type" name="type" lay-skin="primary">
        </div>
    </div>


    <div style="margin-top: 50px;margin-left: 65px">
        <div class="fileBox">
            <p class="fileInputP vm">
                <i>选择附件</i>
                <input type="file" multiple id="fileInput" />
            </p>
            <div class="mask"></div>
        </div>

        <table width="50%" border="1" class="fileList_parent" style="margin-left: 145px">
            <thead>
            <tr>
                <th>文件名</th>
                <th>类型</th>
                <th>大小</th>
                <th>进度</th>
                <th>状态</th>
            </tr>
            </thead>

            <tbody class="fileList">

            </tbody>

        </table>

        <input type="button" value="发送" id="fileBtn"  class="layui-btn layui-btn-normal" style="margin-left: 150px" />

    </div>

    <div class="layui-form-item" style="margin-left: 430px">
        <a id="drafts" lay-event="drafts" class="layui-btn layui-btn-normal">
            <i class="layui-icon layui-icon-add-circle"></i>放入草稿箱
        </a>


        <a id="send" lay-event="send" class="layui-btn layui-btn-danger">
            <i class="layui-icon layui-icon-release"></i>不带附件发送
        </a>
    </div>
</form>


<script>
    layui.use(['form','table','layer','laydate','layedit'], function() {
        var $ = layui.$
            , table = layui.table
            , form = layui.form
            , layer = layui.layer
            , laydate = layui.laydate
            , layedit = layui.layedit;


        //发送邮件
        $("#send").click(function () {
            alert("发送邮件");

            if ($('#type').attr('checked')) {
                var typeid=2;
                var recipients=$('#recipients').val();
                var title=$('#title').val();
                var content=$('#content').val();
                $.ajax({
                    type:'post',
                    url:'<c:url value="/writeEmail.do"/>',
                    dataType:'text',
                    data:'&recipients='+recipients+'&title='+title+'&content='+content+'&typeid='+typeid,
                    success:function (msg) {
                        layer.msg(msg,{
                            time: 20000, //20s后自动关闭
                            btnAlign: 'c',
                            btn: ['确定']
                        });
                        location.href="writeEmail.jsp";
                    }
                })
            } else {
                var typeid=1;
                var recipients=$('#recipients').val();
                var title=$('#title').val();
                var content=$('#content').val();
                $.ajax({
                    type:'post',
                    url:'<c:url value="/writeEmail.do"/>',
                    dataType:'text',
                    data:'&recipients='+recipients+'&title='+title+'&content='+content+'&typeid='+typeid,
                    success:function (msg) {
                        layer.msg(msg,{
                            time: 20000, //20s后自动关闭
                            btnAlign: 'c',
                            btn: ['确定']
                        });
                        location.href="writeEmail.jsp";
                    }
                })
            }
        })


        //放入草稿箱
        $("#drafts").click(function () {
            alert("邮件放入草稿箱");
            if ($('#type').attr('checked')) {
                var typeid=2;
                var recipients=$('#recipients').val();
                var title=$('#title').val();
                var content=$('#content').val();
                $.ajax({
                    type:'post',
                    url:'<c:url value="/createDrafts.do"/>',
                    dataType:'text',
                    data:'&recipients='+recipients+'&title='+title+'&content='+content+'&typeid='+typeid,
                    success:function (msg) {
                        layer.msg(msg,{
                            time: 20000, //20s后自动关闭
                            btnAlign: 'c',
                            btn: ['确定']
                        });
                        location.href="writeEmail.jsp";
                    }

                })
            } else {
                var typeid=1;
                var recipients=$('#recipients').val();
                var title=$('#title').val();
                var content=$('#content').val();
                $.ajax({
                    type:'post',
                    url:'<c:url value="/createDrafts.do"/>',
                    dataType:'text',
                    data:'&recipients='+recipients+'&title='+title+'&content='+content+'&typeid='+typeid,
                    success:function (msg) {
                        layer.msg(msg,{
                            time: 20000, //20s后自动关闭
                            btnAlign: 'c',
                            btn: ['确定']
                        });
                        location.href="writeEmail.jsp";
                    }
                })
            }
        })


    })
</script>


<script>
    layui.use('layer', function(){ //独立版的layer无需执行这一句
        var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句
        $(function(){

            //元素
            var oFileBox = $(".fileBox");					//选择文件父级盒子
            var oFileInput = $("#fileInput");				//选择文件按钮
            var oFileSpan = $("#fileSpan");					//选择文件框

            var oFileList_parent = $(".fileList_parent");	//表格
            var oFileList = $(".fileList");					//表格tbody
            var oFileBtn = $("#fileBtn");					//上传按钮

            var flieList = [];								//数据，为一个复合数组
            var sizeObj = [];								//存放每个文件大小的数组，用来比较去重


            //点击选择文件按钮选文件
            oFileInput.on("change",function(){
                analysisList(this.files);
            })

            //解析列表函数
            function analysisList(obj){
                //如果没有文件
                if( obj.length<1 ){
                    return false;
                }

                for( var i=0;i<obj.length;i++ ){

                    var fileObj = obj[i];		//单个文件
                    var name = fileObj.name;	//文件名
                    var size = fileObj.size;	//文件大小
                    var type = fileType(name);	//文件类型，获取的是文件的后缀

                    //文件大于30M，就不上传
                    if( size > 1024*1024*30 || size == 0 ){
                        alert('“'+ name +'”超过了30M，不能上传');
                        return;
                        continue;
                    }

                    //文件类型不为这三种，就不上传
                    /*if( ("pdf/txt/epub").indexOf(type) == -1 ){
                        alert('“'+ name +'”文件类型不对，不能上传');
                        continue;
                    }*/

                    //把文件大小放到一个数组中，然后再去比较，如果有比较上的，就认为重复了，不能上传
                    if( sizeObj.indexOf(size) != -1 ){
                        alert('“'+ name +'”已经选择，不能重复上传');
                        continue;
                    }

                    //给json对象添加内容，得到选择的文件的数据
                    var itemArr = [fileObj,name,size,type];	//文件，文件名，文件大小，文件类型
                    flieList.push(itemArr);

                    //把这个文件的大小放进数组中
                    sizeObj.push(size);

                }

                //console.log(flieList)
                //console.log(sizeObj)
                createList()				//生成列表
                oFileList_parent.show();	//表格显示
                oFileBtn.show();			//上传按钮显示
            };


            //生成列表
            function createList(){
                oFileList.empty();					//先清空元素内容
                for( var i=0;i<flieList.length;i++ ){

                    var fileData = flieList[i];		//flieList数组中的某一个
                    var objData = fileData[0];		//文件
                    var name = fileData[1];			//文件名
                    var size = fileData[2];			//文件大小
                    var type = fileData[3];			//文件类型
                    var volume = bytesToSize(size);	//文件大小格式化


                    var oTr = $("<tr></tr>");
                    var str = '<td><cite title="'+ name +'">'+ name +'</cite></td>';
                    str += '<td>'+ type +'</td>';
                    str += '<td>'+ volume +'</td>';
                    str += '<td>';
                    str += '<div class="progressParent">';
                    str += '<p class="progress"></p>';
                    str += '<span class="progressNum">0%</span>';
                    str += '</div>';
                    str += '</td>';
                    str += '<td><a href="javascript:;" class="operation">删除</a></td>';

                    oTr.html(str);
                    oTr.appendTo( oFileList );
                }
            }

            //删除表格行
            oFileList.on("click","a.operation",function(){
                var oTr = $(this).parents("tr");
                var index = oTr.index();
                oTr.remove();		//删除这一行
                flieList.splice(index,1);	//删除数据
                sizeObj.splice(index,1);	//删除文件大小数组中的项

                //console.log(flieList);
                //console.log(sizeObj);

            });


            //上传
            oFileBtn.on("click",function(){


                if ($('#type').attr('checked')) {
                    var typeid = 2;
                    var recipients = $('#recipients').val();
                    var title = $('#title').val();
                    var content = $('#content').val();

                    oFileBtn.off();
                    var tr = oFileList.find("tr");		//获取所有tr列表
                    var successNum = 0;					//已上传成功的数目
                    oFileList.off();					//取消删除事件
                    oFileBox.slideUp();					//隐藏输入框
                    oFileList.find("a.operation").text("等待上传");


                    for( var i=0;i<tr.length;i++ ){
                        uploadFn(tr.eq(i),i);		//参数为当前项，下标
                    }

                    function uploadFn(obj,i){

                        var formData = new FormData();
                        var arrNow = flieList[i];						//获取数据数组的当前项

                        // 从当前项中获取上传文件，放到 formData对象里面，formData参数以key name的方式
                        var result = arrNow[0];							//数据
                        formData.append("imageFile" , result);

                        var name = arrNow[1];							//文件名
                        formData.append("email" , name);

                        // formData.append("remark",remark);

                        var progress = obj.find(".progress");			//上传进度背景元素
                        var progressNum = obj.find(".progressNum");		//上传进度元素文字
                        var oOperation = obj.find("a.operation");		//按钮

                        oOperation.text("正在上传");							//改变操作按钮
                        oOperation.off();

                        var request = $.ajax({
                            type: "POST",
                            url: '<c:url value="/writeEmailWithAcc.do?recipients="/>'+recipients+"&title="+title+"&content="+content+"&typeid="+typeid ,
                            data: formData,			//这里上传的数据使用了formData 对象
                            processData : false, 	//必须false才会自动加上正确的Content-Type
                            contentType : false,

                            //这里我们先拿到jQuery产生的XMLHttpRequest对象，为其增加 progress 事件绑定，然后再返回交给ajax使用
                            xhr: function(){
                                var xhr = $.ajaxSettings.xhr();
                                if(onprogress && xhr.upload) {
                                    xhr.upload.addEventListener("progress" , onprogress, false);
                                    return xhr;
                                }
                            },

                            //上传成功后回调
                            success: function(msg){
                                layer.msg("发送成功",{
                                    time: 20000, //20s后自动关闭
                                    btnAlign: 'c',
                                    btn: ['确定']
                                });
                                location.href="writeEmail.jsp";
                            },

                        });


                        //侦查附件上传情况 ,这个方法大概0.05-0.1秒执行一次
                        function onprogress(evt){
                            var loaded = evt.loaded;	//已经上传大小情况
                            var tot = evt.total;		//附件总大小
                            var per = Math.floor(100*loaded/tot);  //已经上传的百分比
                            progressNum.html( per +"%" );
                            progress.css("width" , per +"%");
                        }

                    }

                } else {
                    var typeid = 1;
                    var recipients = $('#recipients').val();
                    var title = $('#title').val();
                    var content = $('#content').val();

                    oFileBtn.off();
                    var tr = oFileList.find("tr");		//获取所有tr列表
                    var successNum = 0;					//已上传成功的数目
                    oFileList.off();					//取消删除事件
                    oFileBox.slideUp();					//隐藏输入框
                    oFileList.find("a.operation").text("等待上传");


                    for( var i=0;i<tr.length;i++ ){
                        uploadFn(tr.eq(i),i);		//参数为当前项，下标
                    }

                    function uploadFn(obj,i){

                        var formData = new FormData();
                        var arrNow = flieList[i];						//获取数据数组的当前项

                        // 从当前项中获取上传文件，放到 formData对象里面，formData参数以key name的方式
                        var result = arrNow[0];							//数据
                        formData.append("imageFile" , result);

                        var name = arrNow[1];							//文件名
                        formData.append("email" , name);

                        // formData.append("remark",remark);

                        var progress = obj.find(".progress");			//上传进度背景元素
                        var progressNum = obj.find(".progressNum");		//上传进度元素文字
                        var oOperation = obj.find("a.operation");		//按钮

                        oOperation.text("正在上传");							//改变操作按钮
                        oOperation.off();

                        var request = $.ajax({
                            type: "POST",
                            url: '<c:url value="/writeEmailWithAcc.do?recipients="/>'+recipients+"&title="+title+"&content="+content+"&typeid="+typeid ,
                            data: formData,			//这里上传的数据使用了formData 对象
                            processData : false, 	//必须false才会自动加上正确的Content-Type
                            contentType : false,

                            //这里我们先拿到jQuery产生的XMLHttpRequest对象，为其增加 progress 事件绑定，然后再返回交给ajax使用
                            xhr: function(){
                                var xhr = $.ajaxSettings.xhr();
                                if(onprogress && xhr.upload) {
                                    xhr.upload.addEventListener("progress" , onprogress, false);
                                    return xhr;
                                }
                            },

                            //上传成功后回调
                            success: function(msg){
                                layer.msg("发送成功",{
                                    time: 20000, //20s后自动关闭
                                    btnAlign: 'c',
                                    btn: ['确定']
                                });
                                location.href="writeEmail.jsp";
                            },

                        });


                        //侦查附件上传情况 ,这个方法大概0.05-0.1秒执行一次
                        function onprogress(evt){
                            var loaded = evt.loaded;	//已经上传大小情况
                            var tot = evt.total;		//附件总大小
                            var per = Math.floor(100*loaded/tot);  //已经上传的百分比
                            progressNum.html( per +"%" );
                            progress.css("width" , per +"%");
                        }

                    }
                }


                <%--oFileBtn.off();--%>
                <%--var tr = oFileList.find("tr");		//获取所有tr列表--%>
                <%--var successNum = 0;					//已上传成功的数目--%>
                <%--oFileList.off();					//取消删除事件--%>
                <%--oFileBox.slideUp();					//隐藏输入框--%>
                <%--oFileList.find("a.operation").text("等待上传");--%>


                <%--for( var i=0;i<tr.length;i++ ){--%>
                <%--    uploadFn(tr.eq(i),i);		//参数为当前项，下标--%>
                <%--}--%>

                <%--function uploadFn(obj,i){--%>

                <%--    var formData = new FormData();--%>
                <%--    var arrNow = flieList[i];						//获取数据数组的当前项--%>

                <%--    // 从当前项中获取上传文件，放到 formData对象里面，formData参数以key name的方式--%>
                <%--    var result = arrNow[0];							//数据--%>
                <%--    formData.append("imageFile" , result);--%>

                <%--    var name = arrNow[1];							//文件名--%>
                <%--    formData.append("email" , name);--%>

                <%--    // formData.append("remark",remark);--%>

                <%--    var progress = obj.find(".progress");			//上传进度背景元素--%>
                <%--    var progressNum = obj.find(".progressNum");		//上传进度元素文字--%>
                <%--    var oOperation = obj.find("a.operation");		//按钮--%>

                <%--    oOperation.text("正在上传");							//改变操作按钮--%>
                <%--    oOperation.off();--%>

                <%--    var request = $.ajax({--%>
                <%--        type: "POST",--%>
                <%--        url: '<c:url value="/writeEmailWithAcc.do?recipients="/>'+recipients+"&title"+title+"&content"+content+"&typeid"+typeid ,--%>
                <%--        data: formData,			//这里上传的数据使用了formData 对象--%>
                <%--        processData : false, 	//必须false才会自动加上正确的Content-Type--%>
                <%--        contentType : false,--%>

                <%--        //这里我们先拿到jQuery产生的XMLHttpRequest对象，为其增加 progress 事件绑定，然后再返回交给ajax使用--%>
                <%--        xhr: function(){--%>
                <%--            var xhr = $.ajaxSettings.xhr();--%>
                <%--            if(onprogress && xhr.upload) {--%>
                <%--                xhr.upload.addEventListener("progress" , onprogress, false);--%>
                <%--                return xhr;--%>
                <%--            }--%>
                <%--        },--%>

                <%--        //上传成功后回调--%>
                <%--        success: function(msg){--%>
                <%--            --%>
                <%--        },--%>

                <%--    });--%>


                <%--    //侦查附件上传情况 ,这个方法大概0.05-0.1秒执行一次--%>
                <%--    function onprogress(evt){--%>
                <%--        var loaded = evt.loaded;	//已经上传大小情况--%>
                <%--        var tot = evt.total;		//附件总大小--%>
                <%--        var per = Math.floor(100*loaded/tot);  //已经上传的百分比--%>
                <%--        progressNum.html( per +"%" );--%>
                <%--        progress.css("width" , per +"%");--%>
                <%--    }--%>

                <%--}--%>


            });


        })


        //字节大小转换，参数为b
        function bytesToSize(bytes) {
            var sizes = ['Bytes', 'KB', 'MB'];
            if (bytes == 0) return 'n/a';
            var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
            return (bytes / Math.pow(1024, i)).toFixed(1) + ' ' + sizes[i];
        };

        //通过文件名，返回文件的后缀名
        function fileType(name){
            var nameArr = name.split(".");
            return nameArr[nameArr.length-1].toLowerCase();
        }
    });


</script>
</body>
</html>
