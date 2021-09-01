<%--
  User: Suh
  Date: 2020-04-08
  Time: 오후 8:23
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
    <a class="navbar-brand" id="a_logo" href="toMain.do">Information Container</a>
    <!-- Navbar Search-->
    <div id="search-div" class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
        <div class="input-group">
            <input id="input-search" class="form-control" type="text" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2" />
            <div class="input-group-append">
                <button id="btnSearch" class="btn btn-primary" type="button">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
    </div>
    <!-- Navbar-->
    <ul class="navbar-nav ml-auto ml-md-0">
        <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="userDropdown" href="#"
                role="button" data-toggle="dropdown" aria-haspopup="true"
                aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
            <div class="dropdown-menu dropdown-menu-right"
                 aria-labelledby="userDropdown">
                <a class="dropdown-item" id="aEdit" href="#">설정</a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" id="aLogout" href="#">로그아웃</a>
            </div></li>
    </ul>
</nav>
