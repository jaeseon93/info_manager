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
<title>noteinsert.jsp</title>
<style>
.modal-header { background-color:  #D3D3D3}
.modal-footer button { 
	background-color: #696969;
	border: 1px solid #696969;
}
</style>
<script>
 	$(function() {
 		$("#noteupdate").bind("click",noteupdate);
 	});
 	
 	function noteupdate() {
 		let json = {};
 		json.title = $("#title").val();
		json.ncontent = $("#ncontent").val();
		
		$.ajax({
			url:"../../NoteUpdate.do",
			type:"POST",
			contentType: "application/x-www-form-urlencoded; charset=utf-8",
			 data: json,
			 datatype:"json",
			 success: function(data) {
				let json = JSON.parse(data);
				if(json.result) {
					alert("내용이 수정되었습니다.");
				}else{
					alert("내용 수정에 실패하였습니다.");  
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
					
					
					 <div class="form-group">
      					<label for="usr">제목</label>
     					 <input type="text" class="form-control" id="title" name="title">
    				</div>
					<br>	
					<div><label>내용 </label><br>
					<textarea class="form-control" rows="5" id="ncontent" name="ncontent"></textarea>
					</div><br>	
				</div>
				
			</div> <!-- END = div class="row" -->
		</div> <!-- END = div class="container" -->
        
      </div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" id="noteupdate" data-dismiss="modal">수정</button> 
          <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
        </div>
        
    </div>
  </div>  
 </div>
</div> <!-- END = div class="container" -->
</body>
</html>