<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <style>
        table, tr ,td { border : 1px solid black }
        body{
            background-color : aqua;
        }
    </style>
</head>
<body>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<table>
    <tr>
        <td colspan="2">
            <tiles:insertAttribute name="header" />
        </td>
    </tr>
    <tr>
        <td>
            <tiles:insertAttribute name="menu" />
        </td>
        <td>
            <tiles:insertAttribute name="body" />
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <tiles:insertAttribute name="footer" />
        </td>
    </tr>
</table>

</body>
</html>
