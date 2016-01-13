<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/js/common.jsp"%><!-- 必须引入commo -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<%=contextPath%>/js/candidateChoose.js" ></script>
<script type="text/javascript">
	function test() {
		alert(nextAssignee);
	}
</script>
</head>
<body>
	<h1>这里放dialog</h1>
	<input type="button" onclick="chooseAssignee()" value="按钮">
	<input type="button" onclick="test()" value="test">
	<div id="choiceBox"></div>
</body>
</html>