<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<jsp:include page="/common/easyui.jsp"></jsp:include>
<head>
	<!-- <#assign content="welcome"> -->
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>main developed by Logan Von</title>
	<meta name="author" content="Logan Von" />
	<meta name="copyright" content="Logan Von" />
	<style>
		.datagrid-editable-input { height : 20px; font-size: 16px; }  // 注意覆盖的顺序
	</style>
	
	<script type="text/javascript">
		var recordlist_field;
		$(function(){
			$("input[name='show-type']").click(function() {
				if ($(this).val() == '未反馈') {
					recordlist_field=$('#recordlist_field').datagrid({
					url: 'unrepliedDatagrid',
					pagination : true,
					fitColumns : true,
					fit : true,
					rownumbers : true,// 显示行号
					singleSelect : true,// 只能单选
					border : false,
					striped : true,// 隔行变色
					idField : 'id', // 主键字段	
					columns:[[
					          {
					        	  field: 'hasshare',
					        	  title: '是否公开',
					        	  sortable : true,
					        	  align : 'center',
					        	  width: 30,
					        	  formatter : function(value, row, index) {
					        		  return value ? '是' : '否';
					        	  }
					          },{
					        	  field : 'title',
					        	  title : '主题',
					        	  sortable : true,
					        	  align: 'center',
					        	  width : 30
					          }, {
					        	  field : 'type',
					        	  title : '类型',
					        	  sortable : true,
					        	  align: 'center',
					        	  width : 20,
					        	  formatter: function(value, row, index) {
					        		  var str = ['害虫识别','害虫防治','其他'];
					        		  return str[row.type];
					        	  }
					          }, {
					        	  field : 'describle',
					        	  title : '描述',
					        	  align: 'center',
					        	  sortable : true,
					        	  width : 60
					          }, {
									field : 'actor',
									title : '操作',
									formatter : function(value, row, index) {
										var str = '';
										str += $.formatString(
														'<img onclick="editRecord(\'{0}\');" src="{1}" title="采集记录列表"/>',
														row.id,
														'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
										return str;
									}
								}
					      ]],
					 	toolbar : '#record_fieldtoolbar',
					});
				} else {
					recordlist_field=$('#recordlist_field').datagrid({
					url: 'repliedDatagrid',
					pagination : true,
					fitColumns : true,
					fit : true,
					rownumbers : true,// 显示行号
					singleSelect : true,// 只能单选
					border : false,
					striped : true,// 隔行变色
					idField : 'id', // 主键字段	
					columns:[[
					          {
					        	  field: 'hasshare',
					        	  title: '是否公开',
					        	  sortable : true,
					        	  align : 'center',
					        	  width: 30,
					        	  formatter : function(value, row, index) {
					        		  return value ? '是' : '否';
					        	  }
					          },{
					        	  field : 'title',
					        	  title : '主题',
					        	  sortable : true,
					        	  align: 'center',
					        	  width : 30
					          }, {
					        	  field : 'type',
					        	  title : '类型',
					        	  sortable : true,
					        	  align: 'center',
					        	  width : 20,
					        	  formatter: function(value, row, index) {
					        		  var str = ['害虫识别','害虫防治','其他'];
					        		  return str[row.type];
					        	  }
					          }, {
					        	  field : 'describle',
					        	  title : '描述',
					        	  align: 'center',
					        	  sortable : true,
					        	  width : 60
					          }, {
					        	  field : 'expertadvice',
					        	  title : '专家意见',
					        	  align : 'center',
					        	  width : 70
					          }, {
					        	  field : 'experttime',
					        	  title : '专家意见时间',
					        	  align : 'center',
					        	  width : 30,
					        	  formatter : function(value, row, index) {
										var d = new Date(value);
										var str = d.getFullYear() + "-" + (parseInt(d.getMonth())+1).toString() + "-" + d.getDate();
										return str;
									}
					          }, {
									field : 'actor',
									title : '操作',
									formatter : function(value, row, index) {
										var str = '';
										str += $.formatString(
														'<img onclick="editRecord(\'{0}\');" src="{1}" title="采集记录列表"/>',
														row.id,
														'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
										return str;
									}
								}
					      ]],
					 	toolbar : '#record_fieldtoolbar',
					});
				}
			});
			
			recordlist_field=$('#recordlist_field').datagrid({
				url: 'unrepliedDatagrid',
				pagination : true,
				fitColumns : true,
				fit : true,
				rownumbers : true,// 显示行号
				singleSelect : true,// 只能单选
				border : false,
				striped : true,// 隔行变色
				idField : 'id', // 主键字段	
				columns:[[
				          {
				        	  field: 'hasshare',
				        	  title: '是否公开',
				        	  sortable : true,
				        	  align : 'center',
				        	  width: 30,
				        	  formatter : function(value, row, index) {
				        		  return value ? '是' : '否';
				        	  }
				          },{
				        	  field : 'title',
				        	  title : '主题',
				        	  sortable : true,
				        	  align: 'center',
				        	  width : 50
				          }, {
				        	  field : 'type',
				        	  title : '类型',
				        	  sortable : true,
				        	  align: 'center',
				        	  width : 100,
				        	  formatter: function(value, row, index) {
				        		  var str = ['害虫识别','害虫防治','其他'];
				        		  return str[row.type];
				        	  }
				          }, {
				        	  field : 'describle',
				        	  title : '描述',
				        	  align: 'center',
				        	  sortable : true,
				        	  width : 60
				          }, {
								field : 'actor',
								title : '操作',
								formatter : function(value, row, index) {
									var str = '';
									str += $.formatString(
													'<img onclick="editRecord(\'{0}\');" src="{1}" title="采集记录列表"/>',
													row.id,
													'${pageContext.request.contextPath}/resources/easyUI/themes/extjs_icons/pencil.png');
									return str;
								}
							}
				      ]],
				 	toolbar : '#record_fieldtoolbar',
				});
			
			recordlist_field.datagrid('getPager').pagination({    
			    showPageList:true,    
			    onBeforeRefresh:function(){    
			        return true;    
			    }    
			});
		});
		
		// 过滤查询指定信息
		function doSearch(){
			$('#recordlist_field').datagrid('load', {
				// 参数名与后台pojo属性名一致即可自动填充
				'id': $('#id').val(),
				//'expertuser': $('#expertuser').val(),
				'title': $('#title').val()
			});
		}
		function clearSearch(){
			$('#recordlist_field').datagrid('load',{});
			$('#id').attr('value','');
			//$('#expertuser').attr('value','');
			$('#title').attr('value','');
		}
		
		function editRecord(id){
			openBlank('replyConsultEntrance', {id:id});  // 这里的recordId必须和Controller的变量名一致，否则报错
		}
		
		function deleteRecord(id){
			if(id != undefined){
				recordlist_field.datagrid('selectRow', id);
			}
			var rows = recordlist_field.datagrid('getSelections');
			if(rows.length>0){
				parent.$.messager.confirm('询问', '您是否要删除当前咨询记录？', function(b){
					if(b){
						parent.$.messager.progress({
							title: '提示',
							text: '数据处理中，请稍候...'
						});
						$.post('deleteConsultation', {
							id: rows[0].id
						},function(result){
							if(result.success){
								parent.$.messager.alert('提示',result.msg, 'info');
								recordlist_field.datagrid('reload');
							}else {
								parent.$.messager.alert('提示', result.msg, 'error');
							}
							parent.$.messager.progress('close');
						}, 'JSON');
					}
				});
			}
		}
	</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
   	<div data-options="region:'center',split:true" title="咨询列表" style="overflow: hidden; height: 280px; ">
		<table id="recordlist_field"></table>
	</div>
	<div id="record_fieldtoolbar">  
   		<table>
			<tr>
				<td>咨询编码:</td>
				<td><input id="id" class="text" style="margin-right:2px; border: 1px solid #ccc"/></td>
<!-- 				<td>专家:</td>
				<td><input id="expertuser" class="text" style="margin-right:2px; border: 1px solid #ccc"/></td> -->
				<td>主题:</td>
				<td><input id="title" class="text" style="border: 1px solid #ccc"/></td>
				<td><a href="javascript:void(0);" class="easyui-linkbutton" plain="false" onclick="doSearch()" iconCls="icon-search">查询</a></td>
				<td><a href="javascript:void(0);" class="easyui-linkbutton" plain="false" onclick="clearSearch()" iconCls="icon-redo">清空</a></td>
				
				<td><input type="radio" name="show-type" value="未反馈" checked="checked"/></td><td>未反馈</td>
				<td>&nbsp;&nbsp;</td>
				<td><input type="radio" name="show-type" value="已反馈"/></td><td>已反馈</td>
			</tr>
		</table>
   	</div>
</body>
</html>