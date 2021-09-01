<%--
  User: Suh
  Date: 2020-04-04
  Time: 오후 5:58
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="css/bootstrap.min.css">

    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function(){
           $(".toast").toast('show');
        });
    </script>
    <style>
        body{
            font-size: 18px;
        }
    </style>
</head>
<body>
<div aria-live="polite" aria-atomic="true" class="d-flex justify-content-center align-items-center" style="min-height: 100%;">
    <div style="position: absolute; width: 100%; height: 100%; background-color: black; opacity: 0.5"></div>
    <!-- Then put toasts within -->
    <div class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-autohide="false" style="min-width:50%; min-height:800px;" >

        <div class="toast-body">
            <jsp:include page="info_entire.jsp" />
        </div>
    </div>
</div>
</body>
</html>
