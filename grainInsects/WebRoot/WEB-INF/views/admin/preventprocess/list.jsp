<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<title>防治技术</title>
<jsp:include page="/common/easyui.jsp"></jsp:include>

<script type="text/javascript">

	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : 'dataGrid',
			pagination: true,
			fit : true,
			fitColumns : true,
			rownumbers : true,// 显示行号
			singleSelect : true,// 只能单选
			border : false,
			striped : true,// 隔行变色
			idField : 'sm', // 主键字段
			columns : [ [ {
				field : 'sm',
				title : 'ID',
				width : 40
			},
			 {
				field : 'proname',
				title : '工艺名称',
				width : 50,
				sortable : true,
				align : "center",
			},{
				field : 'keywords',
				title : '关键词',
				width : 60,
				sortable : true,
				align : "center"
			},{
				field : 'material',
				title : '材料',
				width : 60,
				sortable : true,
				align : "center"
			},{
				field : 'procway',
				title : '处理方式',
				width : 40,
				sortable : true,
				align : "center"
			},{
				field : 'area',
				title : '区域',
				width : 40,
				sortable : true,
				align : "center",
			},{
				field : 'seasion',
				title : '季节',
				width : 40,
				sortable : true,
				align : "center",
			},{
				field : 'actor',
				title : '操作',
				width : 40,
				formatter : function(value, row, index) {
					var str = '';
						str += $.formatString('<img onclick="editFun(\'{0}\');" src="{1}" title="修改"/> ',row.sm, '${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
					str += '&nbsp;';
						str += $.formatString('<img onclick="deleteFun(\'{0}\');" src="{1}" title="删除"/> ',row.sm, '${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/cancel.png');
					return str;
				}
			} ] ],
			toolbar : '#toolbar',
		});
		
	});

	function deleteFun(id) {
		if (id!=null){
			parent.$.messager.confirm('询问', '您是否要删除当前上报记录 ？', function(b) {
				if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					
					
					$.post('delete', {
						sm : id
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

	function editFun(index) {
		openBlank('editPreventprocessEntrance',{id:index});
	}

	function addFun() {
		openBlank('addPreventprocessEntrance',{ } );
	}
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="知识库  > 防治技术 " style="overflow: hidden;">
		<table id="dataGrid"></table>
	</div>
		<div id="toolbar" style="display: none;">
		<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'pencil_add'">添加</a>
		<a onclick="dataGrid.datagrid('reload');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'transmit'">刷新</a>
	</div>
</body>
</html>