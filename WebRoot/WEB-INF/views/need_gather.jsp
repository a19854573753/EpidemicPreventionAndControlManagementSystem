<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set var="uri" value="${pageContext.request.contextPath}" />

<script type="text/javascript">
var uri='${uri}';
</script>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>需求统计</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/layui/css/layui.css">
  
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/common/page/myPagination.css?t=4" />

<style type="text/css">
	.btnStyle{
		margin-left:8px;
		margin-top:8px
	}
	    .loadingModel {
            position: absolute;
            top: 0;
            left: 0;
            background-color: rgba(9, 9, 9, 0.63);
            width: 100%;
            height: 100%;
            z-index: 1000;
        }
 
 
        .loading-content {
            width: 50%;
            text-align: center;
            background: #ffffff;
            border-radius: 6px;
            line-height: 30px;
            z-index: 10001;
        }
</style>
</head>
<div id="loadingDiv"></div>
<div id="imgModal"></div>
<div class="layui-container" style="overflow:scroll">  
    <div class="layui-row">
        <div class="layui-col-lg12">
            <fieldset class="layui-elem-field">
            <legend>需求统计</legend>
            <div class="layui-field-box">
            <div id="needGather" style="width: 1100px;height:400px;margin-top:30px;"></div>

           </div>
 </fieldset>
        </div>
    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/common/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/common/page/myPagination.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui/layui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/common/echarts/echarts.min.js"></script>



<script type="text/javascript" src="${pageContext.request.contextPath}/static/common/utils/listutils.js?v=8159"></script>

<script type="text/javascript">

 $(function(){
 needGather();

	 
 });
 

 
 function needGather() {
	showLoading('${pageContext.request.contextPath}/static/common/loading.gif');	
	$.ajax({
		type : 'get',
		url : "${pageContext.request.contextPath}/commonapi/needGather/needGatherSubmit",
		data : {
	},
	success : function(result) {
		 hideLoading();
  var myChart = echarts.init(document.getElementById('needGather'));
var option = {
    title : {
        text: '需求统计',
        subtext: '需求统计'
    },
    tooltip : {
        trigger: 'axis'
    },
    legend: {
        data:['总需求统计',
'已完成需求']
    },
    toolbox: {
        show : false,
        feature : {
            mark : {show: true},
            dataView : {show: true, readOnly: false},
            magicType : {show: true, type: ['line', 'bar']},
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    calculable : true,
    xAxis : [
        {
            type : 'category'
        }
    ],
    yAxis : [
        {
            type : 'value'
        }
    ],
    series : [
          {
            name:'总需求统计',
            type:'bar',
            markPoint : {
                data : [
                    {type : 'max', name: '最大值'},
                    {type : 'min', name: '最小值'}
                ]
  }
  }
,
  {
            name:'已完成需求',
            type:'bar',
            markPoint : {
                data : [
                    {type : 'max', name: '最大值'},
                    {type : 'min', name: '最小值'}
                ]
  }
  }

    ]
};
 var rsList1X=[];
 var rsList1Y=[];
 for(var i=0;i<result.hospitalIdXList.length;i++){
   rsList1X.push(result.hospitalIdXList[i].name);
 }
rsList1X.sort();
 for(var i=0;i<rsList1X.length;i++){
 	var isFound=0;
 	for(var j=0;j<result.rsList1.length;j++){
			if(result.rsList1[j].col2Str==rsList1X[i]){
   			rsList1Y.push(result.rsList1[j].col1);
   			isFound=1;
			}
	 	}
 	if(isFound==0){
 		rsList1Y.push(0);
 	}
 }
   option.xAxis[0].data=rsList1X;
   option.series[0].data=rsList1Y;
 var rsList2X=[];
 var rsList2Y=[];
 for(var i=0;i<result.hospitalIdXList.length;i++){
   rsList2X.push(result.hospitalIdXList[i].name);
 }
rsList2X.sort();
 for(var i=0;i<rsList2X.length;i++){
 	var isFound=0;
 	for(var j=0;j<result.rsList2.length;j++){
			if(result.rsList2[j].col1Str==rsList2X[i]){
   			rsList2Y.push(result.rsList2[j].col2);
   			isFound=1;
			}
	 	}
 	if(isFound==0){
 		rsList2Y.push(0);
 	}
 }
   option.xAxis[0].data=rsList2X;
   option.series[1].data=rsList2Y;
myChart.setOption(option);
			}
		});
 }


function gotoPage(e){
	var url = $(e).attr("data-url");
	window.location.href=url;
}



</script>
</body>
</html>