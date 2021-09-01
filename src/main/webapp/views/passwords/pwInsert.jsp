<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<title>pwInsert.jsp</title>
<style>
.modal-header { background-color: #D3D3D3}
.modal-footer button { 
	background-color: #696969;
	border: 1px solid #696969;
}
</style>
<script>
 	$(function() {
 		$("#btnInsert").bind("click",getInsert);
 	});
 	
 	function getInsert() {
 		let json = {};
 		json.url = $("#url").val();
 		json.sitename = $("#sitename").val();
 		json.siteid = $("#siteid").val();
		json.sitepw = $("#sitepw").val();
		json.note = $("#note").val();
		
		$.ajax({
			url:"../../insertpw.do",
			type:"POST",
			contentType: "application/x-www-form-urlencoded; charset=utf-8",
			 data: json,
			 datatype:"json",
			 success: function(data) {
				let json = JSON.parse(data);
				if(json.result) {
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
  <h2>Passwords Test</h2>
  <!-- Button to Open the Modal -->
  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
    Open modal
  </button>

  <!-- The Modal -->
  <div class="modal" id="myModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Passwords 추가</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
		 <div class="container">
			<div class="row">
				<div class="col-md-6">
					<div><label>URL :</label><br>
					<input class="input" type="text" id="url" name="url" size="40">
					</div><br>
					<div><label>아이디 :</label><br>
					<input class="input" type="text" id="siteid" name="siteid" size="40">
					</div><br>	
					<div><label>메모 :</label><br>
					<textarea id="note" name="note" style="height:200px; width:370px"></textarea>
					</div><br>	
				</div>
				<div class="col-md-6" id="div2">
				 	<div><label>사이트명 :</label><br>
					<input class="input" type="text" id="sitename" name="sitename" size="40">
					</div><br>	
					<div><label>패스워드 :</label><br>
					<input class="input" type="text" id="sitepw" name="sitepw" size="40">
					</div><br>
				</div>
			</div> <!-- END = div class="row" -->
		</div> <!-- END = div class="container" -->
      </div> <!-- END = div class="modal-body" -->
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" id="btnInsert" data-dismiss="modal">추가</button> <!-- 카드슬롯 화면으로돌아가기 -->
          <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
        </div>
        
    </div>
  </div>  
 </div>
</div> <!-- END = div class="container" -->
</body>
</html>