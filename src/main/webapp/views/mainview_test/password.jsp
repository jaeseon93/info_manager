<%@ page import="co.yedam.ic.common.Strings" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ct" tagdir="/WEB-INF/tags"%>

<style>
.modal-header { background-color: #D3D3D3}
.modal-footer button { 
	background-color: #696969;
	border: 1px solid #696969;
}
</style>
<script>
	

	$(function(){
		getCardData();
		$("#btnToggleModal").bind("click", clickAddBtn );
		$("body").append($("<button class='btn' hidden id='btnClip' data-clipboard-text='text'>버튼버튼버튼</button>"));
		new ClipboardJS('#btnClip');
	});
	
	function clickAddBtn(){
		let $myModal = $("#myModal");
		$myModal.modal(true);
		let $btnConfirm =  $myModal.find("#btn_modal_left");


		let $btnCancel =  $myModal.find("#btn_modal_right");
		$btnCancel.html("닫기"); //우측 밑의 닫기버튼 글자 변경


		//직접 설정해야 하는 것들
		$btnConfirm.html("추가"); //저장 버튼 글자 변경
		$btnConfirm.off()
		$btnConfirm.on("click", addFunction);
		console.log("#div_modal_body");
		$("#div_modal_body").load("pwInsertBody.do"); //컨트롤러 경로;
		$("#modal_head").html("비밀번호 추가"); //Modal 의 윗부분 제목에 들어갈 글자
	}

	function addFunction(){
		let json = {};
		json.url = $("#url").val();
		json.sitename = $("#sitename").val();
		json.siteid = $("#siteid").val();
		json.sitepw = $("#sitepw").val();
		json.note = $("#note").val();

		$.ajax({
			url:"insertpw.do",
			type:"POST",
			contentType: "application/x-www-form-urlencoded; charset=utf-8",
			data: json,
			datatype:"json",
			success: function(data) {
				let json = JSON.parse(data);
				if(json.result) {
					alert("내용이 추가되었습니다.");
					closeModal();
					$("#divBody").load("toPassword.do");
				}else{
					alert("내용 추가에 실패하였습니다.");
				}
			}
		});
	}

	function clickRemoveBtn(){
    	let json = {};
    	let value = ($(this).parent()).find("input[name=cardTag]").val();
    	json.pdelete = value;
		//ajax를 이용해 삭제
		$.ajax({
			url:"deletepw.do",
			type:"POST",
			contentType: "application/x-www-form-urlencoded; charset=utf-8",
			data: json,
			datatype:"json",
			success: function(data) {
				if( data == "true") {
					alert("삭제 되었습니다.");
					 $("#divBody").load("toPassword.do");
				} else {
					alert("삭제에 실패하였습니다.");
				}
			}
		});
	}

	function clickEditBtn(){
		let $myModal = $("#myModal");
		$myModal.modal(true);
		let $btnConfirm =  $myModal.find("#btn_modal_left");


		let $btnCancel =  $myModal.find("#btn_modal_right");
		$btnCancel.html("닫기"); //우측 밑의 닫기버튼 글자 변경


		//직접 설정해야 하는 것들
		$btnConfirm.html("수정"); //저장 버튼 글자 변경
		$btnConfirm.off();
		$btnConfirm.on("click", editFunction); //저장 버튼 눌렀을때 실행될 함수


		let jsoned = {};
		jsoned.selectedString = ""; //키값을 찾아 직접하시오
		let value = ($(this).parent()).find("input[name=cardTag]").val();
		console.log("value : "+ value);
		jsoned.selectedString = value;
		$.ajax({
			url : "pwselected.do",
			data : jsoned,
			datatype : "json",
			async : false,
			success : function(){
				$("#div_modal_body").load("pwselect.do"); //컨트롤러 경로;
			}
		});

		$("#modal_head").html("비밀번호 수정"); //Modal 의 윗부분 제목에 들어갈 글자
	}

	function editFunction(){
		let json = {};
		json.url = $("#url").val();
		json.sitename = $("#sitename").val();
		json.siteid = $("#siteid").val();
		json.sitepw = $("#sitepw").val();
		json.note = $("#note").val();
		$.ajax({
			url:"updatepw.do",
			type:"POST",
			contentType: "application/x-www-form-urlencoded; charset=utf-8",
			data: json,
			datatype:"json",
			success: function(data) {
				let json = JSON.parse(data);
				if(json.result) {
					alert("수정이 완료되었습니다.");
					$("#divBody").load("toPassword.do");
				}else{
					alert("수정에 실패하였습니다.");
				}
			}
		});
	}

	function clickGoBtn() {

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
				$("#btnClip").attr("data-clipboard-text", data);
				$("#btnClip").trigger("click");
				console.log("hahahahoho");

				if ( sub == "http://" || sub == "https:/" ) {
					window.open(url, '_blank'); 
				} else {
					window.open( "http://"+url, '_blank'); 
				}
			}
		});
	}
	
	
	function getCardData(){
		$.ajax({
			type : "post",
			url : "pwHome.do", //여기에 각자의 ajax 결과값을 보낼 controller를 연결
			success : function(data){
				let list = JSON.parse(data).list;
				
				let $rowDiv = $("<div>");
				$("#con").append($rowDiv);
				$rowDiv.addClass("row");
				$.each(list, function(index, item){

					let card = $('<ct:pwCard />'); //여기의 각자의 커스텀 태그를 입력
					card.find("button[name=btnEdit]").bind("click", clickEditBtn);
					card.find("button[name=btnRemove]").bind("click", clickRemoveBtn);
					card.find("button[name=btnGo]").bind("click", clickGoBtn);
					var i = index+1;
					card.find("input[name=cardTag]").val( item.cardKey );
					
					//여기부터 card에 들어갈 값을 입력
					card.find("#title").html(item.sitename);
					card.find("#smallText").html(item.url);
					card.find("#card_body").addClass("bg-secondary"); //카드배경색  클래스 이건 부트스트랩 찾아서 넣어야함
					$rowDiv.append(card);
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
