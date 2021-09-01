<%--
  User: Suh
  Date: 2020-04-06
  Time: 오전 12:57
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">

<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<html>
<head>
    <title>회원가입</title>
    <style>
        #divAuth{
            padding-right : 0
        }
        #divHelp{
            margin-top : 1em;
        }
    </style>
</head>
<body>
<div class="view" style="background-image: url('${pageContext.request.contextPath}/img/wallpaper/login_wallpaper.png'); background-repeat: no-repeat; background-size: cover; background-position: center center;">
<div class="container" style="width: 30%;">
    <div class="row justify-content-md-center align-items-center"  style="height : 100%;">
        <div class="col" style="background-color: white; padding : 2em;">
            <form action="twofactor.do" method="post">
                <div class="form-group">
                    <div class="row">
                        <div class="col-12" id="divInputGuide">
                            <label for="auth">Google OTP 숫자 입력 : </label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6" id="divAuth">
                            <input type="password" id="auth" name="auth" class="form-control" placeholder="GoogleOTP" required>
                        </div>
                        <div class="col-6">
                            <button class="btn btn-primary" type="submit">확인</button>
                            <input id="email" name="email" value="${email}" style="display: none" >
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12" id="divHelp">
                            <small id="authHelp" class="form-text text-muted">Google OTP앱을 킨 후에 해당 값을 입력해주세요</small>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</div>
</body>
</html>
