<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="taglib.jsp" %>
<c:set var="easyui" value="${res}easyui/"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>增删改查列子</title>
<%@ include file="easyui_lib.jsp" %>
</head>
<body>

	<div class="easyui-panel search-panel">
		<form id="schForm">
			<table>
				<tr>
					<td class="fm_lab">城市名:</td>
					<td><input name="cityNameSch" type="text"></td>
					<td class="fm_lab">手机号:</td>
					<td><input name="mobileSch" type="text"></td>
					<td class="fm_lab">地址:</td>
					<td><input name="addressSch" type="text"></td>
					<td><a id="schBtn" class="easyui-linkbutton"
						iconCls="icon-search">查询</a></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="toolbar">
		<a id="addBtn" class="easyui-linkbutton" iconCls="icon-add"
			plain="true">添加</a>
	</div>

	<table id="dg"></table>

	<div id="dlg" class="easyui-dialog"
		style="width: 320px; height: 280px; padding: 10px 20px" closed="true"
		modal="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table>
				<tr>
					<td class="fm_lab">城市:</td>
					<td><input name="cityName" type="text"
						class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td class="fm_lab">手机号:</td>
					<td><input name="mobile" type="text"
						class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td class="fm_lab">地址:</td>
					<td><input name="address" type="text"
						class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td class="fm_lab">创建时间:</td>
					<td><input name="createDate" type="text"
						class="easyui-datebox" required="true"></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="dlg-buttons">
		<a id="saveBtn" class="easyui-linkbutton" iconCls="icon-ok">保存</a> <a
			id="cancelBtn" class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
	</div>

<script type="text/javascript">
(function() {
	var that = this;

	var pk = 'orderId'; // java类中的主键字段
	var listUrl = ctx + 'listEasyuiOrderInfo.do'; // 查询
	var addUrl = ctx + 'addEasyuiOrderInfo.do'; // 添加
	var updateUrl = ctx + 'updateEasyuiOrderInfo.do'; // 修改
	var delUrl = ctx + 'delEasyuiOrderInfo.do'; // 删除
	var submitUrl = ''; // 提交URL

	var toolbarId = 'toolbar'; // 工具条ID

	var $dialog = $('#dlg'); // 窗口
	var $form = $('#fm'); // 表单
	var $grid = $('#dg'); // 表格
	var $schForm = $('#schForm'); // 查询表单

	var $schBtn = $('#schBtn'); // 查询按钮
	var $saveBtn = $('#saveBtn'); // 保存按钮
	var $cancelBtn = $('#cancelBtn'); // 取消按钮
	var $addBtn = $('#addBtn'); // 添加按钮

	// 初始化表格
	$grid.datagrid({
		url : listUrl,
		columns : [ [
				{
					field : 'cityName',
					title : '城市'
				},
				{
					field : 'mobile',
					title : '手机号'
				},
				{
					field : 'address',
					title : '地址'
				},
				{
					field : 'createDate',
					title : '创建时间'
				},
				{
					field : '_btn1',
					title : '操作',
					align : 'center',
					formatter : function(val, row) {
						return '<a onclick="'
								+ FunUtil.createFun(that, 'edit', row)
								+ ' return false;">修改</a>'
								+ '<span class="opt-split">|</span>'
								+ '<a onclick="'
								+ FunUtil.createFun(that, 'del', row)
								+ ' return false;">删除</a>'
					}
				} ] ],
		toolbar : '#' + toolbarId,
		pagination : true,
		fitColumns : true,
		singleSelect : true,
		striped : true,
		pageSize : 20
	});

	// 初始化事件
	$addBtn.click(function() {
		$dialog.dialog('open').dialog('setTitle', '添加');
		$form.form('reset');
		submitUrl = addUrl;
	});

	$schBtn.click(function() {
		var data = getFormData($schForm);
		$grid.datagrid('load', data);
	});

	$saveBtn.click(function() {
		save();
	});

	$cancelBtn.click(function() {
		$dialog.dialog('close');
	});

	// 编辑
	this.edit = function(row) {
		if (row) {
			$dialog.dialog('open').dialog('setTitle', '修改');
			$form.form('clear').form('load', row);

			submitUrl = updateUrl + [ '?', pk, '=', row[pk] ].join('');
		}
	}

	// 保存
	this.save = function() {
		var self = this;
		$form.form('submit', {
			url : submitUrl,
			onSubmit : function() {
				return $(this).form('validate');
			},
			success : function(resultTxt) {
				var result = $.parseJSON(resultTxt);
				Action.execResult(result, function(result) {
					$dialog.dialog('close');// close the dialog
					$grid.datagrid('reload');
				});
			}
		});
	}

	// 删除
	this.del = function(row) {
		if (row) {
			$.messager.confirm('确认', '确定要删除该数据吗?', function(r) {
				if (r) {
					Action.post(delUrl, row, function(result) {
						Action.execResult(result, function(result) {
							$grid.datagrid('reload');
						});
					});
				}
			});
		}
	}

})();
</script>
</body>
</html>