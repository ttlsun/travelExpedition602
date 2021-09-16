<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var ="contextPath"  value= "<%=request.getContextPath()%>"/>
<c:set var ="css"  value= "${contextPath}/resources/css"/>
<c:set var ="js"  value= "${contextPath}/resources/js"/>
<c:set var ="image"  value= "${contextPath}/resources/images"/>
<c:set var ="fileImg"  value= "${contextPath}/resources/file_upload/"/>

