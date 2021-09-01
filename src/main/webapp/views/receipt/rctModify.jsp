<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<style>
.border {
	border-left-style: 10px solid black;
}

.input {
	width: 70%;
}

.label {
	text-align: center;
	padding-top: 23px;
	padding-left: 10px;
}

.padding {
	padding-top: 17px;
}
</style>
<script>
	$(function() {
		$("#modifyrct").bind("click", getrct);
	});

	function getrct() {
		let json = {};
		json.title = $("#title").val();
		json.place = $("#place").val()
		json.stuff = $("#stuff").val();
		json.total = $("#total").val();
		json.note = $("#note").val();
		json.img = $("img").val();
		json.rtcdate = $("#rtcdate").val();

		$.ajax({
			url : "../../rctUpdate.do",
			type : "POST",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : json,
			datatype : "json",
			success : function(data) {
				let json = JSON.parse(data);
				if (json.result) {
					alert("수정 완료!");
				} else {
					alert("수정을 실패했습니다. 다시 작성 해주세요.");
				}
			}
		});
	}
</script>
</head>
<body>
	<div class="container">
		<h2>Extra Large Modal</h2>
		<!-- Button to Open the Modal -->
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#myModal">Open modal</button>

		<!-- The Modal -->
		<div class="modal fade" id="myModal">
			<div class="modal-dialog modal-xl">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">영수증 수정</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- Modal body -->
					<div class="modal-body">
						<form id="frm" name="frm" action="rctUpdate.do" method="post"
							enctype="multipart/form-data">
							<div class="row">
								<div class="col-md-4">
									<label for="rctdate"> 날 짜 </label>
									<div>
										<input type="date" id="rctdate" name="rctdate"
											class="form-control input" value="${ select.rctdate }">
									</div>
									<label for="title"> 제 목 </label>
									<div>
										<input type="text" id="title" name="title"
											class="form-control input" value="${ select.title }">
									</div>
									<label> 영수증 첨부 </label>
									<div>
										<input type="file" id="img" name="img" disabled>
									</div>
								</div>
								<div class="col-md-8">
									<div class="border">
										<div class="row">
											<div class="col-md-2">
												<div class="label">
													<label for="place"> 상호명 </label>
												</div>
											</div>
											<div class="col-md-8">
												<div class="padding">
													<input type="text" id="place" name="place"
														class="form-control input" value="${ select.place }">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-2">
												<div class="label">
													<label for="stuff"> 품 명 </label>
												</div>
											</div>
											<div class="col-md-8">
												<div class="padding">
													<select class="form-control input" id="stuff" name="stuff" >
														<option>--선택--</option>
														<option value="문화생활">문화생활</option>
														<option value="미용">미용</option>
														<option value="생필품">생필품</option>
														<option value="식비">식비</option>
														<option value="의료/건강">의료/건강</option>
														<option value="의류">의류</option>
														<option value="애견">애견</option>
														<option value="기타">기타</option>
													</select>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-2">
												<div class="label">
													<label for="total"> 총 금액 </label>
												</div>
											</div>
											<div class="col-md-8">
												<div class="padding">
													<input type="text" id="total" name="total"
														class="form-control input" value="${ select.total }">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-2">
												<div class="label">
													<label for="note"> 메모 </label>
												</div>
											</div>
											<div class="col-md-8">
												<div class="padding">
													<div class="form-group">
														<textarea class="form-control" rows="5" id="note"
															name="note" value="${ select.note }"></textarea>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<!-- Modal footer -->
							<div class="modal-footer">
								<button type="submit" id="modifyrct" class="btn btn-secondary">저장</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
