<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<jsp:include page="/common/easyui.jsp"></jsp:include>

<html>
<head>
<meta name="author" content="Szy++ Team" />
<meta name="copyright" content="Szy++" />
<link href="<%= request.getContextPath() %>/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%= request.getContextPath() %>/resources/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
<style>	
	.text.index{
		width: 6em;
	}
	
	#pop-editor {
		border: 2px solid #000;
		border-right: 4px solid #000;
		border-radius: 5px;
		display:none;
		width: 80%;
		position: absolute;
		left: 10%;
		top: 2em;
		background-color: #FFF;
		transition: opacity 1.5s;
	}
	
	#add-photo {
		display:none;
		width: 80%;
		position: absolute;
		left: 10%;
		top: 2em;
		transition: opacity 1.5s;
		background-color: #FFF;
		border: 2px solid #000;
		border-radius: 5px;
	}
</style>

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.tools.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/editor/kindeditor.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/common.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/admin/js/input.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/select2/js/select2.min.js"></script>
<script type="text/javascript">
(function($) {
    $.fn.exist = function(){ 
        if($(this).length>=1){
            return true;
        }
        return false;
    };
})(jQuery);
$().ready(function() {
	//initialize select2
	initSelect2();
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
 			var jsjgRows = $(".jsjgr");
 			var jsjg = new Array();
 			jsjgRows.each(function() {
 				if($(this).val() == null){
 					jsjg.push(-1);
 				}else
 					jsjg.push($(this).val());
 			});
 			$("#jg").attr('value',jsjg);
 			
 			var formData = new FormData($( "#inputForm" )[0]); 
 			//var data=$("#inputForm").serialize();
 			//data = data.replace(/\+/g," ");   // g表示对整个字符串中符合条件的都进行替换
			$.ajax({
				url : 'editInsectsIndex',//$("#inputForm").attr("action"),
				data : formData, //$("#inputForm").serialize(),
				dataType : 'json',
  				contentType: false,  
		        processData: false,
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
	
	var $specificationTable = $("#specification-table");
	var $addSpecification = $("#add-specification");
	var $deleteSpecification = $("a.deleteIndex");
	var $addPicBtn = $("a.add-btn");
// 	var indexSpecification = 0;
	var indexSpecification = '${indexSpecification}';
	// 增加insectsindex
	$addSpecification.click(function() {
		var trHtml = 
			'<tr>' + 
 				//'<td><input type="hidden" value="'+indexSpecification+'"/>'+
 				//'<a href="javascript:;" class="button add-btn">添加图片</a></td>'+
 				//'<td><input type="text" name="TInsectsSpecifications[' + indexSpecification + '].jsjg" class="text index"/>' + '</td>' +  
 				'<td><select class="select2 text index jsjgr" style="width:20em;"></select>' + '</td>' + 
				'<td><input type="text" name="TInsectsSpecifications[' + indexSpecification + '].xh" class="text index">' + '</td>' +
				'<td><input type="text" class="text popeditor"/><input type="hidden" name="TInsectsSpecifications[' + indexSpecification + '].tz" class="index"/></td>' +
				'<td><input type="text" name="TInsectsSpecifications[' + indexSpecification + '].zqxh" class="text index"/>' + '</td>' +
				'<td><input type="text" name="TInsectsSpecifications[' + indexSpecification + '].source" class="text index" />' + '</td>' +
				'<td><input type="text" name="TInsectsSpecifications[' + indexSpecification + '].modifer" class="text index"/>' + '</td>' +
				'<td><input type="text" name="TInsectsSpecifications[' + indexSpecification + '].modifydate" class="text index" />' + '</td>' +
				'<td> ' +
					'<a href="javascript:;" class="deleteIndex" style="width:50px;align:left;" >[ 删除 ]</a>' +
				'</td> ' +
			'</tr>';
		$specificationTable.append(trHtml);
		indexSpecification ++;
		initSelect2();
	});
	
	var $contentDOM;
	
	$specificationTable.on('focus','.popeditor', function() {
		$("#pop-editor").show();
		$contentDOM = $(this);
		if ($contentDOM.val() === "") editor.html('');
		else editor.html($contentDOM.next().val());
		//TODO: clear the editor content;
		
	});
	
	$("#save-content").click(function(){
		//TODO: save content
		$contentDOM.val(editor.text());
		$contentDOM.next().val(editor.html());
		$("#pop-editor").hide();
	});
	
	$("#cancel-edit").click(function() {
		$("#pop-editor").hide();
	});
	
	// 删除index
	$deleteSpecification.live("click", function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "删除该害虫检索特征吗？请确认！",
			onOk: function() {
				$this.closest("tr").remove();
			}
		});
	});
	
	function initSelect2() {		
		$('.select2').select2({
			ajax: {
			    url: "getCatalogIndexName",
			    type: 'POST',
			    dataType: 'json',
			    delay: 250,
			    data: function (params) {
			    	if (params.term == null) params.term = '';
			    	if (params.page == null) params.page = 1;
			      return {
			        q: params.term, // search term
			        page: params.page
			      };
			    },
			    processResults: function (data, params) {
			      // parse the results into the format expected by Select2
			      // since we are using custom formatting functions we do not need to
			      // alter the remote JSON data, except to indicate that infinite
			      // scrolling can be used
			      params.page = params.page || 1;

			      return {
			        results: data.rows,
			        pagination: {
			          more: (params.page * 15) < data.total_count
			        }
			      };
			    },
			    cache: true
			  },
			  placeholder: {
				id: '-1', // the value of the option
				text: '请输入检索结果'
			  },
			  escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
			  //minimumInputLength: 1
		});
	}
	//////////////////////////////////////////////////////////////////
	
	//open add pic panel
	$addPicBtn.live('click',function() {
		rowid = $(this).prev().val();
		var $table = $("#"+rowid);
		if ($table.exist())  {
			//move the hidden div table data to add panel
			$("#insects-index-pics").children("tbody").empty().append($table.children("tbody").children());
		}
		indexPic = $("#insects-index-pics tbody tr").size();
		$("#add-photo").show();
	}); 
	
	
	//add insects index pics
 	var $picTable = $("#insects-index-pics");
	var $addPics = $("#add-pics");
	var $deletePic = $("a.deletePic");
	var $hiddenDiv = $("#hidden-content");
	var indexPic = 0;
	// 增加pics
	$picTable.on('click','#add-pics',function() {
		var trHtml = 
			'<tr>' +
 				'<td>' + '<input type="text" name="TInsectsSpecifications['+rowid+'].TInsectsSpecPic[' + indexPic + '].js" class="text index"/>' + '</td>' +  
				'<td >' + '<input type="file" name="TInsectsSpecifications['+rowid+'].TInsectsSpecPic[' + indexPic + '].tp" class="index">' + '</td>' +
				'<td >' + '<input type="text" name="TInsectsSpecifications['+rowid+'].TInsectsSpecPic[' + indexPic + '].source" class="text index" />' + '</td>' +
				'<td >' + '<input type="text" name="TInsectsSpecifications['+rowid+'].TInsectsSpecPic[' + indexPic + '].modifer" class="text index"/>' + '</td>' +
				'<td >' + '<input type="text" name="TInsectsSpecifications['+rowid+'].TInsectsSpecPic[' + indexPic + '].modifydate" class="text index" />' + '</td>' +
				'<td> ' +
					'<a href="javascript:;" class="deletePic" style="width:50px,align:left" >[ 删除 ]</a>' +
				'</td> ' +
			'</tr>';
		$picTable.children("tbody").append(trHtml);
		indexPic ++;
	});
	
	// 删除index
	$deletePic.live("click", function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "删除该图片吗？请确认！",
			onOk: function() {
				$this.closest("tr").remove();
			}
		});
	});
	
 	$("#cancel-pics").live('click',function() {
		$("#add-photo").hide();
		$picTable.html("");
		var tablecontent = '<tr><td colspan="2"><a href="javascript:;" id="add-pics" class="button">增加特征图片</a></td>'+
		'<td colspan="3">&nbsp;</td><td colspan="2"><a href="javascript:;" id="OK-pics" class="button">OK</a>'+
		'<a href="javascript:;" id="cancel-pics" class="button">返回</a></td>	</tr>'+
		'<tr class="title"><th>简介</th><th>图片</th><th>资料来源</th><th>录入人</th><th>录入日期</th><th>操作</th></tr>';
		$picTable.html(tablecontent);
	}); 
	
	$("#OK-pics").click(function () {
		var $table = $("#"+rowid);
		if ($table.length === 0)  {
			//new item reset the index
			var tbstr = '<table id="'+rowid+'"><thead></thead><tbody></tbody></table>';
			$hiddenDiv.append(tbstr);
			$table = $("#"+rowid);
		}
		//exist item get the max index
		$table.children("tbody").empty().append($picTable.children("tbody").children());
		$("#add-photo").hide();
	});
	
	var options = {
			height: "350px",
			items: [
				"source", "|", "undo", "redo", "|", "preview", "print", "template", "cut", "copy", "paste",
				"plainpaste", "wordpaste", "|", "justifyleft", "justifycenter", "justifyright",
				"justifyfull", "insertorderedlist", "insertunorderedlist", "indent", "outdent", "subscript",
				"superscript", "clearhtml", "quickformat", "selectall", "|", "fullscreen", "/",
				"formatblock", "fontname", "fontsize", "|", "forecolor", "hilitecolor", "bold",
				"italic", "underline", "strikethrough", "lineheight", "removeformat", "|", "image",
				"flash", "media", "insertfile", "table", "hr", "emoticons", "baidumap", "pagebreak",
				"anchor", "link", "unlink"
			],
			langType: grainInsects.locale,
			syncType: "form",
			filterMode: false,
			pagebreakHtml: '<hr class="pageBreak" \/>',
			allowFileManager: true,
			filePostName: "file",
			fileManagerJson: grainInsects.base + "/admin/file/browser",
			uploadJson: grainInsects.base + "/admin/file/upload",
			uploadImageExtension: setting.uploadImageExtension,
			uploadFlashExtension: setting.uploadFlashExtension,
			uploadMediaExtension: setting.uploadMediaExtension,
			uploadFileExtension: setting.uploadFileExtension,
			extraFileUploadParams: {
				token: getCookie("token")
			},
			afterChange: function() {
				this.sync();
			}
		};
		
		var editorList = new Array();
		if(typeof(KindEditor) != "undefined") {
		KindEditor.ready(function(K) {
			editorList[0]=K.create("#editor",options);
			editorList[1]=K.create("#auditadviceeditor",options);
		});
	};
	
 	var passaudit = "${insectsIndex.passaudit}";
	if(passaudit == "" ||passaudit == undefined)
		$("#passaudit").attr("value",false);
	else
		$("#passaudit").attr("value",passaudit);
	
	$("td input,td a,textarea,select").not("#inputForm *").attr("disabled","disabled");
		
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
		<br>&nbsp;&nbsp;&nbsp;&raquo;审核检索表
		

			<ul id="tab" class="tab">
				<li>
					<input type="button" value="基本情况" />
				</li>
				<li>
					<input type="button" value="特征" />
				</li>
				<li>
					<input type="button" value="专家审核意见" id ="expertAudit"/>
				</li>				
			</ul>			
			<table class="input tabContent">
				<tr><th><span class="requiredField">*</span> 检索表名称：</th><td colspan="3"><input type="text" name="jsbmc" class="text" value="${insectsIndex.jsbmc}" ></td></tr>
				<tr><th> 录入人：</th><td><input type="text" name="modifer" class="text" value="${insectsIndex.modifer}" /></td></tr>
				<tr><th> 录入日期：</th> <td colspan="3"><input type="text" name="modifydate" class="easyui-datebox" value="${insectsIndex.modifydate}"/></td></tr>
			</table>
			
			<table id="specification-table" class="input tabContent">
				<thead>
				<tr>
					<td colspan="9">
						<a href="javascript:;" id="add-specification" class="button">增加特征信息</a>
					</td>
				</tr>
				<tr class="title">
					<!-- <th> 添加图片</th> -->
					<th >检索结果</th>
					<th >序号</th>
					<th >特征</th>
					<th >转去序号</th>
					<th >资料来源</th>
					<th >录入人</th>
					<th >录入日期</th>
					<th> 操作</th>
				</tr>
				</thead>
				<tbody>
					<c:forEach var="insectsSpecifications" items="${insectsIndex.TInsectsSpecifications}" varStatus="status">
					<tr>
						<td><select class="select2 text index jsjgr" style="width:20em;">
							<option value='${jsjglist.get(status.index).id}' selected="selected">${jsjglist.get(status.index).mc}</option>
						</select></td>
						<td><input type="text" name="TInsectsSpecifications[${status.index}].xh" class="text index" value="${insectsSpecifications.xh }"></td>
						<td><input type="text" class="text popeditor" value="${insectsSpecifications.tz }"/><input type="hidden" name="TInsectsSpecifications[${status.index}].tz" class="index" value="${insectsSpecifications.tz }"/></td>
						<td><input type="text" name="TInsectsSpecifications[${status.index}].zqxh" class="text index" value="${insectsSpecifications.zqxh }"/></td>
						<td><input type="text" name="TInsectsSpecifications[${status.index}].source" class="text index" value="${insectsSpecifications.source }" /></td>
						<td><input type="text" name="TInsectsSpecifications[${status.index}].modifer" class="text index" value="${insectsSpecifications.modifer }"/></td>
						<td><input type="text" name="TInsectsSpecifications[${status.index}].modifydate" class="text index" value="${insectsSpecifications.modifydate }" /></td>
						<td>
							<a href="javascript:;" class="deleteIndex" style="width:50px;align:left;" >[ 删除 ]</a>
						</td>
					</tr>				
				</c:forEach>
				</tbody>
			</table> 

		<form id="inputForm"    method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" value="${insectsIndex.id }"/>
			<table class="input tabContent" id="expertAuditTable" style="display:none;">
				<tr><th> 审核通过：</th><td>
				<select id="passaudit" name="passaudit" style="width: 300px;" value="${insectsIndex.passaudit}">
					<option value="false">否</option>
					<option value="true">是</option>
				</select>
				</td></tr>
				<tr><th> 审核意见：</th>
					<td>
						<textarea id="auditadviceeditor" name="auditadvice" style="width: 98%; height:200px ">${insectsIndex.auditadvice}</textarea>
					</td>
				</tr>
				<tr><th> 审核人：</th> <td>${insectsIndex.auditor}</td></tr>
				<tr><th> 审核时间：</th> <td>${insectsIndex.audittime}</td>	</tr>			
			</table>
		</form>
		
			<table class="input">
				<tr><td>&nbsp;</td>
				<td >
				<!--  <input type="submit" class="button" value="save" /> -->
				<a href="javascript:void(0)" class="easyui-linkbutton"
						plain="false" onclick="doAdd()" iconCls="icon-save">保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton"
						plain="false" onclick="goback()" iconCls="icon-back">返回</a>
				</td>
				</tr>
			</table>
			
				<div id="pop-editor">
					<textarea id="editor" class="editor" style="width: 100%;height:100%"></textarea>
					<div style="text-align:center;">
						<a href="javascript:void(0)" class="easyui-linkbutton" plain="false" id="save-content" iconCls="icon-save">确定</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton" plain="false" id="cancel-edit" iconCls="icon-back">取消</a>
					</div>
				</div>
	</div>
	

</body>
</html>