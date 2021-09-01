<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<style>
	#man, #girl{
		width : 30px;
		height : 30px;
		font-size : 20px;
	}
	label{
		font-size:20px;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
        <div class="modal-body">
		 <div class="container">
			<div class="row">
				<div class="col-sm-12">
					<div class="form-group">이름 
					<input class="form-control" type="text" id="aname" name="aname">
					</div>
				</div>
				<div class="col-sm-12">
					<div class="form-group"> 메일 
					<input class="form-control" type="text" id="aemaile" name="aemaile" size="20">
					</div>					
				</div>		
				<div class="col-sm-12">
					<div class="form-group">연락처
					<input class="form-control" type="text" id="aphone" name="aphone" size="20">	
				</div>		
				</div>
			</div>
			<div class="row">
				<div class="col-sm-4">
					<div class="form-group">회사
					<input class="form-control" type="text" id="acompany" name="acompany" size="20">					
				</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">직책	
					<input class="form-control" type="text" id="grade" name="grade" size="20">			
					</div>
				</div>	
				<div class="col-sm-4"><br>
						<label><input type="radio" name="agender"  id="man" value="man" checked="checked">남</label>
						&nbsp;
						<label><input type="radio" name="agender"  id="girl" value="girl">여</label>
											
				</div>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<div class="form-group">생년월일
					<input class="form-control" type="text" id="abirth" name="abirth" size="20">								
					</div>
				</div>	
				<div class="col-sm-6">
	  				<div class="form-group">날짜
					<input class="form-control" type="date" id="adate" name="adate" size="20">			
					</div>									
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<div class="form-group"> 주소 
					<input class="form-control" type="text" id="address" name="address" size="20">
					</div>
				</div>
			</div>	
			<div class="row">
				<div class="col-sm-12 form-group">	
					<div class="form-group" ><label for="comment"> 메모 </label>
					<textarea class="form-control" id="amemo" name="amemo" ></textarea>
					</div>
				</div>
			</div> <!-- END = div class="row" -->		
		</div> <!-- END = div class="container" -->
      </div> <!-- END = div class="modal-body" -->
</body>
</html>