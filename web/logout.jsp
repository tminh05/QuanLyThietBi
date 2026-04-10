<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.removeAttribute("user"); 
    response.sendRedirect("index.jsp"); 
%>