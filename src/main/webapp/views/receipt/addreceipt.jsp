<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		$("#addrct").bind("click",rctInsert);
		$("#scan").bind("click",rctScan);
	});
	
	function rctScan() {
		var form = jQuery("#frm")[0];
		var fileData = new FormData(form);
		fileData.append("img", jQuery("#img")[0]);
		
		$.ajax({
			url:"../../fileUpload.do",
			type:"POST",
			 data: fileData,
			 processData : false,
	         contentType : false,
			 dataType:"json",
			 success: function(data) {
				 console.log(data)
				var list = $("<datalist id='dtlist'>")
				for(i=0; i<data.length; i++) {
					var addoption = $("<option>" + data[i] + "</option>")
					list.append(addoption);
				}
				$("#place").attr('list','dtlist')
				
			 }
		});
		
	}
	
	function rctInsert() {
		var form = jQuery("#frm")[0];
		var fileData = new FormData(form);
		fileData.append("title", $("#title").val());
		fileData.append("palce", $("#place").val());
		fileData.append("stuff", $("#stuff").val());
		fileData.append("total", $("#total").val());
		fileData.append("note", $("#note").val());
		fileData.append("img", jQuery("#img")[0]);
		fileData.append("rctdate", $("#rctdate").val());
		
		
		$.ajax({
			url:"../../rctInsert.do",
			type:"POST",
			 data: fileData,
			 processData : false,
	         contentType : false,
			 dataType:"json",
			 success: function(data) {
				 console.log(data);
				if(data.result == 1) {
					alert("내용이 추가되었습니다.");
				}else{
					alert("내용 추가에 실패하였습니다.");  
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
			<div class="modal-dialog modal-lg">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">영수증 추가</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- Modal body -->
					<div class="modal-body">
					<form id="frm" name="frm" method="post" action="${pageContext.request.contextPath}/rctInsert.do" enctype="multipart/form-data">
							<div class="row">
								<div class="col-md-4">
									<label for="rctdate"> 날 짜 </label>
									<div>
										<input type="date" id="rctdate" name="rctdate" class="form-control input">
									</div>
									<label for="title"> 제 목 </label>
									<div>
										<input type="text" id="title" name="title"
											class="form-control input" placeholder="제목을 입력하세요">
									</div>
									<label> 영수증 첨부 </label>
									<div>
										<input type="file" id="img" name="img">
										<button type="button" class="btn btn-bg-defualt" id="scan" name="scan">스캔</button>
									</div>
								</div>
								<div class="col-md-8">
									<div class="border">
										<div class="row">
											<div class="col-md-3">
												<div class="label">
													<label for="place"> 상호명 </label>
												</div>
											</div>
											<div class="col-md-8">
												<div class="padding">
													<input type="button" class="form-control input" id="place" name="place">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-3">
												<div class="label">
													<label for="stuff"> 품 명 </label>
												</div>
											</div>
											<div class="col-md-8">
												<div class="padding">
													<select class="form-control input" id="stuff" name="stuff">
														<option>--선택--</option>
														<option>2</option>
														<option>3</option>
														<option>4</option>
													</select>
												</div>
												<div class="form-check-inline ">
													<label class="form-check-label"> <input
														type="checkbox" class="form-check-input" value="etc">그
														외
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-3">
												<div class="label">
													<label for="total"> 총 금액 </label>
												</div>
											</div>
											<div class="col-md-8">
												<div class="padding">
													<select class="form-control input" id="total" name="total">
														<option>--선택--</option>
														<option>2</option>
														<option>3</option>
														<option>4</option>
													</select>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-3">
												<div class="label">
													<label for="note"> 메모 </label>
												</div>
											</div>
											<div class="col-md-8">
												<div class="padding">
													<div class="form-group">
														<textarea class="form-control" rows="5" id="note" name="note"></textarea>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						
						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="submit" id="addrct" class="btn btn-secondary" data-dismiss="modal">저장</button>
						</div>
					</form>	
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
