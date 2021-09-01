<%@ page import="co.yedam.ic.common.Strings" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ct" tagdir="/WEB-INF/tags"%>
<script>
    $(function(){
        getCardData();
        $("#btnToggleModal").bind("click", clickAddBtn );
    });
    function clickAddBtn(){
        let $myModal = $("#myModal");
        $myModal.modal("show");
        let $btnConfirm =  $myModal.find("#btn_modal_left");


        let $btnCancel =  $myModal.find("#btn_modal_right");
        $btnCancel.html("닫기"); //우측 밑의 닫기버튼 글자 변경

        //직접 설정해야 하는 것들
        $btnConfirm.html("저장"); //저장 버튼 글자 변경
        $btnConfirm.off();
        $btnConfirm.on("click", addFunction );
        console.log("#div_modal_body");
        $("#div_modal_body").load("noteinsertbody.do"); //컨트롤러 경로;
        $("#modal_head").html("NOTE"); //Modal 의 윗부분 제목에 들어갈 글자
    }

    function addFunction(){
        let json = {};
        json.title = $("#ntitle").val();
        //console.log($("#title").val());
        //console.log($("#ncontent").val);
        json.ncontent = $("#ncontent").val();

        $.ajax({
            url:"NoteInsert.do",
            type:"POST",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: json,
            datatype:"json",
            success: function(data) {
                let json = JSON.parse(data);
                if(json.result) {
                    alert("내용이 추가되었습니다.");
                    closeModal();
                    $("#divBody").load("toNote.do");
                }else{
                    alert("내용 추가에 실패하였습니다.");
                }
            }
        });
    }

    function clickRemoveBtn(){
    	let json = {};
    	let value = ($(this).parent()).find("input[name=cardTag]").val();
    	json.ndelete = value;
         $.ajax({
        	 
             url:"notedelete.do",
             type:"POST",
             contentType: "application/x-www-form-urlencoded; charset=utf-8",
             data: json,
             datatype:"json",
             success: function(data) {
             	console.log(data);
                 let json = JSON.parse(data);
                 console.log("여기확인 : "+json.result);
                 if(json.result != "0") {
                     alert("카드가 삭제되었습니다.");
                     $("#divBody").load("toNote.do");
 					
                 }else{
                     alert("삭제가 실패하였습니다.");
                 }
             }
         });
      
    }

    function clickEditBtn(){
        let $myModal = $("#myModal");
        $myModal.modal("show");
        let $btnConfirm =  $myModal.find("#btn_modal_left");


        let $btnCancel =  $myModal.find("#btn_modal_right");
        $btnCancel.html("닫기"); //우측 밑의 닫기버튼 글자 변경


        //직접 설정해야 하는 것들
        $btnConfirm.html("수정"); //저장 버튼 글자 변경
        $btnConfirm.off();
        $btnConfirm.on("click", editFunction);
        
        let jsoned = {};
        jsoned.selectedString = "";
        let value = ($(this).parent()).find("input[name=cardTag]").val();
        console.log("value:"+value);
        jsoned.selectedString = value;
        
        $.ajax({
        	url: "noselected.do",
        	data : jsoned,
        	datatype : "json",
        	async : false,
        	success : function(){
        		$("#div_modal_body").load("noteoneselect.do");
        	}
        		
        });
        $("#modal_head").html("note수정");
        // 저장 버튼 눌렀을때 실행될 함수
       // console.log("#div_modal_body");
     //  $("#div_modal_body").load("noteoneselect.do"); //컨트롤러 경로;
     //  $("#modal_head").html("제목입니다"); //Modal 의 윗부분 제목에 들어갈 글자
    }

    function editFunction(){
        let json = {};
        json.title = $("#ntitle").val();
        json.ncontent = $("#ncontent").val();
        $.ajax({
            url:"NoteUpdate.do",
            type:"POST",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: json,
            datatype:"json",
            success: function(data) {
            	console.log(data);
                let json = JSON.parse(data);
                console.log("여기확인 : "+json.result);
                if(json.result != "0") {
                    alert("내용이 수정되었습니다.");
                    $("#divBody").load("toNote.do");
                }else{
                    alert("수정에 실패하였습니다.");
                }
            }
        });
    }

    function getCardData(){
    	
        $.ajax({
            type : "post",
            url : "NoteSelect.do", //여기에 각자의 ajax 결과값을 보낼 controller를 연결
            success : function(data){
                let list = JSON.parse(data).list;
                let $div = $("<div>");
                $("#con").append($div);

                $.each(list, function(index, item){
                	console.log(item);
                    if(index%3 == 0){
                        $div.addClass("row");
                    }
                    let card = $('<ct:card />'); //여기의 각자의 커스텀 태그를 입력
                    card.find("button[name=btnEdit]").bind("click", clickEditBtn);
                    card.find("button[name=btnRemove]").bind("click",clickRemoveBtn);
					var i = index+1;
					card.find("input[name=cardTag]").val(item.index);
                    //여기부터 card에 들어갈 값을 입력
                    console.log(item.index);
                    card.find("#title").html(item.title);
                    card.find("#smallText").html(item.ncontent);
                    card.find("#card_body").addClass("bg-danger"); //카드배경색  클래스 이건 부트스트랩 찾아서 넣어야함
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
        <div class="col-12">
            <button id="btnToggleModal" type="button" class="btn1 btn-danger rounded-circle btn-lg">+</button>
        </div>
    </div>
</div>
