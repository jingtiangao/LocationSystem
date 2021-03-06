<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:include page="/common/easyui.jsp"></jsp:include>

<html>
<head>
<meta name="author" content="Szy++ Team" />
<meta name="copyright" content="Szy++" />
<link href="<%= request.getContextPath() %>/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<style>
	.insects {
		width: 80px;
		height: 24px;
		padding-left: 5px;
	}
	.drugs {
		width: 180px;
		height: 24px;
		padding-left: 5px;
	}
</style>

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.tools.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/editor/kindeditor.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {
	var $inputForm = $("#inputForm");
	// 表单验证
	$inputForm.validate({
		rules: {
/* 			pass: {
				pattern: /^[^\s&\"<>]+$/,
				minlength: 4,
				maxlength: 20
			},
			rePass: {
				equalTo: "#pass"
			},
			hasaudit:{required:true},
			manager:{required:true},
			graindepotid:{required:true}, */
		},
 		submitHandler: function() {
 			var formData = new FormData($( "#inputForm" )[0]); 
 			$("table input[type=checkbox]").each(function(){
 				if ($(this).attr("checked"))
 					$(this).val(1);
 				else
 					$(this).val(0);
 			});
 			var data=$("#inputForm").serialize();
 			data = data.replace(/\+/g," ");   // g表示对整个字符串中符合条件的都进行替换
			$.ajax({
				url : 'editBinCa',//$("#inputForm").attr("action"),
				data : data, //$("#inputForm").serialize(),
				dataType : 'json',
/*  				contentType: false,  
		        processData: false,   */
				success : function(r) {
					if (r && r.success) {
						parent.$.messager.alert('提示', r.msg); //easyui中的控件messager
						goback();
					} else {
						parent.$.messager.alert('数据更新或插入', r.msg, 'error'); //easyui中的控件messager
					}
				}
			});
		} 
	});
	
	var $insectsTable = $("#insectsTable");
	var $addInsects = $("#addInsects");
	var $deleteBin = $("a.deleteInsect");
	var indexInsect = '${indexInsect}';
	// 增加粮仓
	$addInsects.click(function() {
		var trHtml = 
			'<tr>' +
				'<td>' + indexInsect + '</td><td>' +
				'<input type="text" name="TBinInsectses[' + indexInsect + '].kinds" class="insects">' + '</td>' +  
			'<td >' + '<input type="text" name="TBinInsectses[' + indexInsect + '].density" class="insects">' + '</td>' +
			'<td >' + '<input type="text" name="TBinInsectses[' + indexInsect + '].damageloc" class="insects">' + '</td>' +
			'<td >' + '<input type="text" name="TBinInsectses[' + indexInsect + '].foundloc" class="insects">' + '</td>' +
			'<td >' + '<input type="text" name="TBinInsectses[' + indexInsect + '].startinsectsdate" class="insects" >' + '</td>' +
			'<td >' + '<input type="text" name="TBinInsectses[' + indexInsect + '].startkilldate" class="insects">' + '</td>' +
			'<td >' + '<input type="text" name="TBinInsectses[' + indexInsect + '].endkilldate" class="insects" >' + '</td>' +
			'<td >' + '<input type="text" name="TBinInsectses[' + indexInsect + '].noninsectsdate" class="insects">' + '</td>' +
			'<td >' + '<input type="text" name="TBinInsectses[' + indexInsect + '].killdifficultlevel" class="insects">' + '</td>' +
			'<td> ' +
				'<a href="javascript:;" class="deleteInsect" style="width:50px,align:left" >[ 删除 ]</a>' +
			'</td> ' +
		'</tr>';

		$insectsTable.append(trHtml);
		indexInsect ++;
	});
	
	// 删除粮仓
	$deleteBin.live("click", function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "删除该害虫记录吗？请确认！",
			onOk: function() {
				$this.closest("tr").remove();
			}
		});
	});
	
 	var $drugsTable = $("#drugsTable");
	var $addDrugs = $("#addDrugs");
	var $deleteDrug = $("a.deleteDrug");
	var indexDrug =  '${indexDrug}';
	// 增加药剂/
	$addDrugs.click(function() {
		var trHtml = 
			'<tr>' +
				'<td>' + indexDrug + '</td><td>' +
				'<input type="text" name="TBinUseDrugs[' + indexDrug + '].drugname" class="drugs">' + '</td>' +  
			'<td >' + '<input type="text" name="TBinUseDrugs[' + indexDrug + '].factory" class="drugs">' + '</td>' +
			'<td >' + '<input type="text" name="TBinUseDrugs[' + indexDrug + '].usemethod" class="drugs">' + '</td>' +
			'<td >' + '<input type="text" name="TBinUseDrugs[' + indexDrug + '].protectkind" class="drugs" >' + '</td>' +
			'<td >' + '<input type="text" name="TBinUseDrugs[' + indexDrug + '].value" class="drugs">' + '</td>' +
			'<td> ' +
				'<a href="javascript:;" class="deleteDrug" style="width:50px,align:left" >[ 删除 ]</a>' +
			'</td> ' +
		'</tr>';

			
		$drugsTable.append(trHtml);
		indexDrug ++;
	});
	
	// 删除药剂
	$deleteDrug.live("click", function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "删除该药剂记录吗？请确认！",
			onOk: function() {
				$this.closest("tr").remove();
			}
		});
	});
	
	
	$("table input[type=checkbox]").each(function(){
		//console.info($(this).val() + '  ' + $(this).attr("name"));
			if ($(this).val())
				$(this).attr("checked",true);
			else
				$(this).attr("checked",false);
		});
});
	//submit the form
 	doAdd = function(){
		$("#inputForm").submit();
	} 
	
	goback = function(){
		window.history.back();
	}

