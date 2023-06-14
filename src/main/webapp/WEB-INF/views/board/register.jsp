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

.row {
	margin-top: 150px;
}

input:read-only {
	background-color: #F5F5F5;
}
</style>

<div class="container">
    <div class="row justify-content-md-center">
        <div class="col col-12">
            <div class="card col-12">
                <div class="card-header text-bg-dark">
                    <h5 class="col mt-1">글쓰기</h5>
                </div>
                <form action="register" method="post" id="boardFrm" name="boardFrm">
                	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="card-body">
                    	<h4>작성자</h4>
                        <input type="text" class="form-control" id="writer" name="writer" value='<sec:authentication property="principal.username"/>' readonly/>
                        <br/>
                        <h4>제목</h4>
                        <input type="text" class="form-control" id="title" placeholder="Enter Title" name="title" required />
                        <br/>
                        <h4>내용</h4>
                        <textarea class="form-control" id="content" placeholder="Enter Content" name="content" rows="10" required></textarea>
                        <br/>
                    </div>
                    <div class="card-footer d-flex justify-content-center">
						<button type="reset" class="btn btn-outline-dark">취소</button>&nbsp;&nbsp;
						<button type="submit" onclick="checkFrm()" class="btn btn-dark">등록</button>	&nbsp;&nbsp;
						<a id="listLink" href="list" class="btn btn-outline-dark">목록</a>
                	</div>
                </form>
            </div>
        </div>
    </div>
</div>
<%@include file="../includes/footer.jsp" %>
<script>
    function checkFrm()
    {
        let f = document.boardFrm;

        if(f.title.value == ''){
            alert('제목을 입력하세요.');
            f.title.focus();
            return;
        }

        if(f.content.value == ''){
            alert('내용을 입력하세요.');
            f.content.focus();
            return;
        }
        f.submit();
    }
</script>