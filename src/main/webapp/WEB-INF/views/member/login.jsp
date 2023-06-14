<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="/resources/css/member/login.css">
    
    <div class="login-wrapper">
        <h2>로그인</h2>
        <h2><c:out value="${error}"/></h2>
        <h2><c:out value="${logout}"/></h2>
        
        <form method="post" action="/login" id="loginForm">
        	<b>아이디</b>
            <input type="text" name="username" placeholder="ID" required>
            
            <b>비밀번호</b>
            <input type="password" name="password" placeholder="Password" required>
            
            <div>
            	<input type='checkbox' name='remember-me' checked> 로그인 유지
            </div>
            
            <input type="submit" value="로그인">
            <input type="button" value="회원가입" onclick="location.href='/member/join'">
            
            <input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'/>
        </form>
    </div>

<%@include file="../includes/footer.jsp" %>