</script>	
</head>
<body >
	<div class="container" >
		<br>&nbsp;&nbsp;&nbsp;&raquo;氮气气调储粮害虫防治效果调查明细表
		<form id="inputForm"    method="post" enctype="multipart/form-data">
			<input type="hidden" name="lcbm" value="${lcbm }"/>
			<input type="hidden" name="id" value="${binCa.id}"/>
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="基本情况" />
				</li>
				<li>
					<input type="button" value="粮仓情况"/>
				</li>
				<li>
					<input type="button" value="储粮信息"/>
				</li>
				<li>
					<input type="button" value="成本核算" />
				</li> 
				<li>
					<input type="button" value="气调储粮" />
				</li> 
				<li>
					<input type="button" value="防治效果" />
				</li> 
				<li>
					<input type="button" value="品质变化" />
				</li> 
			</ul>		
			<table class="input tabContent">				
				<tr>
					<th> 粮库名称：</th> <td colspan="3"> ${lkmc}</td>
					<th> 粮库编号：</th><td>${lkbm}</td>
				</tr>
				<tr>
					<th> 年度</th><td>${binCa.annual}</td>
					<th> 填报日期：</th><td><input type="text" class="easyui-datebox" name="reportdate" value="${binCa.reportdate}"/></td>
				</tr>
					<tr><th>录入人：</th><td>${binCa.modifier}</td>
					<th>录入日期：</th><td>${binCa.modifytime}</td>
				</tr>
				<tr>
					<th> 填报人：</th><td><input type="text" value="${binCa.reporter}" name="reporter" class="text"/></td>
					<th> 联系电话：</th><td><input type="text" name="phone" class="text" value="${binCa.phone}"/></td>
				</tr>
				<tr>
					<th> 开始日期：</th><td><input type="text" name="startdate" class="easyui-datebox" value="${binCa.startdate}"/></td>
					<th> 结束日期：</th><td><input type="text" name="enddate" class="easyui-datebox" value="${binCa.enddate}"/></td>
				</tr>
			</table>
			<table class="input tabContent">
				<tr>
					<th> 仓型：</th><td>${typebin}</td>
					<th> 仓号：</th><td>${lcbm}</td>
				</tr>
				<tr>
					<th> 建设规模(吨)：</th><td>${capacity}</td>
					<th> 储粮规模(吨)：</th><td>${capacity}</td>
				</tr>
				<tr>
					<th> 仓长(米)：</th><td>${longth}</td>
					<th> 仓宽(米)</th><td>${width}</td>
				</tr>
				<tr>
					<th> 设计粮堆高度(米)：</th><td>${height}</td>
					<th> 仓体结构：</th><td>${structureofbody}</td>
				</tr>
				<tr>
					<th> 环流装置：</th><td>${circulatedevice}</td>
				</tr>
				<tr>
					<th> 环流风机：</th><td>${circulatefan}</td>
				</tr>
				<tr>
					<th> 仓房风道：</th><td>${fanway}</td>
				</tr>
			</table>
			<!-- 储粮信息 -->
			<table class="input tabContent">
				<tr>
					<th> 粮种名称：</th> <td>${grain.grainname}</td>
					<th> 装粮形式：</th> <td>${grain.clxs}</td>
				</tr>
				<tr>
					<th> 收获日期：</th><td>${grain.harvestdate}</td>
					<th> 入储日期：</th> <td>${grain.indate}</td>
				</tr>
				<tr>
					<th> 水分：</th><td>${grain.water}</td>
					<th> 杂质：</th> <td>${grain.impurity}</td>
				</tr>
				<tr>
					<th> 干燥方式：</th><td>${grain.dryingmethod}</td>
					<th> 存储年限（年）：</th> <td>${grain.reserveperiod}</td>
				</tr>
				<tr>
					<th> 入储数量（吨）：</th><td>${grain.innum}</td>
					<th> 装具：</th> <td>${grain.container}</td>
				</tr>
				<tr>
					<th> 空仓500pa（秒）：</th><td>${grain.empty_bin500pa}</td>
					<th> 空仓半衰500pa（秒）：</th> <td>${grain.halfemptybin500pa}</td>
				</tr>
				<tr>
					<th> 满仓300pa（秒）：</th><td>${grain.fullbin300pa}</td>
					<th> 满仓半衰300pa（秒）：</th> <td>${grain.halffullbin}</td>
				</tr>
				<tr>
					<th> 储藏技术：</th><td>${grain.storetechnology}</td>
					<th> 储藏方式：</th> <td>${grain.storemethod}</td>
				</tr>
				<tr>
					<th> 控温措施：</th><td>${grain.controltemperaturemeasures}</td>
					<th> 控湿措施：</th> <td>${grain.controlhumiditymeasures}</td>
				</tr>
				<tr>
					<th> 来源：</th><td>${grain.source}</td>
					<th> 实际粮堆高度（米）：</th> <td>${grain.grainheight}</td>
				</tr>
			</table>  
			
			<table class="input tabContent"> <!-- 成本核算 -->
				<tr>
					<th> 制氮设备（元）：</th><td><input type="text" name="nitrogendevice" class="text" value="${binCa.nitrogendevice}"/></td>
					<th> 气调智能控制系统（品牌）：</th><td><input type="text" name="controlsystem" class="text" value="${binCa.controlsystem}"/></td>
				</tr>
				<tr>
					<th>空气压缩机（元）：</th><td><input type="text" name="aircompressor" class="text"  value="${binCa.aircompressor}"/></td>
					<th>制氮机房（元）：</th><td><input type="text" name="nitrogenroom" class="text"  value="${binCa.nitrogenroom}"/></td>
				</tr>
				<tr>
					<th>空气呼吸器（元）：</th><td><input type="text" name="respirator" class="text"  value="${binCa.respirator}"/></td>
					<th>管道及施工费（元）：</th><td><input type="text" name="pipleandfee" class="text"  value="${binCa.pipleandfee}"/></td>
				</tr>
				<tr>
					<th>空气充气泵（元）：</th><td><input type="text" name="airpump" class="text"  value="${binCa.airpump}"/></td>
					<th>电缆及施工费（元）：</th><td><input type="text" name="cableandfee" class="text"  value="${binCa.cableandfee}"/></td>
				</tr>
				<tr>
					<th>低氧报警仪（元）：</th><td><input type="text" name="hypoxiaalarm" class="text"  value="${binCa.hypoxiaalarm}"/></td>
					<th>电缆、槽管、压条、薄膜及施工费（元）：</th><td><input type="text" name="auxiliaryandfee" class="text"  value="${binCa.auxiliaryandfee}"/></td>
				</tr>
				<tr>
					<th>氧气浓度检测仪（元）：</th><td><input type="text" name="oxygendetectdevice" class="text"  value="${binCa.oxygendetectdevice}"/></td>
					<th>电费（元）：</th><td><input type="text" name="electricityfee" class="text"  value="${binCa.electricityfee}"/></td>
				</tr>
			</table>

			
			<table class="input tabContent"> <!--气调储粮-->
				<tr>
					<th>充气时间（h）</th><td><input type="text" name="chargetime" class="text"  value="${binCa.chargetime}"/></td>
				</tr>
				<tr>
					<th>充气工艺:</th><td><input type="text" name="chargepro" class="text"  value="${binCa.chargepro}"/></td>
					<th>平均最高浓度(%)：</th><td><input type="text" name="maxconcentration" class="text"  value="${binCa.maxconcentration}"/></td>
				</tr>
				<tr>
					<th>目标浓度维持时间（h）</th><td><input type="text" name="keeplong" class="text"  value="${binCa.keeplong}"/></td>
					<th>充氮时平均粮温(°C)：</th><td><input type="text" name="avggraintemperature" class="text"  value="${binCa.avggraintemperature}"/></td>
				</tr>
				<tr>
					<th>充氮时最高粮温(°C)</th><td><input type="text" name="highgraintemperature" class="text"  value="${binCa.highgraintemperature}"/></td>
					<th>充氮时最低粮温(°C)：</th><td><input type="text" name="lowestgraintemperture" class="text"  value="${binCa.lowestgraintemperture}"/></td>
				</tr>
					     
			</table>
			
			<table class="input tabContent"><!-- 防治效果 -->
				<tr>
					<th>气调前虫口密度：</th><td><input type="text" name="densitybefca" class="text"  value="${binCa.densitybefca}"/></td>
					<th>氮气平均浓度范围：</th><td><input type="text" name="varconcentration" class="text"  value="${binCa.varconcentration}"/></td>
				</tr>
				<tr>
					<th>气调后虫口密度：</th><td><input type="text" name="densityafterca" class="text"  value="${binCa.densityafterca}"/></td>
					<th>无虫间隔（天）：</th><td><input type="text" name="noninsects" class="text"  value="${binCa.noninsects}"/></td>
				</tr>
			</table> 
			
			<table class="input tabContent"> <!-- 品质变化 -->
				<tr>
					<th>脂肪酸值(防治害虫前):</th><td><input type="text" name="fattyacidvaluebef" class="text"  value="${binCa.fattyacidvaluebef}"/></td>
					<th>脂肪酸值(气调防治害虫前):</th><td><input type="text" name="fattyacidvalueafter" class="text" value="${binCa.fattyacidvalueafter}" /></td>
				</tr>	
				<tr>
					<th>其他：</th><td><input type="text" name="elsecharacter" class="text"  value="${binCa.elsecharacter}"/></td>
				</tr>	     
			</table>
			
			<table class="input">
				<tr><th>&nbsp;</th>
				<td >
				<!--  <input type="submit" class="button" value="save" /> -->
				<a href="javascript:void(0)" class="easyui-linkbutton"
						plain="false" onclick="doAdd()" iconCls="icon-save">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton"
						plain="false" onclick="goback()" iconCls="icon-back">返回</a>
				</td>
				</tr>	
			</table>							
		</form>
	</div>
</body>
</html>