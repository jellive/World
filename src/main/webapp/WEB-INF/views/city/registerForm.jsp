<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>registerForm.jsp</title>
<%@ include file="/WEB-INF/views/common.jspf"%>

<style type="text/css">
.form-center {
	border: 1px solid red;
	border-radius: 10px;
	width: 400px;
	padding: 10px;
	margin-left: 50px;
	width: 400px;
	background-color: #FFE5E5;
}

.box {
	width: 100px;
	height: 100px;
	border-radius: 10px;
	background-color: orange;
}
</style>
<!-- margin을 auto로 주면 자동으로 중앙에 위치하게 된다. -->
<!-- border-radius는 각을 둥글게 변환해준다. 단위는 반지름 크기. -->
</head>
<body>
	<!-- label.properties파일 참고! -->
	<h1>
		<spring:message code="city.register.title" arguments="[World]" />
	</h1>
	<!-- form:form은 form형을 자동으로 만들어 준다. -->
	<form:form commandName="city" action="register" method="post"
		cssClass="form-center">

		<!-- Global Error -->
		<div class="text-danger text-center">
			<form:errors />
			<!-- 그냥 요거만 쓰면 Global Error를 다 출력함. Global Error는 path를 안 준 것.-->
		</div>

		<!-- city.name -->
		<div class="form-group">
			<!-- commandName은 form의 id를 바꿔준당! -->
			<!-- method는 기본이 post임...굳이 안 줘도 댐. -->
			<!-- form-group은 하나로 묶어서 margin을 띄워놓는 등 그룹화 한다. -->
			<label for="name"><spring:message code="city.name" /></label> :
			<form:input path="name" cssClass="form-control" />
			<!-- path를 채우면 id, name을 다 채워준당! 그리고 안에 보면 value가 있는데, query-string으로 보낸 걸 여기서 읽을 수 있다. attribute를 사용하면 쓸 만 할듯?-->
			<!-- cssClass가 중요. spring custom tag에서 bootstrap등 외부 css를 쓰려면 cssClass를 쓴다. -->
			<form:errors path="name" cssClass="text-primary bg-danger" />
		</div>

		<!-- city.countryCode -->
		<div class="form-group">
			<label for="countryCode"><spring:message
					code="city.countryCode" /></label> :
			<%-- 			<form:input path="countryCode" cssClass="form-control" /> --%>
			<form:select path="countryCode" cssClass="form-control">
				<%-- 				<form:option value="KOR">대한민국</form:option> --%>
				<%-- 				<form:option value="USA">쌀국</form:option> --%>
				<%-- 				<form:option value="JPN">일본</form:option> --%>
				<%-- 				<form:option value="CHN">가운데나라</form:option> --%>
				<form:option value="">-- 선택하세요 --</form:option>
				<form:options items="${countryCode}" itemValue="code"
					itemLabel="name" />
			</form:select>
			<form:errors path="countryCode" cssClass="text-primary bg-danger" />
		</div>

		<!-- city.district -->
		<div class="form-group">
			<label for="district"><spring:message code="city.district" /></label>
			:
			<%-- 			<form:input path="district" cssClass="form-control" /> --%>
			<form:select path="district" cssClass="form-control">
				<form:option value="">--나라부터 골라보지 않으련? --</form:option>
				<form:options items="${districts}"/>
			</form:select>
			<form:errors path="district" cssClass="text-primary bg-danger" />
		</div>

		<!-- city.population -->
		<div class="form-group">
			<label for="population"><spring:message
					code="city.population" /></label> :
			<form:input path="population" cssClass="form-control" />
			<form:errors path="population" cssClass="text-primary bg-danger" />
			<!-- errors는 path이름에 관계된 error가 뜨면 여기에 출력해준다.(properties참고. -->
		</div>

		<!-- Submit -->
		<input class="btn btn-primary" type="submit" value="도시추가" />
	</form:form>

	<c:forEach var="i" begin="0" end="10">
		<div class="box">
			<strong>${i}</strong>
		</div>
	</c:forEach>

	<script type="text/javascript">
		var form = jQuery('.form-center');
		form.draggable();
		form.mousedown(function() {
			console.log("form.mousedown()...");
			$(this).css('box-shadow', '20px 20px 10px purple');
		});
	<%-- 클릭하면 뒤에 그림자가 나옴. --%>
		form.mouseup(function() {
			console.log("form.mouseup()...");
			$(this).css('box-shadow', '');
		});

		jQuery('.box').draggable();
	<%-- jQuery가 찾아줌. 위의 CSS를 jQuery가 만들어줌. --%>
		$('#countryCode').change(function() {
			var countryCode = $(this).val();
			console.log("change event called... value = " + countryCode);
			
			// Ajax (Asyncronous JavaScript And Xml)
			$.get('district/' + countryCode, function(data, status) {
				console.log("data=" + data + "\n" + "status=" + status);
			$('#district').html(data);
			});
	<%-- PathVariable로 받아들이기 위해.. $.get을 jQuery의 전역 변수라 한다.  --%>
		});
	</script>

</body>
</html>