<%--
  User: Suh
  Date: 2020-04-08
  Time: 오후 8:22
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ct" tagdir="/WEB-INF/tags" %>
<script>
    $(function () {
        let $con = $("#con");
        $rowDiv = $("<div>");
        $con.append($rowDiv);
        $rowDiv.addClass("row");
        getPWData();
        getReceiptData();
        getNoteData();
        getAddrData();
    });


    function clickGoBtn() {
        copyValue = "";
        new ClipboardJS('.clipb', {
            text: function (trigger) {
                console.log("copy ok");
                return copyValue;
            }
        });

        let json = {};
        let url = ($(this).parent().parent().parent()).find("div[name=urlText]").html();
        let value = ($(this).parent().parent().parent()).find("input[name=cardTag]").val();
        json.pwkey = value;

        let sub = url.substring(0,7);

        $.ajax({
            type : "post",
            url : "pwSend.do",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: json,
            datatype:"json",
            success : function(data) {
                copyValue = data;
                console.log(copyValue);
                if ( sub == "http://" || sub == "https:/" ) {
                    window.open(url, '_blank');
                } else {
                    window.open( "http://"+url, '_blank');
                }
            }
        });
    }

    function getPWData() {

        $.ajax({
            type: "post",
            url: "pwHome.do", //여기에 각자의 ajax 결과값을 보낼 controller를 연결
            async: false,
            success: function (data) {
                let list = JSON.parse(data).list;


                $.each(list, function (index, item) {
                    let card = $('<ct:pwCard />'); //여기의 각자의 커스텀 태그를 입력
                    card.find("button[name=btnEdit]").on("click", clickPWEditBtn);
                    card.find("button[name=btnRemove]").on("click", clickPWRemoveBtn);
                    card.find("button[name=btnGo]").bind("click", clickGoBtn);
                    card.find("input[name=cardTag]").val(item.cardKey);

                    //여기부터 card에 들어갈 값을 입력
                    card.find("#title").html(item.sitename);
                    card.find("#smallText").html(item.url);
                    card.find("#card_body").addClass("bg-secondary"); //카드배경색  클래스 이건 부트스트랩 찾아서 넣어야함
                    $rowDiv.append(card);
                });
            }
        });
    }

    function clickPWEditBtn() {
        let $myModal = $("#myModal");
        $myModal.modal(true);
        let $btnConfirm = $myModal.find("#btn_modal_left");
        let $btnCancel = $myModal.find("#btn_modal_right");
        $btnCancel.html("닫기"); //우측 밑의 닫기버튼 글자 변경


        //직접 설정해야 하는 것들
        $btnConfirm.html("수정"); //저장 버튼 글자 변경
        $btnConfirm.off();
        $btnConfirm.on("click", editPWFunction);

        let jsoned = {};
        jsoned.selectedString = ""; //키값을 찾아 직접하시오
        let value = ($(this).parent()).find("input[name=cardTag]").val();
        jsoned.selectedString = value;
        $.ajax({
            url: "pwselected.do",
            data: jsoned,
            datatype: "json",
            async: false,
            success: function () {
                $("#div_modal_body").load("pwselect.do"); //컨트롤러 경로;
            }
        });

        $("#modal_head").html("비밀번호 수정"); //Modal 의 윗부분 제목에 들어갈 글자
    }

    function editPWFunction() {
        let json = {};
        json.url = $("#url").val();
        json.sitename = $("#sitename").val();
        json.siteid = $("#siteid").val();
        json.sitepw = $("#sitepw").val();
        json.note = $("#note").val();
        $.ajax({
            url: "updatepw.do",
            type: "POST",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: json,
            datatype: "json",
            success: function (data) {
                let json = JSON.parse(data);
                if (json.result) {
                    alert("수정이 완료되었습니다.");
                    $("#divBody").load("toHome.do");

                } else {
                    alert("수정에 실패하였습니다.");
                }
            }
        });
    }

    function clickPWRemoveBtn() {

        let json = {};
        let value = ($(this).parent()).find("input[name=cardTag]").val();
        json.pdelete = value;

        $.ajax({
            url:"deletepw.do",
            type:"POST",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: json,
            datatype:"json",
            success: function(data) {
                if( data == "true") {
                    alert("삭제 되었습니다.");
                    $("#divBody").load("toHome.do");
                } else {
                    alert("삭제에 실패하였습니다.");
                }
            }
        });
    }

    function getNoteData() {
        $.ajax({
            type: "post",
            url: "NoteSelect.do", //여기에 각자의 ajax 결과값을 보낼 controller를 연결
            async: false,
            success: function (data) {
                let list = JSON.parse(data).list;
                $.each(list, function (index, item) {
                    let card = $('<ct:card />'); //여기의 각자의 커스텀 태그를 입력
                    card.find("button[name=btnEdit]").on("click", clickNoteEditBtn);
                    card.find("button[name=btnRemove]").on("click", clickNoteRemoveBtn);
                    card.find("input[name=cardTag]").val(item.index);
                    //여기부터 card에 들어갈 값을 입력
                    console.log(item.index);
                    card.find("#title").html(item.title);
                    card.find("#smallText").html(item.ncontent);
                    card.find("#card_body").addClass("bg-danger"); //카드배경색  클래스 이건 부트스트랩 찾아서 넣어야함
                    $rowDiv.append(card);
                });
            }
        });
    }

    function clickNoteEditBtn() {
        let $myModal = $("#myModal");
        $myModal.modal(true);
        let $btnConfirm = $myModal.find("#btn_modal_left");


        let $btnCancel = $myModal.find("#btn_modal_right");
        $btnCancel.html("닫기"); //우측 밑의 닫기버튼 글자 변경

        //직접 설정해야 하는 것들
        $btnConfirm.html("수정"); //저장 버튼 글자 변경

        $btnConfirm.off();
        $btnConfirm.on("click", editNoteFunction);

        let jsoned = {};
        jsoned.selectedString = "";
        let value = ($(this).parent()).find("input[name=cardTag]").val();
        jsoned.selectedString = value;

        $.ajax({
            url: "noselected.do",
            data: jsoned,
            datatype: "json",
            async: false,
            success: function () {
                console.log("hahahahahah");
                $("#div_modal_body").load("noteoneselect.do");
            }

        });
        $("#modal_head").html("note수정");
    }

    function editNoteFunction() {
        let json = {};
        json.title = $("#ntitle").val();
        json.ncontent = $("#ncontent").val();
        $.ajax({
            url: "NoteUpdate.do",
            type: "POST",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: json,
            datatype: "json",
            success: function (data) {
                let json = JSON.parse(data);
                if (json.result != "0") {
                    alert("내용이 수정되었습니다.");
                    $("#divBody").load("toHome.do");
                } else {
                    alert("수정에 실패하였습니다.");
                }
            }
        });
    }

    function clickNoteRemoveBtn() {
        let json = {};
        let value = ($(this).parent()).find("input[name=cardTag]").val();
        json.ndelete = value;
        $.ajax({

            url: "notedelete.do",
            type: "POST",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: json,
            datatype: "json",
            success: function (data) {
                let json = JSON.parse(data);
                if (json.result != "0") {
                    alert("카드가 삭제되었습니다.");
                    $("#divBody").load("toHome.do");

                } else {
                    alert("삭제가 실패하였습니다.");
                }
            }
        });
    }

    function getReceiptData() {
        $.ajax({
            type: "post",
            url: "rctCard.do", //여기에 각자의 ajax 결과값을 보낼 controller를 연결
            async: false,
            success: function (data) {
                let list = JSON.parse(data).list;
                $.each(list, function (index, item) {
                    let card = $('<ct:card />'); //여기의 각자의 커스텀 태그를 입력
                    card.find("button[name=btnEdit]").on("click", clickReceiptEditBtn);
                    card.find("button[name=btnRemove]").on("click", clickReceiptRemoveBtn);
                    card.find("input[name=cardTag]").val(item.cardKey);


                    //여기부터 card에 들어갈 값을 입력
                    card.find("#title").html(item.title);
                    card.find("#smallText").html(item.total);
                    card.find("#card_body").addClass("bg-info"); //카드배경색  클래스 이건 부트스트랩 찾아서 넣어야함
                    $rowDiv.append(card);
                });
            }
        });
    }

    function clickReceiptEditBtn() {
        let $myModal = $("#myModal");
        $myModal.modal(true);
        let $btnConfirm = $myModal.find("#btn_modal_left");

        let $btnCancel = $myModal.find("#btn_modal_right");
        $btnCancel.html("닫기"); //우측 밑의 닫기버튼 글자 변경


        //직접 설정해야 하는 것들
        $btnConfirm.html("수정"); //저장 버튼 글자 변경
        $btnConfirm.off();
        $btnConfirm.on("click", editReceiptFunction); //저장 버튼 눌렀을때 실행될 함수

        $("#div_modal_body").load("rctModifyBody.do");

        let jsoned = {};
        jsoned.selectedString = ""; //키값을 찾아 직접하시오
        let value = ($(this).parent()).find("input[name=cardTag]").val();
        console.log("value : " + value);
        jsoned.selectedString = value;

        $.ajax({
            url : "rctCardGet.do",
            data : jsoned,
            datatype : "json",
            async : false,
            success : function() {
                $("#div_modal_body").load("rctGet.do"); //컨트롤러 경로;
            }
        });

        $("#modal_head").html("영수증 수정"); //Modal 의 윗부분 제목에 들어갈 글자
    }

    function editReceiptFunction() {
        let json = {};
        json.title = $("#rcttitle").val();
        json.place = $("#place").val()
        json.stuff = $("#stuff").val();
        json.total = $("#total").val();
        json.note = $("#note").val();
        json.img = $("img").val();
        json.rtcdate = $("#rtcdate").val();

        $.ajax({
            url : "rctUpdate.do",
            type : "POST",
            contentType : "application/x-www-form-urlencoded; charset=utf-8",
            data : json,
            datatype : "json",
            success : function(data) {
                let json = JSON.parse(data);
                if (json.result != 0) {
                    alert("수정 완료!");
                    $("#divBody").load("toHome.do");
                } else {
                    alert("수정을 실패했습니다. 다시 작성 해주세요.");
                }
            }
        });
    }

    function clickReceiptRemoveBtn() {
        let json = {};
        let value = ($(this).parent()).find("input[name=cardTag]").val();
        json.selectedString = value;
        $.ajax({
            url:"rctDelete.do",
            type:"POST",
            data:json,
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            success: function(data) {
                if( data == "true") {
                    alert("내용 삭제 되었습니다.");
                    $("#divBody").load("toHome.do");
                } else {
                    alert("내용 삭제에 실패하였습니다.");
                }
            }
        });
    }

    function getAddrData(){
        $.ajax({
            type : "POST",
            url : "aSelectall.do", //여기에 각자의 ajax 결과값을 보낼 controller를 연결
            success : function(data){
                let list = JSON.parse(data).list;
                $.each(list, function(index, item){
                    let card = $('<ct:card />'); //여기의 각자의 커스텀 태그를 입력
                    card.find("button[name=btnEdit]").on("click", clickAddrEditBtn);
                    card.find("button[name=btnRemove]").on("click",clickAddrRemoveBtn);
                    var i = index+1;
                    card.find("input[name=cardTag]").val(item.aindex);

                    //여기부터 card에 들어갈 값을 입력
                    card.find("#title").html(item.aname);
                    card.find("#smallText").html(item.aphone);
                    card.find("#card_body").addClass("bg-primary"); //카드배경색  클래스 이건 부트스트랩 찾아서 넣어야함
                    $rowDiv.append(card);
                });
            }
        });
    }

    function clickAddrEditBtn(){
        let $myModal = $("#myModal");
        $myModal.modal("show");
        let $btnConfirm =  $myModal.find("#btn_modal_left");


        let $btnCancel =  $myModal.find("#btn_modal_right");
        $btnCancel.html("닫기"); //우측 밑의 닫기버튼 글자 변경


        //직접 설정해야 하는 것들
        $btnConfirm.html("저장"); //저장 버튼 글자 변경
        $btnConfirm.off();
        $btnConfirm.on("click", editAddrFunction); //저장 버튼 눌렀을때 실행될 함수

        let jsoned = {};
        jsoned.selectedString="";
        let value = ($(this).parent()).find("input[name=cardTag]").val();
        jsoned.selectedString = value;

        $.ajax({
            url: "addkey.do",
            data : jsoned,
            datatype : "json",
            async : false,
            success : function(){
                $("#div_modal_body").load("addoneselect.do");
            }
        });
    }

    function editAddrFunction(){
        let json ={};
        json.aname = $("#aname").val();
        json.agender = $("#agender").val();
        json.abirth = $("#abirth").val();
        json.address = $("#address").val();
        json.aphone = $("#aphone").val();
        json.aemaile = $("#aemaile").val();
        json.acompany = $("#acompany").val();
        json.grade = $("#grade").val();
        json.adate = $("#adate").val();
        json.amemo = $("#amemo").html();



        $.ajax({
            url:"addUpdate.do" ,
            type:"POST",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: json,
            datatype:"json",
            success: function(data) {
                let json = JSON.parse(data);
                console.log("여기확인 : "+json.result);
                if(json.result != "0") {
                    alert("내용이 수정되었습니다.");
                    $("#divBody").load("toHome.do");
                }else{
                    alert("내용 수정에 실패하였습니다.");
                }
            }
        });
    }

    function clickAddrRemoveBtn(){
        let json = {};
        let value = ($(this).parent()).find("input[name=cardTag]").val();
        json.adelete = value;
        $.ajax({
            url:"adddelete.do",
            type:"POST",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: json,
            datatype:"json",
            success: function(data) {
                let json = JSON.parse(data);
                if(json.result != "0") {
                    alert("카드가 삭제되었습니다.");
                    $("#divBody").load("toHome.do");

                }else{
                    alert("삭제가 실패하였습니다.");
                }
            }
        });
    }






</script>
<div class="container-fluid">
    <div id="con">

    </div>
    <div class="pt-5 pb-5 mt-5 mb-5"></div>


</div>