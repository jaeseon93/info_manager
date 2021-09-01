<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>File Upload</h1>
	<form action="../BoardInsert.do" enctype="multipart/form-data" method="post">
	제목 : <input type="text" name="title"><br>
	내용 : <input type="text" name="contents"><br>
		Select file to upload: <input type="file" multiple="multiple" name="file" size="60" /> <br />
		<!-- multiple을 사용하려면 file class를 따로 생성해주어야함 file class에는 사진을 저장할 arry 생성해서 받음 -->
		<br /> <input type="submit" value="전송" />
	</form>

</body>
</html>