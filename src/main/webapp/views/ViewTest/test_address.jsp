<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="ct" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>App</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/member_info.js"></script>
    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js" crossorigin="anonymous"></script>
</head>
<style>
    #divSide{
        margin-top : 3.5em;
        position:fixed;
    }
    #divBody{
        margin-top : 4.5em;
        margin-left : 14em;
    }
    #btnToggleModal{
        position : fixed;
        bottom : 2em;
        right : 2em;

    }
    .modal-body {
        position: relative;
        overflow-y: auto;
    }
</style>
<body>
<div class="container-fluid p-0">
    <div class="row no-gutters">
        <div class="col-12 fixed-top">
            <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
                <a class="navbar-brand" href="#">Information Container</a>
                <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#">
                    <i class="fas fa-bars"></i>
                </button>
                <!-- Navbar Search-->
                <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
                    <div class="input-group">
                        <input class="form-control" type="text" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2" />
                        <div class="input-group-append">
                            <button class="btn btn-primary" type="button">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </form>
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

        </div>
        <!-- header div end -->
    </div>
    <div class="row no-gutters">
        <!-- left div -->
        <div class="col-2" id="divSide">
            <%--
  User: Suh
  Date: 2020-04-08
  Time: 오후 8:28
--%>
            <script>
                $(function(){

                })
            </script>
            <div id="layoutSidenav">
                <div id="layoutSidenav_nav">
                    <nav class="sb-sidenav accordion sb-sidenav-dark"
                         id="sidenavAccordion">
                        <div class="sb-sidenav-menu">
                            <div class="nav">
                                <a href="#" id="btnHome" class="nav-link">
                                    <svg class="bi bi-house" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" d="M2 13.5V7h1v6.5a.5.5 0 00.5.5h9a.5.5 0 00.5-.5V7h1v6.5a1.5 1.5 0 01-1.5 1.5h-9A1.5 1.5 0 012 13.5zm11-11V6l-2-2V2.5a.5.5 0 01.5-.5h1a.5.5 0 01.5.5z" clip-rule="evenodd" />
                                        <path fill-rule="evenodd" d="M7.293 1.5a1 1 0 011.414 0l6.647 6.646a.5.5 0 01-.708.708L8 2.207 1.354 8.854a.5.5 0 11-.708-.708L7.293 1.5z" clip-rule="evenodd" />
                                    </svg>
                                    &nbsp; 홈
                                </a>
                                <a href="#" id="btnPassword" class="nav-link" >
                                    <svg class="bi bi-lock" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" d="M11.5 8h-7a1 1 0 00-1 1v5a1 1 0 001 1h7a1 1 0 001-1V9a1 1 0 00-1-1zm-7-1a2 2 0 00-2 2v5a2 2 0 002 2h7a2 2 0 002-2V9a2 2 0 00-2-2h-7zm0-3a3.5 3.5 0 117 0v3h-1V4a2.5 2.5 0 00-5 0v3h-1V4z" clip-rule="evenodd" />
                                    </svg>
                                    &nbsp; 비밀번호
                                </a>
                                <a href="#" id="btnNote" class="nav-link">
                                    <svg class="bi bi-pencil" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" d="M11.293 1.293a1 1 0 011.414 0l2 2a1 1 0 010 1.414l-9 9a1 1 0 01-.39.242l-3 1a1 1 0 01-1.266-1.265l1-3a1 1 0 01.242-.391l9-9zM12 2l2 2-9 9-3 1 1-3 9-9z" clip-rule="evenodd" />
                                        <path fill-rule="evenodd" d="M12.146 6.354l-2.5-2.5.708-.708 2.5 2.5-.707.708zM3 10v.5a.5.5 0 00.5.5H4v.5a.5.5 0 00.5.5H5v.5a.5.5 0 00.5.5H6v-1.5a.5.5 0 00-.5-.5H5v-.5a.5.5 0 00-.5-.5H3z" clip-rule="evenodd" />
                                    </svg>
                                    &nbsp; 노트
                                </a>
                                <a href="#" id="btnReceipt" class="nav-link">
                                    <svg class="bi bi-credit-card" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" d="M14 3H2a1 1 0 00-1 1v8a1 1 0 001 1h12a1 1 0 001-1V4a1 1 0 00-1-1zM2 2a2 2 0 00-2 2v8a2 2 0 002 2h12a2 2 0 002-2V4a2 2 0 00-2-2H2z" clip-rule="evenodd" />
                                        <rect width="3" height="3" x="2" y="9" rx="1" />
                                        <path d="M1 5h14v2H1z" />
                                    </svg>
                                    &nbsp; 영수증
                                </a>
                                <a href="#" id="btnAddress" class="nav-link">
                                    <svg
                                            class="bi bi-person-lines-fill" width="1em" height="1em"
                                            viewBox="0 0 16 16" fill="currentColor"
                                            xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 100-6 3 3 0 000 6zm7 1.5a.5.5 0 01.5-.5h2a.5.5 0 010 1h-2a.5.5 0 01-.5-.5zm-2-3a.5.5 0 01.5-.5h4a.5.5 0 010 1h-4a.5.5 0 01-.5-.5zm0-3a.5.5 0 01.5-.5h4a.5.5 0 010 1h-4a.5.5 0 01-.5-.5zm2 9a.5.5 0 01.5-.5h2a.5.5 0 010 1h-2a.5.5 0 01-.5-.5z" clip-rule="evenodd" />
                                    </svg>
                                    &nbsp; 주소
                                </a>
                            </div>
                        </div>
                        <div class="sb-sidenav-footer">
                            <div class="small">Logged in as:</div>
                            ${email}
                        </div>
                    </nav>
                </div>
                <div id="layoutSidenav_content">
                    <main>

                    </main>
                    <footer class="py-4 mt-auto">
                        <div class="container-fluid">
                            <div
                                    class="d-flex align-items-center justify-content-between small">
                                <div class="text-muted"></div>
                                <div>
                                    <a href="#"></a><a href="#"></a>
                                </div>
                            </div>
                        </div>
                    </footer>
                </div>
            </div>
        </div>
        <!-- left div end -->
        <!-- right div -->
        <div class="col-10" id="divBody">
            <script>
                $(function(){
                    getCardData();
                });

                function clickRemoveBtn(){
                    //ajax를 이용해 삭제

                    //결과가 참이면 해당 카드를 삭제
                }

                function clickEditBtn(){
                    let $myModal = $("#myModal");
                    $myModal.modal(true);
                    let $btnConfirm =  $myModal.find("#btn_modal_left");


                    let $btnCancel =  $myModal.find("#btn_modal_right");
                    $btnCancel.html("닫기"); //우측 밑의 닫기버튼 글자 변경
                    $("#btn_modal_close").bind("click", function(){ $myModal.modal(false) }); //우측 위 x버튼 기능을 닫기로 설정

                    //직접 설정해야 하는 것들
                    $btnConfirm.html("저장"); //저장 버튼 글자 변경
                    $btnConfirm.bind("click", function(){}); //저장 버튼 눌렀을때 실행될 함수
                    console.log("#div_modal_body");
                    $("#div_modal_body").load("tojoinpage.do"); //컨트롤러 경로;
                    $("#modal_head").html("제목입니다"); //Modal 의 윗부분 제목에 들어갈 글자

                    document.getElementById("id").value = 10;
                }

                function getCardData(){
                    $.ajax({
                        type : "post",
                        url : "test.do", //여기에 각자의 ajax 결과값을 보낼 controller를 연결
                        success : function(data){
                            let list = JSON.parse(data).list;
                            let $div = $("<div>");
                            $("#con").append($div);

                            $.each(list, function(index, item){
                                if(index%3 == 0){
                                    $div.addClass("row");
                                }
                                let card = $('<ct:card />'); //여기의 각자의 커스텀 태그를 입력
                                card.find("button[name=btnEdit]").bind("click", clickEditBtn);

                                //여기부터 card에 들어갈 값을 입력
                                card.find("#title").html(item.email);
                                card.find("#smallText").html(item.password);
                                card.find("#card_body").addClass("bg-primary"); //카드배경색  클래스 이건 부트스트랩 찾아서 넣어야함
                                $div.append(card);
                            });
                        }
                    });
                }
            </script>
            <div class="container-fluid">
                <div id="con">

                </div>
                <div class="pt-5 pb-5 mt-5 mb-5"></div>
                <div class="row">
                    <ct:modal />
                </div>
                <div class="row">
                    <div class="col-12">
                        <button id="btnToggleModal" type="button" class="btn1 btn-danger rounded-circle btn-lg" data-toggle="modal" data-target="#myModal">#btnToggleModal</button>
                    </div>
                </div>
            </div>

        </div>
        <!-- right div end -->
    </div>

</div>
</body>
</html>