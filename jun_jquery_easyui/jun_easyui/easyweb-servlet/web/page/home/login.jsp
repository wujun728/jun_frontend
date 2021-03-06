<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!Doctype html>
<html xmlns=http://www.w3.org/1999/xhtml>
<head>
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>欢迎登录</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <link href="/js/jquery-easyui-1.4/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.8.3.js" type="text/javascript"></script>
    <script src="/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/js/jquery-easyui-1.4/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="/js/base.js" type="text/javascript"></script>
    <link href="/js/showLoading.css" rel="stylesheet" />
    <script src="/js/jquery.showLoading.min.js" type="text/javascript"></script>
    <script src="/js/cloud.js" type="text/javascript"></script>
    <style type="text/css">
        dl, dt, dd, span {
            margin: 0;
            padding: 0;
            display: block;
        }
    </style>
    <script language="javascript" type="text/javascript">
        if (window != window.top) {
            window.top.location.href = window.location.href;
        }
        $(function () {
            $('.loginbox').css({ 'position': 'absolute', 'left': ($(window).width() - 692) / 2 });
            $(window).resize(function () {
                $('.loginbox').css({ 'position': 'absolute', 'left': ($(window).width() - 692) / 2 });
            });
            $("#name").focus();

            $('#pwd,#name').keydown(function (e) {
                if (e.keyCode == 13) {
                    login();
                }
            });

            if ($.cookie("username")) {
                $("#name").val($.cookie("username"));
            }
            if ($.cookie("password")) {
                $("#pwd").val($.cookie("password"));
            }

        });
        function login() {
            var name = $("#name").val();
            var pwd = $("#pwd").val();
            if (name.length <= 0) {
                $.messager.alert("提示", "请输入用户名", "info");
                return false;
            }
            if (pwd.length <= 0) {
                $.messager.alert("提示", "请输入密码", "info");
                return false;
            }
            if (!$("#rem").attr("checked")) {
                $.cookie('username', '', { expires: -1 }); // 删除 cookie
                $.cookie('password', '', { expires: -1 }); // 删除 cookie
            }

            //            $.messager.progress();
            $(".loginbtn").showLoading();
            $.ajax({
                url: '/system/user.do',
                type: "post",
                data: { action: "login", username: name, password: pwd, r: Math.random() },
                dataType: "json",
                success: function (result) {
                    if ($("#rem").attr("checked")) {
                        $.cookie("username", name, { expires: 99, secure: false, path: "/" });
                        $.cookie("password", pwd, { expires: 99, secure: false, path: "/" });
                    }
                    if (result.success) {
                        $.messager.progress({title:"登录成功",msg:"正在跳转..."});

                        location.href = ".";
                    } else {
                        //  $("#pwd").val("").focus();
                        $.messager.alert("错误", result.msg, "error");
                    }
                },
                error: function (x, h, c) {
                    $.messager.alert("错误", "登录失败,请刷新页面后重试", "error");
                },
                complete: function () {
                    $(".loginbtn").hideLoading();
                }
            });
        }

    </script>
</head>
<body style="background-color: #1c77ac; background-image: url(../../images/light.png);
    background-repeat: no-repeat; background-position: center top; overflow: hidden;">
<div id="mainBody">
    <div id="cloud1" class="cloud">
    </div>
    <div id="cloud2" class="cloud">
    </div>
</div>
<div class="loginbody">
    <span class="systemlogo"></span>
    <div class="loginbox">
        <form id="login-fm" method="post">
            <ul>
                <li>
                    <input id="name" name="name" type="text" class="loginuser" />
                </li>
                <li>
                    <input id="pwd" name="pwd" type="password" class="loginpwd" />
                </li>
                <li>
                    <input name="" type="button" class="loginbtn" value="登录" onclick="login()" />
                    <label>
                        <input id="rem" name="rem" type="checkbox" checked="checked" />记住密码
                    </label>
                    <label>
                        <a href="chrome.exe">下载Chrome浏览器</a>
                    </label>
                </li>
            </ul>
        </form>
    </div>
</div>
<div class="loginbm">
    版权所有 2015 <a href="http://www.youotech.com/">youotech.com</a>
</div>

</body>
</html>