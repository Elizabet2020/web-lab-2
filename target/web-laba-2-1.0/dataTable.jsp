<%@ page import="table.TableRow" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Лиза
  Date: 22.02.2021
  Time: 13:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        <%@include file='css/style.css' %>
    </style>
</head>
<body>
<table>
    <tr id="tHeader">
        <th>X</th>
        <th>Y</th>
        <th>R</th>
        <th>Result</th>
        <th>Time</th>
        <th>Code running time (ns)</th>
    </tr>
    <%
        List table = (List) session.getAttribute("data");
        if (table != null) {
            for (Object row: table) {
    %>
    <%=
    String.format(
            "<tr>" +
                    "<th>%s</th>" +
                    "<th>%s</th>" +
                    "<th>%s</th>" +
                    "<th>%s</th>" +
                    "<th>%s</th>" +
                    "<th>%s</th>" +
                    "</tr>",
            ((TableRow) row).X,
            ((TableRow) row).Y,
            ((TableRow) row).R,
            ((TableRow) row).result,
            ((TableRow) row).dateTime,
            ((TableRow) row).executionTime
    )
    %>
    <%
            }
        }
    %>
</table>
</body>
</html>