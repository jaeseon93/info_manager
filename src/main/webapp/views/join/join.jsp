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
    </style>
    <script>
        $(document).ready(function(){
            $("#email").change(function(){
               if(!/^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/.test($("#email").val())){
                   alert("정확한 이메일 주소를 입력해주세요");
               }
            });

            $("#pw").change(function(){
               if(!/^[a-z0-9]{4,12}$/.test($("#pw").val())){
                   alert("비밀번호는 4자 이상 12자 이하의 숫자 및 소문자만 입력가능합니다");
                   $("#pw").focus();
               }

            });

            $("#pwCheck").change(function(){
               if($("#pwCheck").val() != $("#pw").val()){
                   $("#pwCheck").focus();
                   $("#pwCheckHelp").show();
               }else{
                   $("#pwCheckHelp").hide();
               }
            });
        });

        function checkJoin(){
        //ajax로 같은 이메일이 존재하나 확인해야함
            var str = $("#email").val();
            var json = {
                email : str
            };
            var parsed = JSON.parse(JSON.stringify(json));
            if($("#pwCheck").val() == $("#pw").val()) {
                $.ajax({
                    type: "POST",
                    url: "emailExistCheck.do",
                    data: parsed,
                    datatype: "json",
                    success: function (data) {
                        let result = JSON.parse(data).result;
                        if (!result) {
                            alert("이메일이 존재합니다");
                        } else {
                            document.getElementById("frm").submit();
                        }
                    }
                });
            }else{
                if($("#pwCheck").val() != $("#pw").val()){
                    $("#pwCheck").focus();
                    $("#pwCheckHelp").show();
                }else{
                    $("#pwCheckHelp").hide();
                }
            }
        }
    </script>
</head>
<body>
<div class="view" style="background-image: url('${pageContext.request.contextPath}/img/wallpaper/login_wallpaper.png'); background-repeat: no-repeat; background-size: cover; background-position: center center;">
    <div class="container" style="width: 30%;">
        <div class="row justify-content-md-center align-items-center"  style="height : 100%;">
            <div class="col">
                <form id="frm" name="frm "action="join.do" method="post" class = "rounded" style="background-color: white; padding : 2em;">
                    <div class="form-group">
                        <label for="email">이메일</label>
                        <input id="email" name="email" class="form-control" placeholder="Email" required>
                        <small id="emailHelp" class="form-text text-muted">반드시 입력해주세요</small>
                        <small id="existId" class="form-text" style="color : red; display : none"> * 해당 아이디는 이미 존재합니다</small>
                    </div>
                    <div class="form-group">
                        <label>비밀번호</label>
                        <input type="password" id="pw" name="pw" class="form-control" placeholder="Password" required>
                        <small id="pwHelp" class="form-text text-muted">비밀번호는 4자 이상 12자 이하의 숫자 및 소문자만 입력가능합니다</small>
                    </div>
                    <div class="form-group">
                        <label>비밀번호 확인</label>
                        <input type="password" id="pwCheck" name="pw" class="form-control" placeholder="Password" required>
                        <small id="pwCheckHelp" class="form-text" style="color:red; display: none">위의 비밀번호와 똑같이 입력하셔야 합니다</small>
                    </div>
                    <button type="button" class="btn btn-primary" onclick="checkJoin()">가입</button>
                    <button type="button" class="btn btn-danger" onclick="location.href='tologinpage.do'">취소</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
