<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="titles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="ct" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport"
		  content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>App</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
	<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/popper.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/member_info.js"></script>
	<script src="${pageContext.request.contextPath}/js/common.js"></script>
	<script src="${pageContext.request.contextPath}/js/clipboard.js"></script>
	<link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js" crossorigin="anonymous"></script>
</head>
<style>
	#divSide{
		margin-top : 3.5em;
		position:fixed;
	}
	#divBody{
		margin-top : 4.5em;
		margin-left : 14em;
	}
	#btnToggleModal{
		position : fixed;
		bottom : 2em;
		right : 2em;

	}
	.modal-body {
		position: relative;
		overflow-y: auto;
	}
</style>
<body>
<div class="container-fluid p-0">
	<div class="row no-gutters">
		<!-- header div -->
		<div class="col-12 fixed-top">
			<tiles:insertAttribute name="header" />
		</div>
		<!-- header div end -->
	</div>
	<div class="row no-gutters">
		<!-- left div -->
		<div class="col-2" id="divSide">
			<tiles:insertAttribute name="side" />
		</div>
		<!-- left div end -->
		<!-- right div -->
		<div class="col-10" id="divBody">
			<titles:insertAttribute name="body" />
		</div>
		<!-- right div end -->
	</div>
	<div class="row">
		<ct:modal />
	</div>

</div>
</body>
</html>