<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
	<%
		String path = request.getContextPath();
	%>
	<link rel="stylesheet" href="<%=path %>/css/mainstructure.css">
	<link rel="stylesheet" href="<%=path %>/css/maincontent.css">
	<!-- Jquery and Jquery UI -->

	<script type="text/javascript" src="<%=path %>/js/jquery-1.4.2.min.js"></script>

	<script type="text/javascript" src="<%=path %>/js/jquery-ui-1.8.6.custom.min.js"></script>

	<script type="text/javascript" src="<%=path %>/js/jquery-ui-timepicker-addon.js"></script>

	<link rel="stylesheet" href="<%=path %>/css/redmond/jquery-ui-1.8.1.custom.css">

	<!-- Jquery and Jquery UI -->

	<script src="<%=path %>/js/formValidator/js/jquery.validationEngine.js" type="text/javascript"></script>

	<script src="<%=path %>/js/formValidator/js/jquery.validationEngine-en.js" type="text/javascript"></script>

	<link rel="stylesheet" href="<%=path %>/js/formValidator/css/validationEngine.jquery.css" type="text/css" media="screen" charset="utf-8" />

	<!-- FullCalender -->

	<link rel='stylesheet' type='text/css' href='<%=path %>/js/fullcal/css/fullcalendar.css' />
	<script type='text/javascript' src='<%=path %>/js/fullcal/fullcalendar.js'></script>

</head>
<body>
<style type='text/css'>
	body {
		margin-top: 40px;
		text-align: center;
		font-size: 13px;
		font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
	}
	#loading {
		TOP: 0px; RIGHT: 0px
	}
	.tooltip {
		PADDING-BOTTOM: 25px; PADDING-LEFT: 25px; WIDTH: 160px; PADDING-RIGHT: 25px; DISPLAY: none; BACKGROUND: url(images/black_arrow.png); HEIGHT: 70px; COLOR: #fff; FONT-SIZE: 12px; PADDING-TOP: 25px; z-order: 100
	}
	#calendar {
		width: 900px;
		margin: 0 auto;
	}
</style>

