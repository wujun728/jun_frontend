<%--
  Created by IntelliJ IDEA.
  User: WangGenshen
  Date: 5/18/16
  Time: 19:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <title>客户列表-青岛宝瑞媒体发布系统</title>
    <meta charset="UTF-8"/>
    <link rel="stylesheet" href="<%=path %>/js/jquery-easyui/themes/default/easyui.css"/>
    <link rel="stylesheet" href="<%=path %>/js/jquery-easyui/themes/icon.css"/>
    <link rel="stylesheet" href="<%=path %>/css/site_main.css"/>

    <script src="<%=path %>/js/jquery.min.js"></script>
    <script src="<%=path %>/js/jquery.form.js"></script>
    <script src="<%=path %>/js/jquery-easyui/jquery.easyui.min.js"></script>
    <script src="<%=path %>/js/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
    <script src="<%=path %>/js/site_easyui.js"></script>

    <script src="<%=path %>/js/customer/customers.js"></script>
</head>
<body>
<table id="list" class="easyui-datagrid" toolbar="#tb" style="height:100%;"
       data-options="
        url:'<%=path %>/customer/search_pager',
        method:'get',
				rownumbers:true,
				singleSelect:true,
				autoRowHeight:false,
				pagination:true,
				border:false,
				pageSize:50,
				pageList: [40, 50, 60, 70],
				rowStyler: function(index,row){
					if (row.role == 'super'){
						return 'background-color:#ccc;';
					} else if (row.status == 'N') {
					    return 'color:red;';
					}
				}">
    <thead>
    <tr>
        <th field="id" checkbox="true" width="50">用户ID</th>
        <th field="email" width="150">邮箱</th>
        <th field="name" width="100">姓名</th>
        <th field="phone" width="100">手机号</th>
        <th field="company" width="100">公司</th>
        <th field="address" width="200">地址</th>
        <th field="createTime" width="135" formatter="formatterDate">创建时间</th>
        <th field="loginTime" width="135" formatter="formatterDate">最近登录时间</th>
        <th field="status" width="50" formatter="formatterStatus">状态</th>
    </tr>
    </thead>
</table>
<div id="tb">
    <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-add" plain="true"
       onclick="openWinFitPos('addWin');">添加</a>
    <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-edit" plain="true"
       onclick="showEdit();">修改</a>
    <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-edit" plain="true"
       onclick="showUpdatePwd();">修改密码</a>
    <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-edit" plain="true"
       onclick="showUpdateCheckPwd();">修改审核密码</a>
    <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-remove" plain="true"
       onclick="inactive()">冻结</a>
    <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-ok" plain="true"
       onclick="active()">激活</a>
    <div class="input_small">
        <form id="searchForm" modalAttribute="customer">
            邮箱:<input type="email" name="email" class="easyui-textbox"/>
            姓名:<input type="text" name="name" class="easyui-textbox"/>
            手机:<input type="text" name="phone" class="easyui-textbox"/>
            状态:<select id="statusSearch" name="status" class="easyui-combobox" data-options="valueField: 'id',textField: 'text',panelHeight:'auto',
                    data: [{
                        id: 'Y',
                        text: '可用'
                    },{
                        id: 'N',
                        text: '不可用'
                    }]">
        </select>
            <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
               onclick="doSearch();">搜索</a>
            <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
               onclick="searchAll();">查询所有</a>
            <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-reload'"
               onclick="refreshAll();">刷新</a>
        </form>
    </div>
</div>

