<%@ page import="co.yedam.ic.common.Strings" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2020-04-06
  Time: 오후 2:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    #authButton {
        height: calc(1.5em + .75rem + 2px);
        margin-left: 0.5em;
    }
</style>
<script>
    $(function(){
        $("#btnCancel").on("click", function(){
            $("#divBody").load("toHome.do");
        });
        $("#pw").change(function(){
            let pwVal = $("#pw").val();
            if(!/^[a-z0-9]{4,12}$/.test(pwVal)){
                alert("비밀번호는 4자 이상 12자 이하의 숫자 및 소문자만 입력가능합니다");
                $("#pw").focus();
            }
        });

        $("#checkPw").change(function(){
            if($("#checkPw").val() != $("#pw").val()){
                $("#checkPwWarning").show();
                $("#checkPw").focus();
            }else{
                $("#checkPwWarning").hide();
            }
        });
    });
    function changePw(){
        if(!inputCheck()) {
            alert("비밀번호들을 올바르게 입력해주십시오");
            return;
        }
        let json = {};

        json.curPw = $("#curPw").val();
        json.pw = $("#pw").val();
        json.phone = $("#phone").val();




        $.ajax({
            type:"POST",
            url:"changepw.do",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: json,
            datatype:"json",
            success: function(data) {
                let result = JSON.parse(data).result;
                console.log(result);
                if(result == "<%= Strings.RESULT_OK %>"){
                    alert("사용자 정보 변경 완료");
                    $("#curPw").val("");
                    $("#pw").val("");
                    $("#checkPw").val("");
                }else if(result == "<%= Strings.RESULT_WRONG_PASSWORD %>"){
                    alert("현재 비밀번호가 맞지 않습니다");
                    $("#curPw").focus();
                }else{
                    alert("연결이 원활하지 않습니다. 나중에 다시 시도해주세요");
                }
            }
        });
    }
</script>
<div class="container">
    <div class="row justify-content-md-center align-items-center"  style="height : 100%;">
        <div class="col">
            <form method="post">
                <div class="form-group">
                    <label for="email">이메일</label>
                    <input id="email" name="email" class="form-control" placeholder="Email" value="${email}" disabled>
                    <small id="emailHelp" class="form-text text-muted">반드시 입력해주세요</small>
                </div>
                <div class="form-group">
                    <label>현재 비밀번호</label>
                    <input type="password" id="curPw" name="pw" class="form-control" placeholder="Password" required>
                    <small id="curPwHelp" class="form-text text-muted">현재 비밀번호를 입력해주세요</small>
                </div>
                <div class="form-group">
                    <label>변경할 비밀번호</label>
                    <input type="password" id="pw" name="pw" class="form-control" placeholder="Password" required>
                    <small id="pwHelp" class="form-text text-muted">비밀번호는 4자 이상 12자 이하의 숫자 및 소문자만 입력가능합니다</small>
                </div>
                <div class="form-group">
                    <label>비밀번호 확인</label>
                    <input type="password" id="checkPw" name="pw" class="form-control" placeholder="Password" required>
                    <small id="checkPwHelp" class="form-text text-muted">변경할 비밀번호와 같은 값을 입력해주세요</small>
                    <small id="checkPwWarning" class="form-text text-danger d-none"> * 변경할 비밀번호와 같은 값을 입력해주세요</small>
                </div>
                <div class="form-group">
                    <label>핸드폰 번호</label>
                    <input type ="text" id="phone" name="phone" class="form-control" placeholder="Phone Number">
                    <small id="phoneHelp" class="form-text text-muted">핸드폰 번호를 입력해주세요</small>
                </div>
                <button type="button" id = "btnSave" class="btn btn-primary">저장</button>
                <button type="button" id="btnCancel" class="btn btn-danger">취소</button>
            </form>
            <hr>
        </div>
    </div>
    <div class="row" id="divAddTwoFactor">
        <div class="col">
            <form>
                <div class="row">
                    <div class="col-2">
                        <button type="button" id="btnGenTwo" class="btn btn-primary">2차 인증 생성</button>
                    </div>
                    <div class="col-10 d-none divAuth">
                        <div class="row">
                            <div class="col-4">
                                <img id = "twoFactorImg" src="" />
                                <input type="text" id="otpKey" name="otpKey">
                            </div>
                            <div class="col-8">
                                <br>Google OTP를 다운 받은 후 인증해주세요<br>
                                <a id="aAppLink" class="form-text" href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=ko">Google OTP앱 다운로드</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row  d-none divAuth">
                    <div class="col-2">
                        <label for="auth">OTP 숫자 입력 : </label>
                    </div>
                    <div class="col-10">
                        <div class="row">
                            <div class="form-group w-25">
                                <input type="password" id="auth" name="auth" class="form-control" placeholder="OTP" required>
                            </div>

                            <button id="btnAuth" type="button" class="btn btn-primary">확인</button>
                        </div>
                        <div class="row">
                            <small id="authHelp" class="form-text text-muted">OTP앱을 킨 후에 해당 값을 입력해주세요</small>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="row" id="divOTPComplete">
        <div class="col-12">
            OTP 등록이 완료되었습니다.
        </div>
    </div>
</div>
