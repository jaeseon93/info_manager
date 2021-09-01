<%@ page import="co.yedam.ic.common.Strings" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2020-04-06
  Time: 오전 8:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty memberno}">
    <jsp:forward page="/toMain.do"/>
</c:if>


<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">

<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<html>
<head>
    <title>회원가입</title>
    <script>

        $(function () {
            $("#btnLogin").bind("click", checkLogin);
            $("#btnJoin").bind("click", function () {
                $("#frm2").submit();
            });
            $("#spinner").hide();
        });


        function successCheck(data) {
            if (data.result) {
                $("#frm").submit();
            } else {
                $("#spinner").hide();
                $("#btnLogin").bind("click", checkLogin);
                alert("아이디 또는 패스워드가 틀렸습니다");
            }
        }

        function checkLogin() {
            let email = $("#email").val();
            let pw = $("#pw").val();
            let json = {};
            json.email = email;
            json.pw = pw;
            $("#spinner").show();
            $("#btnLogin").unbind("click", checkLogin);

            $.ajax({
                type: "POST",
                url: "loginCheck.do",
                data: json,
                success: successCheck,
                fail: () => {
                    alert("서버 연결에 문제가 있습니다. 잠시 후 다시 이용해주세요");
                    $("#btnLogin").bind("click", checkLogin);
                    $("#spinner").hide();
                },
                dataType: "json"
            });
        }
    </script>
</head>
<body>
<div class="view" style="background-image: url('${pageContext.request.contextPath}/img/wallpaper/login_wallpaper.png'); background-repeat: no-repeat; background-size: cover; background-position: center center;">
    <div class="container">
        <div class="row justify-content-md-center align-items-center" style="height : 100%;">
            <div class="col-md-auto rounded" style="background-color: white; padding : 2em;">
                <form id="frm" action="login.do" method="post">
                    <div class="form-group">
                        <label for="email">이메일</label>
                        <input type="text" id="email" name="email" class="form-control" placeholder="Email" required>
                        <small id="emailHelp" class="form-text text-muted">반드시 입력해주세요</small>
                    </div>
                    <div class="form-group">
                        <label>비밀번호</label>
                        <input type="password" id="pw" name="pw" class="form-control" placeholder="Password" required>
                        <small id="pwHelp" class="form-text text-muted">비밀번호는 4자 이상 12자 이하의 숫자 및 소문자만 입력가능합니다 </small>
                    </div>
                </form>
                <form id="frm2" action="<%= Strings.CON_JOIN_PAGE %>" method="post"></form>
                <button type="button" id="btnLogin" class="btn btn-primary"><span id="spinner"
                                                                                  class="spinner-border spinner-border-sm"
                                                                                  role="status"
                                                                                  aria-hidden="true"></span>로그인
                </button>
                <button type="button" id="btnJoin" class="btn btn-danger">회원가입</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
