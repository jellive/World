<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- <option value="KOR">대한민국</option> -->
<!-- <option value="USA">쌀국</option> -->
<!-- <option value="JPN">쪽국</option> -->
<option value="">이제 골라라!</option>
<c:forEach var="district" items="${districts}">
	<option value="${district}">${district}</option>

</c:forEach>