<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2020-04-06
  Time: 오전 8:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container">
    <div class="row justify-content-md-center align-items-center"  style="height : 100%;">
        <div class="col-md-auto">
            <form action="/login.do" method="post">
                <div class="form-group">
                    <label for="email">이메일</label>
                    <input id="email" name="email" class="form-control" placeholder="Email" required>
                    <small id="emailHelp" class="form-text text-muted">반드시 입력해주세요</small>
                </div>
                <div class="form-group">
                    <label>비밀번호</label>
                    <input id="pw" name="pw" class="form-control" placeholder="Password" required>
                    <small id="pwHelp" class="form-text text-muted">12자리 이상....</small>
                </div>
                <button type="submit" class="btn btn-primary">로그인</button>
                <button type="button" class="btn btn-danger">회원가입</button>
            </form>
        </div>
    </div>
</div>