<div class="easyui-window site_win_normal input_big" id="addWin" data-options="title:'添加客户',resizable:false,mode:true,closed:true">
    <form:form id="addForm" modelAttribute="customer">
        <table>
            <tr>
                <td>邮箱:</td>
                <td><input type="text" name="email" class="easyui-validatebox easyui-textbox"
                           data-options="required:true,validType:'email',novalidate:true"/></td>
            </tr>
            <tr>
                <td>密码:</td>
                <td><input type="password" name="password" class="easyui-validatebox easyui-textbox"
                           data-options="required:true,validType:'length[6,20]',novalidate:true"/></td>
            </tr>
            <tr>
                <td>审核密码:</td>
                <td><input type="password" name="checkPwd" class="easyui-validatebox easyui-textbox"
                           data-options="required:true,validType:'length[6,20]',novalidate:true"/></td>
            </tr>
            <tr>
                <td>姓名:</td>
                <td><input type="text" name="name" class="easyui-validatebox easyui-textbox"
                           data-options="required:false,novalidate:true"/></td>
            </tr>
            <tr>
                <td>手机:</td>
                <td><input type="text" name="phone" class="easyui-validatebox easyui-textbox"
                           data-options="required:false,validType:'length[11,13]',novalidate:true"/></td>
            </tr>
            <tr>
                <td>公司:</td>
                <td><input type="text" name="company" class="easyui-textbox"/></td>
            </tr>
            <tr>
                <td>地址:</td>
                <td><input type="text" name="address" class="easyui-textbox"/></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <button type="button" onclick="add();">确认</button>
                </td>
            </tr>
        </table>
    </form:form>
</div>

<div class="easyui-window site_win_small input_big" id="editWin" data-options="title:'修改账号信息',resizable:false,mode:true,closed:true">
    <div id="errMsg"></div>
    <form id="editForm" method="post" modelAttribute="customer">
        <input type="hidden" name="id" />
        <table>
            <tr>
                <td>邮箱:</td>
                <td><input type="text" name="email" class="easyui-textbox" readonly="true"/></td>
            </tr>
            <tr>
                <td>姓名:</td>
                <td><input type="text" name="name" class="easyui-validatebox easyui-textbox"
                           data-options="required:false,novalidate:true"/></td>
            </tr>
            <tr>
                <td>手机:</td>
                <td><input type="text" name="phone" class="easyui-validatebox easyui-textbox"
                           data-options="required:false,validType:'length[11,13]',novalidate:true"/></td>
            </tr>
            <tr>
                <td>公司:</td>
                <td><input type="text" name="company" class="easyui-textbox"/></td>
            </tr>
            <tr>
                <td>地址:</td>
                <td><input type="text" name="address" class="easyui-textbox"/></td>
            </tr>
            <tr>
                <td><button type="button" onclick="closeWin('editWin');">取消</button></td>
                <td>
                    <button type="button" onclick="edit();">确认</button>
                </td>
            </tr>
        </table>
    </form>
</div>

<div class="easyui-window site_win_small input_big" id="editPwdWin" data-options="title:'修改客户密码',resizable:false,mode:true,closed:true">
    <div id="errMsg"></div>
    <form:form id="editPwdForm" method="post" modelAttribute="admin">
        <input type="hidden" name="id" />
        <table class="input_big">
            <tr>
                <td>新密码:</td>
                <td><input id="update_password" type="password" name="password" class="easyui-validatebox easyui-textbox"
                           data-options="required:true,validType:'length[6,20]',novalidate:true"/></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <button type="button" onclick="updatePwd();">确认</button>
                </td>
            </tr>
        </table>
    </form:form>
</div>

<div class="easyui-window site_win_small input_big" id="editCheckPwdWin" data-options="title:'修改客户审核密码',resizable:false,mode:true,closed:true">
    <div id="errMsg"></div>
    <form:form id="editCheckPwdForm" method="post" modelAttribute="admin">
        <input type="hidden" name="id" />
        <table class="input_big">
            <tr>
                <td>新审核密码:</td>
                <td><input id="update_checkPwd" type="password" name="checkPwd" class="easyui-validatebox easyui-textbox"
                           data-options="required:true,validType:'length[6,20]',novalidate:true"/></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <button type="button" onclick="updateCheckPwd();">确认</button>
                </td>
            </tr>
        </table>
    </form:form>
</div>

</body>
</html>
