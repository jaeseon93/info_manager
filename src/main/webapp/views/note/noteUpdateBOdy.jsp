<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
        <div class="modal-body">
		 <div class="container">
			<div class="row">
				<div class="col-md-12">					
					 <div class="form-group"><label>제목</label><br>
     					 <input type="text" class="form-control" name="ntitle" id="ntitle" value="${ selectone.title}">
    				</div>
						
					<div class="form-group">
  						<label for="comment">memo</label>
  						<textarea class="form-control" rows="10" id="ncontent" name = "ncontent">${selectone.ncontent}</textarea>
					</div>
				
				</div>
				
			</div> <!-- END = div class="row" -->
		</div> <!-- END = div class="container" -->
      </div> <!-- END = div class="modal-body" -->
    
      
      
</body>
</html>