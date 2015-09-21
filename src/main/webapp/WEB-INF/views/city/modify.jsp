<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>register.jsp</title>
</head>
<body>
	<h1>CityCommand</h1>
	<form:form commandName="city">
		<!-- 이게 있어야 에러 메세지가 출력 됨... -->
		<ul>
			<%-- 		<li>${cityCommand.name }</li> --%>
			<%-- 		<li>${cityCommand.countryCode }</li> --%>
			<%-- 		<li>${cityCommand.district }</li> --%>
			<%-- 		<li>${cityCommand.population }</li> --%>

			<li>${city.name }<form:errors path="name" cssStyle="color: red;" /></li>
			<li>${city.countryCode }<form:errors path="countryCode"
					cssStyle="color: red;" /></li>
			<li>${city.district }<form:errors path="district"
					cssStyle="color: red;" /></li>
			<li>${city.population }<form:errors path="population"
					cssStyle="color: red;" />
			</li>
		</ul>
	</form:form>
</body>
</html>