<DIV id=wrap>
	<script type='text/javascript'>
		var contextPath ="<%=path %>";//上下文环境
		$(document).ready(function() {
			
			$("#reserveformID").validationEngine({
				validationEventTriggers:"keyup blur",
				openDebug: true
			}) ;

			$("#start").datetimepicker({
				dateFormat:'yy-mm-dd', timeFormat:'hh:mm', hourMin: 5, hourMax: 24, hourGrid: 3, minuteGrid: 15,
				monthNames : [ "一月", "二月", "三月",
					"四月", "五月", "六月", "七月",
					"八月", "九月", "十月", "十一月",
					"十二月" ],
				dayNamesMin: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"],
				timeText: '时间 ',
				hourText: '小时 ',
				minuteText: '分钟 ',
				currentText: '现在 ',
				closeText:'选择 ',

			});

			$("#end").datetimepicker({
				dateFormat:'yy-mm-dd', timeFormat:'hh:mm', hourMin: 5, hourMax: 24, hourGrid: 3,
				minuteGrid: 15,
				monthNames : [ "一月", "二月", "三月","四月", "五月", "六月", "七月",
					"八月", "九月", "十月", "十一月","十二月" ],
				dayNamesMin: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"],
				timeText: '时间 ',
				hourText: '小时 ',
				minuteText: '分钟 ',
				currentText: '现在 ',
				closeText:'选择 ',

			});
			$("#addhelper").hide();


			var date = new Date();
			var d = date.getDate();
			var m = date.getMonth();
			var y = date.getFullYear();

			$('#calendar').fullCalendar(
					{
						theme : true,
						header : {
							left : 'prev,next today',
							center : 'title',
							right : 'month,agendaWeek,agendaDay'
						},
						monthNames : [ "一月", "二月", "三月",
							"四月", "五月", "六月", "七月",
							"八月", "九月", "十月", "十一月",
							"十二月" ],
						monthNamesShort : [ "一月", "二月",
							"三月", "四月", "五月", "六月",
							"七月", "八月", "九月", "十月",
							"十一月", "十二月" ],
						dayNames : [ "周日", "周一", "周二",
							"周三", "周四", "周五", "周六" ],
						dayNamesShort : [ "周日", "周一", "周二",
							"周三", "周四", "周五", "周六" ],
						today : [ "今天" ],
						editable : true,
						buttonText : {
							today : '本月',
							month : '月',
							week : '周',
							day : '日',
							prev : '上一月',
							next : '下一月'

						},

						editable : true,
						eventMouseover : function(calEvent, jsEvent, view) {
							$(this).css('border-color', 'red');
							$(this).attr('title', "日程标题 :"+calEvent.title +"日程内容: "+calEvent.description);
							$(this).css('font-weight', 'normal');
							$(this).tooltip({
								effect:'toggle',
								cancelDefault: true
							});
						},
						eventMouseout : function(event) {
							$(this).css('font-weight', 'normal');
							$(this).css('border-color','blue');
						},
						eventRender: function(event, element) {
							var fstart  = $.fullCalendar.formatDate(event.start, "HH:mm");
							var fend  = $.fullCalendar.formatDate(event.end, "HH:mm");
							// Bug in IE8
							//element.html('<a href=#>' + fstart + "-" +  fend + '<div style=color:#E5E5E5>' +  event.title + "</div></a>");
						},

						//编辑 日程
						timeFormat: 'HH:mm{ - HH:mm}',
						eventClick: function(event) {//日程区块，单击时触发
							var fstart  = $.fullCalendar.formatDate(event.start, "yyyy-MM-dd HH:mm");
							var fend  = $.fullCalendar.formatDate(event.end, "yyyy-MM-dd HH:mm");
							var selectdate = $.fullCalendar.formatDate(event.start, "yyyy-MM-dd");
							
							$("#sId").val(event.sId);
							$("#id").val(event.id);
							$("#start").val(fstart); 
							$("#end").val(fend);
							$("#title").val(event.title); //标题
							$("#details").val(event.description); //内容
							$("#reservebox").dialog({
								autoOpen: false,
								height: 450,
								width: 400,
								title: '日程计划 ',
								modal: true,
								position: "center",
								draggable: false,
								beforeClose: function (event, ui) {
									$("#sId").val(''); //开始时间
									$("#start").val(''); //开始时间
									$("#end").val(''); //结束时间
									$("#title").val(''); //标题
									$("#details").val(''); //内容
								},
								timeFormat: 'HH:mm{ - HH:mm}',
								buttons: {
									"删除": function () {
										var aa = window.confirm("警告：确定要删除记录，删除后无法恢复！");
										if (aa) {
											var para = { id: event.sId };
											$.ajax({
												type: "POST", //使用post方法访问后台
												//url: "deldata!DelSchedule.action", //要访问的后台地址
												url: contextPath+"/schedule/del.do", //要访问的后台地址
												data: para, //要发送的数据
												success: function (data) {
													//对话框里面的数据提交完成，data为操作结果
													$('#calendar').fullCalendar('removeEvents', event.id);
												}
											});
										}
										$(this).dialog("close");
									},
									"修改": function () {
										var startdatestr = $("#start").val(); //开始时间
										var enddatestr = $("#end").val(); //结束时间
										var title = $("#title").val(); //标题
										var det = $("#details").val(); //内容
										var sId = $("#sId").val(); //主键id
										var startdate = $.fullCalendar.parseDate(startdatestr);
										var enddate = $.fullCalendar.parseDate(enddatestr);
										var sjc=(enddate-startdate)/3600000;
										var startime=$.fullCalendar.formatDate(startdate, "HH");
										var startday=$.fullCalendar.formatDate(event.start, "dd");
										var endday=$.fullCalendar.formatDate(enddate, "dd");
										var daycha=endday-startday;
										if(daycha<0){
											alert("结束时间有误 ");
										}else{
											if(startime<8 && sjc>=8){
												event.allDay = true;
											}else{
												event.allDay = false;
											}
											event.title = title;
											event.start = startdate;
											event.end = enddate;
											event.description = det;
											event.sId=sId;
											//更新 计划
											var schdata = { sId:sId,title: title, description: det,beginTime: startdatestr, endTime: enddatestr, id: event.id };
											// $('#calendar').fullCalendar('updateEvent', event);
											$.ajax({
												type: "POST", //使用post方法访问后台
												//url: "updatedata!UpdateSchedule.action", //要访问的后台地址
												url: contextPath+"/schedule/update.do", //要访问的后台地址
												data: schdata, //要发送的数据
												success: function (data) {
													//对话框里面的数据提交完成，data为操作结果
													$('#calendar').fullCalendar('updateEvent', event);
												}
											});
											$(this).dialog("close");
										}
									}
								}
							});
							$("#reservebox").dialog("open");
							return false;
						},
						/* events : contextPath+"/schedule/list.do", */
						
						eventDrop : function(event, delta) {

						},
						loading : function(bool) {
							if (bool)
								$('#loading').show();
							else
								$('#loading').hide();
						},

						dayClick : function(date, allDay,jsEvent, view) {//空白的日期区，单击时触发

							var selectdate = $.fullCalendar.formatDate(date, "yyyy年MM月dd");
							var eventid = $.fullCalendar.formatDate(new Date(), "yyyyMMddHHmmss");
							$("#id").val(eventid);
							//var eventid = $.fullCalendar.formatDate(startdate, "yyyyMMddHHmm");

							$( "#reservebox" ).dialog({
								autoOpen: false,
								height: 450,
								width: 400,
								title: selectdate+ ' 的日程计划： ',
								modal: true,
								position: "center",
								draggable: false,
								beforeClose: function(event, ui) {
									$("#start").val(''); //开始时间
									$("#end").val(''); //结束时间
									$("#title").val(''); //标题
									$("#details").val(''); //内容
								},
								buttons: {
									"关闭 ": function() {
										$( this ).dialog( "close" );
									},
									"添加计划": function() {
										var startdatestr = $("#start").val();
										var enddatestr = $("#end").val();
										var title = $("#title").val();	//标题
										var det=$("#details").val();   //内容
										var id=$("#id").val();
									//	alert(startdatestr);
										var startdate = $.fullCalendar.parseDate(startdatestr);
										var enddate = $.fullCalendar.parseDate(enddatestr);
										var schdata = {id:id,title:title,beginTime:startdatestr, endTime:enddatestr, description:det };
										//var schdata2=JSON.stringify(schdata);
										//$('#calendar').fullCalendar('renderEvent', event,true);
										//写进数据库 
										$.ajax({
											type: "POST", //使用post方法访问后台
											//url: "senddata!AddSchedule.action", //要访问的后台地址
											url: contextPath+"/schedule/add.do", //要访问的后台地址
											data: schdata, //要发送的数据
											// dataType:"json",
											success: function (data) {
												//对话框里面的数据提交完成，data为操作结果

												//添加到日历
												event.id= eventid;
												event.title = title;
												event.start = startdate;
												event.end = enddate;
												event.description = det;
												event.allDay=false;
												$('#calendar').fullCalendar('renderEvent', event,true);
											}
										});
										$( this ).dialog( "close" );
										location.href="dateCalendar.jsp";
									}
								}
							});
							$( "#reservebox" ).dialog( "open" );
							return false;
						},

						selectable: true,
						selectHelper: true,
						select: function(start, end, allDay) {
							var view=$('#calendar').fullCalendar('getView');
//判断所在的视图  不在月视图的话启动功能 
							if(view.name!="month"){
								var eventid = $.fullCalendar.formatDate(new Date(), "yyyyMMddHHmmss");
								$("#id").val(eventid);
								var selectdate = $.fullCalendar.formatDate(start, "yyyy年MM月dd日");
								var startdate = $.fullCalendar.formatDate(start, "yyyy-MM-dd HH:mm");
								var enddate = $.fullCalendar.formatDate(end, "yyyy-MM-dd HH:mm");
								$("#start").val(startdate);
								$("#end").val(enddate);


								$( "#reservebox" ).dialog({
									autoOpen: false,
									height: 450,
									width: 400,
									title: selectdate+ ' 的日程计划： ',
									modal: true,
									position: "center",
									draggable: false,
									beforeClose: function(event, ui) {
										$.validationEngine.closePrompt("#title");
										$.validationEngine.closePrompt("#start");
										$.validationEngine.closePrompt("#end");
									},
									buttons: {
										"关闭 ": function() {
											$( this ).dialog( "close" );
										},
										"添加计划": function() {
											var startdatestr = $("#start").val();
											var enddatestr = $("#end").val();
											var title = $("#title").val();	//标题 
											var det=$("#details").val();   //内容
											var id=$("#id").val();
											//alert(startdatestr);
											var startdate = $.fullCalendar.parseDate(startdatestr);
											var enddate = $.fullCalendar.parseDate(enddatestr);
											var schdata = {id:id,title:title,beginTime:startdatestr, endTime:enddatestr, description:det };
											//var schdata2=JSON.stringify(schdata);
											//$('#calendar').fullCalendar('renderEvent', event,true);
											//写进数据库
											$.ajax({
												type: "POST", //使用post方法访问后台
												url: "senddata!AddSchedule.action", //要访问的后台地址
												data: schdata, //要发送的数据
												// dataType:"json",
												success: function (data) {
													//对话框里面的数据提交完成，data为操作结果
													//alert("SUCCESS");
													//添加到日历
													event.id= eventid;
													event.title = title;
													event.start = startdate;
													event.end = enddate;
													event.description = det;
													event.allDay=allDay;
													$('#calendar').fullCalendar('renderEvent', event,true);
												}
											});
											$( this ).dialog( "close" );

										}
									}
								});
								$( "#reservebox" ).dialog( "open" );
								return false;
							}
						},
						eventDragStart: function( event, jsEvent, ui, view ) {
							ui.helper.draggable("option", "revert", true);
						},
						eventDragStop: function( event, jsEvent, ui, view ) {
						},
						eventDrop: function( event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view ) {
							var schdata = {beginTime:event.start, endTime:event.end, description:event.description, id:event.id ,title:event.title};
							$.ajax({
								type: "POST", //使用post方法访问后台
								url: "updatedata!UpdateSchedule.action", //要访问的后台地址
								data: schdata, //要发送的数据
								success: function (data) {
									//对话框里面的数据提交完成，data为操作结果
									revertFunc();
									//$('#calendar').fullCalendar('updateEvent', event);
								}
							});

						},
						eventResizeStart:  function( event, jsEvent, ui, view ) {

							//alert('resizing');

						},
						eventResize: function(event,dayDelta,minuteDelta,revertFunc) {

							if(1==1||2==event.uid){
								var schdata = {startdate:event.start, enddate:event.end, confid:event.confid, sid:event.sid};

							}else{
								revertFunc();
							}

						},

						events :
							function(start,end,callback){
								$.ajax({//通过ajax动态查询要展示的课次数据信息
									url: contextPath+'/schedule/list.do',
									type : 'get',
									success: function(result) { 
										var events = [];
										//if(result!=null&& result.lenth>0){
											for(var i=0;i<result.length;i++){
												events.push({
													id:result[i].id,
													title: result[i].title,
													start: result[i].beginTime,//'2019-09-20 12:12',//start表示这个event事件放在哪个日期框中
													end:result[i].endTime,
													description:result[i].description,
													sId:result[i].sId,
													allDay: true
												});
											}
										//}
										callback(events);
									}
								});
							}
					});

			if($.browser.msie){
				$("#calendar .fc-header-right table td:eq(0)").before('<td><div class="ui-state-default ui-corner-left ui-corner-right" style="border-right:0px;padding:1px 3px 2px;" ><input type="text" id="selecteddate" size="10" style="padding:0px;"></div></td><td><div class="ui-state-default ui-corner-left ui-corner-right"><a><span id="selectdate" class="ui-icon ui-icon-search">goto</span></a></div></td><td><span class="fc-header-space"></span></td>');
			}else{
				$("#calendar .fc-header-right table td:eq(0)").before('<td><div class="ui-state-default ui-corner-left ui-corner-right" style="border-right:0px;padding:3px 2px 4px;" ><input type="text" id="selecteddate" size="10" style="padding:0px;"></div></td><td><div class="ui-state-default ui-corner-left ui-corner-right"><a><span id="selectdate" class="ui-icon ui-icon-search">goto</span></a></div></td><td><span class="fc-header-space"></span></td>');
			}
			$("#selecteddate").datepicker({

				dateFormat:'yy-mm-dd',
				monthNames : [ "一月", "二月", "三月",
					"四月", "五月", "六月", "七月",
					"八月", "九月", "十月", "十一月",
					"十二月" ],
				monthNamesShort : [ "一月", "二月",
					"三月", "四月", "五月", "六月",
					"七月", "八月", "九月", "十月",
					"十一月", "十二月" ],
				dayNames : [ "周日", "周一", "周二",
					"周三", "周四", "周五", "周六" ],

				dayNamesMin: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"],
				beforeShow: function (input, instant) {
					setTimeout(
							function () {
								$('#ui-datepicker-div').css("z-index", 15);
							}, 100
					);
				}
			});

			$("#selectdate").click(function() {
				var selectdstr = 	$("#selecteddate").val();
				var selectdate = $.fullCalendar.parseDate(selectdstr, "yyyy-mm-dd");
				$('#calendar').fullCalendar( 'gotoDate', selectdate.getFullYear(), selectdate.getMonth(), selectdate.getDate());
			});


		});
		function validate2time(){

			var cresult = compare2time($("#start").val(), $("#end").val());
			if(cresult==0){
				return false;
			}else if(cresult==1){
				$.validationEngine.closePrompt("#start");
				return true;
			}

		}

	</script>


	<DIV id=calendar></DIV>
	<DIV id=reserveinfo title=Details>
		<DIV id=revtitle></DIV>
		<DIV id=revdesc></DIV></DIV>
	<DIV style="DISPLAY: none" id=reservebox title="日程计划">
		<FORM id=reserveformID method=post>
			<DIV class=sysdesc>&nbsp;</DIV>
			<INPUT id=sId name=sId  type="hidden"/ >
			<DIV class=rowElem><LABEL>计划编号:</LABEL> <INPUT id=id name=id readonly="readonly"> </DIV>
			<DIV class=rowElem><LABEL>计划题目:</LABEL> <INPUT id=title name=title> </DIV>
			<DIV class=rowElem><LABEL>开始时间:</LABEL> <INPUT id=start
														   class=validate[required,funcCall[validate2time]] name=start> </DIV>
			<DIV class=rowElem><LABEL>结束时间:</LABEL> <INPUT id=end
														   class=validate[required,funcCall[validate2time]] name=end> </DIV>
			<DIV class=rowElem><LABEL>内&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;容:</LABEL> <TEXTAREA id=details rows=4 cols=43 name=details></TEXTAREA> </DIV>
			<DIV class=rowElem> </DIV>
			<DIV class=rowElem> </DIV>
			<DIV id=addhelper class=ui-widget>
				<DIV
						style="PADDING-BOTTOM: 5px; PADDING-LEFT: 5px; PADDING-RIGHT: 5px; PADDING-TOP: 5px"
						class="ui-state-error ui-corner-all">
					<DIV id=addresult></DIV></DIV></DIV></FORM></DIV></DIV>
<DIV id=footer>Copyright 2011 by <A
		href="http://www.gbin1.com/">http://www.gbin1.com</A>
</DIV>
<script defer src="http://julying.com/lab/weather/v3/jquery.weather.build.min.js?parentbox=body&moveArea=all&zIndex=1&move=1&drag=1&autoDrop=0&styleSize=big&style=default&area=client&city=%E5%B9%BF%E5%B7%9E"></script>
</body>
</html>