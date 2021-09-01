<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Bootstrap Example</title>
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
</head>
<body>
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
						<input type="text" id="img" name="img" value="${ select.img }" disabled>
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
							</div>${select.stuff=='식비'}
							<div class="col-md-8">
								<div class="padding">
									<select class="form-control input" id="stuff" name="stuff">
										<option>--선택--</option>
										<option value="문화생활"  <c:if test="${select.stuff=='문화생활'}" > selected </c:if>   >문화생활</option>
										<option value="미용"  <c:if test="${select.stuff=='미용'}" > selected </c:if>>미용</option>
										<option value="생필품" <c:if test="${select.stuff=='생필품'}" > selected </c:if>>생필품</option>
										<option value="식비" <c:if test="${select.stuff=='식비'}"> selected </c:if>>식비</option>
										<option value="의료/건강" <c:if test="${select.stuff=='의료/건강'}" > selected </c:if>>의료/건강</option>
										<option value="의류" <c:if test="${select.stuff=='의류'}"> selected </c:if>>의류</option>
										<option value="애견" <c:if test="${select.stuff=='애견'}" > selected </c:if>>애견</option>
										<option value="기타" <c:if test="${select.stuff=='기타'}" > selected </c:if>>기타</option>
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
										<textarea class="form-control" rows="5" id="note" name="note"
											>${ select.note }</textarea>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
</body>
</html>
