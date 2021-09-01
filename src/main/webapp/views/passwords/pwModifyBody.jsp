<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
        <div class="modal-body">
		 <div class="container">
			<div class="row">
				<div class="col-md-6">
					<div><label>URL :</label><br>
					<input class="input" type="text" id="url" name="url" size="40" value="${ select.url }">
					</div><br>
					<div><label>아이디 :</label><br>
					<input class="input" type="text" id="siteid" name="siteid" size="40" value="${ select.siteid }">
					</div><br>	
					<div><label>메모 :</label><br>
					<textarea id="note" name="note" style="height:200px; width:370px">${ select.note }</textarea>
					</div><br>	
				</div>
				<div class="col-md-6" id="div2">
				 	<div><label>사이트명 :</label><br>
					<input class="input" type="text" id="sitename" name="sitename" size="40" value="${ select.sitename }">
					</div><br>	
					<div><label>패스워드 :</label><br>
					<input class="input" type="text" id="sitepw" name="sitepw" size="40" value="${ select.sitepw }">
					</div><br>
				</div>
			</div> <!-- END = div class="row" -->
		</div> <!-- END = div class="container" -->       
      </div>
</body>
</html>