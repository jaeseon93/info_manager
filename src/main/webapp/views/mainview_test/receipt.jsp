<%@ page import="co.yedam.ic.common.Strings"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="ct" tagdir="/WEB-INF/tags"%>
<script>
	$(function() {
		getCardData();
		$("#btnToggleModal").bind("click", clickAddBtn);

	});

	function clickAddBtn() {
		let $myModal = $("#myModal");
		$myModal.modal(true);
		let $btnConfirm = $myModal.find("#btn_modal_left");

		let $btnCancel = $myModal.find("#btn_modal_right");
		$btnCancel.html("닫기"); //우측 밑의 닫기버튼 글자 변경
		$("#btn_modal_close").bind("click", function(){ $myModal.modal(false) }); //우측 위 x버튼 기능을 닫기로 설정

		//직접 설정해야 하는 것들
		$btnConfirm.html("저장"); //저장 버튼 글자 변경
		$btnConfirm.off();
		$btnConfirm.on("click", addFunction);
		console.log("#div_modal_body");
		$("#div_modal_body").load("rctInsertBody.do"); //컨트롤러 경로;
		$("#modal_head").html("영수증 추가"); //Modal 의 윗부분 제목에 들어갈 글자
	}

	function addFunction() {
		var form = jQuery("#frm")[0];
		var fileData = new FormData(form);
		fileData.append("title", $("#rcttitle").val()); //기존 title에서 id이름바뀜 
		fileData.append("palce", $("#place").val());
		fileData.append("stuff", $("#stuff").val());
		fileData.append("total", $("#total").val());
		fileData.append("note", $("#note").val());
		fileData.append("img", jQuery("#img")[0]);
		fileData.append("rctdate", $("#rctdate").val());

		$.ajax({
			url : "rctInsert.do",
			type : "POST",
			data : fileData,
			processData : false,
			contentType : false,
			dataType : "json",
			success : function(data) {
				console.log(data);
				if (data.result == 1) {
					alert("내용이 추가되었습니다.");
					closeModal();
					$("#divBody").load("toReceipt.do");
				} else {
					alert("내용 추가에 실패하였습니다.");
				}
			}
		});
	}

	function clickRemoveBtn() {
		//ajax를 이용해 삭제

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
					$("#divBody").load("toReceipt.do");
				} else {
					alert("내용 삭제에 실패하였습니다.");
				}
			}
		});
	}

	function clickEditBtn() {
		let $myModal = $("#myModal");
		$myModal.modal(true);
		let $btnConfirm = $myModal.find("#btn_modal_left");

		let $btnCancel = $myModal.find("#btn_modal_right");
		$btnCancel.html("닫기"); //우측 밑의 닫기버튼 글자 변경


		//직접 설정해야 하는 것들
		$btnConfirm.html("수정"); //저장 버튼 글자 변경
		$btnConfirm.off();
		$btnConfirm.on("click", editFunction); //저장 버튼 눌렀을때 실행될 함수

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

	function editFunction() {
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
					$("#divBody").load("toReceipt.do");
				} else {
					alert("수정을 실패했습니다. 다시 작성 해주세요.");
				}
			}
		});
	}

	function getCardData() {
		$.ajax({
			type : "post",
			url : "rctCard.do", //여기에 각자의 ajax 결과값을 보낼 controller를 연결
			success : function(data) {
				let list = JSON.parse(data).list;

				let $rowDiv = $("<div>");
				$("#con").append($rowDiv);
				$rowDiv.addClass("row");
				$.each(list, function(index, item) {

					let card = $('<ct:card />'); //여기의 각자의 커스텀 태그를 입력
					card.find("button[name=btnEdit]").bind("click",
							clickEditBtn);
					card.find("button[name=btnRemove]").bind("click",
							clickRemoveBtn);
					var i = index + 1;
					console.log(index);
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
