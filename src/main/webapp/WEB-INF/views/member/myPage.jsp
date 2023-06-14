<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

<style>
html,
body {
    height: 100%;
    
}

.container {
    min-height: 100%;
}

.container-fluid {
	margin-top: 150px;
}

.field > input:read-only {
	background-color: #dedede;
}

</style>

<link rel="stylesheet" href="/resources/css/member/join.css">
	<div class="join-wrapper" id="wrap">
        <h2>마이페이지</h2>
        <form action="myPage" method='get'>
        	
        	<div class="field">
	            <b>아이디</b>
	            <input type="text" name="memberId" value="${member.memberId}" readonly>

	            <b>비밀번호</b>
	            <input type="password" name="memberPw" value="${member.memberPw}" readonly>

            	<b>이름</b>
            	<input type="text" name="memberName" value="${member.memberName}" readonly>

            	<b>이메일</b>
            	<input type="email" name="memberMail" value="${member.memberMail}" readonly>

	            <b>주소</b>
	            <input type="text" name="memberAddr1" value="${member.memberAddr1}" readonly>
	            <input type="text" name="memberAddr2" value="${member.memberAddr2}" readonly>
	            <input type="text" name="memberAddr3" value="${member.memberAddr3}" readonly>
            	
            	<sec:authentication property="principal" var="pinfo"/>
            	<input type="button" value="수정" onclick="location.href='../member/pageModify?memberId=${pinfo.username}'">
            </div>
        </form>
    </div>
<%@include file="../includes/footer.jsp" %>