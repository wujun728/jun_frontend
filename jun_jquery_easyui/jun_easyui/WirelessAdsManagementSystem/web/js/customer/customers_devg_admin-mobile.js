var contextPath = '';

$(function() {
    setPagination("#list");
    $('#list').datagrid({
        onDblClickCell: function(rowIndex, rowData){
            showDevgMob();
        }
    });
    $("#statusSearch").combobox({
        onChange:function(n, o){
            if (n != o) {
                doSearch();
            }
        }
    });
});

function showDevg() {
    var row = selectedRow("list");
    if (row) {
        addTab(row.email + "的终端分组列表", contextPath + "/devgroup/list_page_admin/" + row.id);
    } else {
        $.messager.alert("提示", "请先选择客户", "info");
    }
}

function showDevgMob() {
    var row = selectedRow("list");
    if (row) {
        // addTab(row.email + "的终端分组列表", contextPath + "/devgroup/mob/list_page_admin/" + row.id);
        toPage(contextPath + "/devgroup/mob/list_page_admin/" + row.id);
    } else {
        $.messager.alert("提示", "请先选择客户", "info");
    }
}

function doSearch() {
    $("#list").datagrid({
        url:contextPath + '/customer/search_pager',
        pageSize:defaultPageSize,
        queryParams:getQueryParams("list", "searchForm")
    });
    setPagination("#list");
}

function searchAll() {
    $("#searchForm").form("clear");
    $("#list").datagrid({
        url:contextPath + '/customer/search_pager',
        pageSize:defaultPageSize,
        queryParams:getQueryParams("list", "searchForm")
    });
    setPagination("#list");
}

function refreshAll() {
    $("#list").datagrid("reload");
}