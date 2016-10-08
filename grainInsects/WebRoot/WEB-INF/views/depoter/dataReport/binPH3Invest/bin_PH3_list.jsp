<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<title>磷化氢熏蒸储粮害虫防治效果调查明细表 </title>
<jsp:include page="/common/easyui.jsp"></jsp:include>

<script type="text/javascript">

	var dataGrid;
	$(document).ready(function() {
		getYear();
		getGrainBin();
		
		$("#year").change(getDataGrid);
		$("#grain-bin").change(getDataGrid);
	});
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : 'getGrainBin',
			pagination: true,
			fit : true,
			fitColumns : true,
			rownumbers : true,// 显示行号
			singleSelect : true,// 只能单选
			border : false,
			striped : true,// 隔行变色
			idField : 'id', // 主键字段
			columns : [ [ {
				field : 'id',
				title : 'ID',
				width : 40
			},{
				field : 'startdate',
				title : '开始时间',
				width : 50,
				sortable : true,
				align : "center",
			},{
				field : 'enddate',
				title : '结束时间',
				width : 50,
				sortable : true,
				align : "center",
			}, {
				field : 'reporter',
				title : '填表人',
				width : 40,
				sortable : true,
				align : "center",
			},{
				field : 'reportdate',
				title : '填表日期',
				width : 40,
				sortable : true,
				align : "center",
			},{
				field : 'graindepot',
				title : '所属库',
				width : 60,
				sortable : true,
				align : "center",
				formatter : function(value, row, index) {if (value!=null) return value.lkmc;	},
			},{
				field : 'actor',
				title : '操作',
				width : 40,
				formatter : function(value, row, index) {
					var str = '';
						str += $.formatString('<img onclick="editFun(\'{0}\');" src="{1}" title="修改"/> ',row.id, '${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
					str += '&nbsp;';
						str += $.formatString('<img onclick="deleteFun(\'{0}\');" src="{1}" title="删除"/> ',row.id, '${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/cancel.png');
					return str;
				}
			} ] ],
			toolbar : '#toolbar',
		});
		
	});
	function getDataGrid() {
		
		var year = $("#year");
		var bin = $("#grain-bin");

		if (year.val() != '0' && bin.val() != '0') {
			getDataFun(year.val(),bin.val());
		}
	}
	function getDataFun(year,bin) {
		dataGrid.datagrid({
			queryParams:{
				'Annual' : year,
				'lcbm' : bin
			}
		});
	}
	function deleteFun(id) {
		if (id!=null){
			parent.$.messager.confirm('询问', '您是否要删除当前上报记录 ？', function(b) {
				if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('deleteBinReportRec', {
						id : id
					}, function(result) {
						if (result.success) {
							parent.$.messager.alert('提示', result.msg, 'info');
							dataGrid.datagrid('reload');
						}else
							parent.$.messager.alert('提示', result.msg, 'error');
						parent.$.messager.progress('close');
					}, 'JSON');
				}
			});
		}
	}
	function getYear() {
		$("#year").html("");
		var y = new Date().getFullYear();
		for (var i = 2000; i <= y; i++) {
			var x = "<option value='"+i+"'"+(i != y ? '' : 'selected=\'selected\'')+">"+i+"年"+"</option>";
			$("#year").append(x);
		}
		
/* 		$.ajax({
			url:'year',
			method:'get',
			success:function(data) {
				var json = eval("("+data+")");
				$("#year").html("");
				$("#year").append("<option selected='selected' value='0'>请选择年份...</option>");
				for (var c in json) {
					var x = "<option value='"+json[c].Annual+"'>"+json[c].Annual+"年"+"</option>";
					$("#year").append(x);
				}
			}
		}); */
	}
	
	function getGrainBin() {
		$.ajax({
			url:'grainBins',
			method:'get',
			success:function(data) {
				var json = eval("("+data+")");
				$("#grain-bin").html("");
				$("#grain-bin").append("<option selected='selected' value='0'>请选择粮仓...</option>");
				for (var c in json) {
					var x = "<option value='"+json[c].lcbm+"'>"+json[c].lcbm+"号粮仓"+"</option>";
					$("#grain-bin").append(x);
				}
			}
		});
	}
	function editFun(index) {
		openBlank('editBinPhosphinefumigationEntrance',{id:index});
	}

	function addFun() {
		if($("#grain-bin").val() == "0") {
			parent.$.messager.alert('提示', '请选择粮仓', 'info');	
			return;
		}
		openBlank('addBinPhosphinefumigationEntrance',{lcbm:$("#grain-bin").val(),annual:$("#year").val()} );
	}
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="数据上报 > 磷化氢熏蒸分仓表" style="overflow: hidden;">
		<table id="dataGrid"></table>
	</div>
		<div id="toolbar" style="display: none;">
		<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'pencil_add'">添加</a>
		<a onclick="dataGrid.datagrid('reload');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'transmit'">刷新</a>
		<span>磷化氢熏蒸储粮害虫防治效果调查明细表</span>
		<select id="year" style="margin-left:30px;">
			<option selected="selected" value='0'>请选择年份...</option>
			<option value='1'>...</option>
		</select>
		
		<select id="grain-bin">
			<option selected="selected" value='0'>请选择粮库...</option>
			<option value='1'>...</option>
		</select>
	</div>
</body>
</html>