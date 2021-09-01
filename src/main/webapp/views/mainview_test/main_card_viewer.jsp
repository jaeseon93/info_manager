<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2020-04-09
  Time: 오후 4:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ct" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</head>
<script>
    $(function(){
       getCardData();
    });
    function getCardData(){

        let json = {};
        json.type = "password";

        $.ajax({
            type : "post",
            url : "test.do",
            data : json,
            success : function(data){
                let list = JSON.parse(data).list;
                let $div = $("<div>");
                $("#con").prepend($div);

                $.each(list, function(index, item){
                    if(index%3 == 0){
                        $div.addClass("row");
                    }
                    let card = $('<ct:card />');
                    card.find("#title").html(item.email);
                    card.find("#smallText").html(item.password);
                    card.find("#card_body").addClass("bg-primary");
                    $div.append(card);
                });
            }
        });
    }
</script>
<body>
<!--
    로드전에 가져와야할 것 :    1. 어떤종류
                            2. 각 PK 번호
                            3. 갯수
 -->
<div class="container-fluid" id="con">
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
</body>
</html>
