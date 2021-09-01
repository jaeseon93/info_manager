<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
        <div class="modal-body">
		 <div class="container">
			<div class="row">
				<div class="col-sm-12">
					<div class="form-group">이름 
					<input class="form-control" type="text" id="aname" name="aname" value="${selectone.aname}" >
					</div>
				</div>
				<div class="col-sm-12">
					<div class="form-group"> 메일 
					<input class="form-control" type="text" id="aemaile" name="aemaile" size="20" value="${selectone.aemaile}">
					</div>					
				</div>		
				<div class="col-sm-12">
					<div class="form-group">연락처
					<input class="form-control" type="text" id="aphone" name="aphone" size="20" value="${selectone.aphone}">	
				</div>		
				</div>
			</div>
			<div class="row">
				<div class="col-sm-4">
					<div class="form-group">회사
					<input class="form-control" type="text" id="acompany" name="acompany" size="20" value="${selectone.acompany}">					
				</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">직책	
					<input class="form-control" type="text" id="grade" name="grade" size="20" value="${selectone.grade}">			
					</div>
				</div>	
				<div class="col-sm-4">
					<div><label>성별</label></div>
					<input class="input" type="text" id="agender" name="agender" size="20" value="${selectone.agender}">								
				</div>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<div class="form-group">나이
					<input class="form-control" type="text" id="abirth" name="abirth" size="20" value="${selectone.abirth}">								
					</div>
				</div>	
				<div class="col-sm-6">
	  				<div class="form-group">날짜
					<input class="form-control" type="date" id="adate" name="adate" size="20" value="${selectone.adate}">			
					</div>									
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<div class="form-group"> <label for="comment">주소 </label>
					<input class="form-control" type="text" id="address" name="address" size="20" value="${selectone.address}">
					</div>
				</div>
			</div>	
			<div class="row">
				<div class="col-sm-12 form-group">	
					<div class="form-group" ><label for="comment"> 메모 </label>
					<textarea class="form-control" id="amemo" name="amemo" >${selectone.amemo}"</textarea>
					</div>
				</div>
			</div> <!-- END = div class="row" -->		
		</div> <!-- END = div class="container" -->
      </div> <!-- END = div class="modal-body" -->
</body>
</html>