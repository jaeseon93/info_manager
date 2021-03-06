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
					var addoption = $("<option>"+ data.total + "</option>")
					$("#dtlist").append(addoption);
					var addoption = $("<option>" + data.place + "</option>")
					$("#dtlist").append(addoption);
				$("#total").val(data.total);
				$("#place").val(data.place);
				
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
					alert("????????? ?????????????????????.");
				}else{
					alert("?????? ????????? ?????????????????????.");  
				}
			 }
		});
	}
</script>
</head>
<body>
<datalist id="dtlist"></datalist>
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
						<h4 class="modal-title">????????? ??????</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- Modal body -->
					<div class="modal-body">
					<form id="frm" name="frm" method="post" action="${pageContext.request.contextPath}/rctInsert.do" enctype="multipart/form-data">
							<div class="row">
								<div class="col-md-4">
									<label for="rctdate"> ??? ??? </label>
									<div>
										<input type="date" id="rctdate" name="rctdate" class="form-control input">
									</div>
									<label for="title"> ??? ??? </label>
									<div>
										<input type="text" id="title" name="title"
											class="form-control input" placeholder="????????? ???????????????">
									</div>
									<label> ????????? ?????? </label>
									<div>
										<input type="file" id="img" name="img">
										<button type="button" class="btn btn-bg-defualt" id="scan" name="scan">??????</button>
									</div>
								</div>
								<div class="col-md-8">
									<div class="border">
										<div class="row">
											<div class="col-md-3">
												<div class="label">
													<label for="place"> ????????? </label>
												</div>
											</div>
											<div class="col-md-8">
												<div class="padding">
													<input type="text" class="form-control input" id="place" name="place" list="dtlist">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-3">
												<div class="label">
													<label for="stuff"> ??? ??? </label>
												</div>
											</div>
											<div class="col-md-8">
												<div class="padding">
													<select class="form-control input" id="stuff" name="stuff">
														<option>--??????--</option>
														<option value="????????????">????????????</option>
														<option value="??????">??????</option>
														<option value="?????????">?????????</option>
														<option value="??????">??????</option>
														<option value="??????/??????">??????/??????</option>
														<option value="??????">??????</option>
														<option value="??????">??????</option>
														<option value="??????">??????</option>
													</select>
												</div>
												</div>
											</div>
										<div class="row">
											<div class="col-md-3">
												<div class="label">
													<label for="total"> ??? ?????? </label>
												</div>
											</div>
											<div class="col-md-8">
												<div class="padding">
													<input class="form-control input" id="total" name="total" list="dtlist">
														
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-3">
												<div class="label">
													<label for="note"> ?????? </label>
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
							<button type="submit" id="addrct" class="btn btn-secondary" data-dismiss="modal">??????</button>
						</div>
					</form>	
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>