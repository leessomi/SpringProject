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
                <form action="modify" method="post" id="mform" name="mform">
                	<input type='hidden' name="${_csrf.parameterName}" value="${_csrf.token}"/>
                	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
                	<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
                	<input type='hidden' name="keyword" value='<c:out value="${cri.keyword}"/>'>
                	<input type='hidden' name="type" value='<c:out value="${cri.type}"/>'>
                	
                    <div class="card-body">
                    	<h4>번호</h4>
                        <input type="text" class="form-control" id="bno" name="bno" readonly
								value='<c:out value="${board.bno}"/>' />
                        <br/>
                        <h4>제목</h4>
                        <input type="text" class="form-control" id="title" name="title"
								value='<c:out value="${board.title}"/>' />
                        <br/>
                        <h4>내용</h4>
                        <textarea class="form-control" id="content" name="content" rows="10">
                        	<c:out value="${board.content}"/>
                        </textarea>
                        <br/>
                        <h4>작성자</h4>
                        <input type="text" class="form-control" id="writer" name="writer" readonly
                        		value='<c:out value="${board.writer}"/>'/>
                        <br/>	
                        <h4>게시일</h4>
                        <input type="text" class="form-control" id="regDate" name="regDate" 
							value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.regDate}"/>'readonly/>
                        <br/>
                        <h4>수정일</h4>
                        <input type="text" class="form-control" id="updateDate" name="updateDate"
                        		value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.updateDate}"/>'readonly/>
                        <br/>
                    </div>
                    <div class="card-footer d-flex justify-content-center">
                    	<sec:authentication property="principal" var="pinfo"/>
                    	<sec:authorize access="isAuthenticated()">
                    		<c:if test="${pinfo.username eq board.writer}">
  								<button type="submit" data-oper='remove' class="btn btn-outline-dark">삭제</button>&nbsp;&nbsp;
  								<button type="submit" data-oper='modify' class="btn btn-dark">수정</button>&nbsp;&nbsp;
  							</c:if>
  						</sec:authorize>						
						<button type="submit" data-oper='list' class="btn btn-outline-dark">목록</button>	
                	</div>
                </form>
            </div>
        </div>
    </div>
</div>
<br/><br/><br/><br/><br/>
<%@include file="../includes/footer.jsp" %>
<script>
$(document).ready(function(){
	let formObj = $("#mform");
	
	$("button").on("click",function(e){
		e.preventDefault(); 
		
		let operation = $(this).data("oper");

		console.log("operation : "  + operation);
		
		if(operation == "remove") {
			formObj.attr("action","remove");
		}
		else if(operation == "list") {
			formObj.attr("action", "list").attr("method","get"); 
			let pageNumTag = $("input[name='pageNum']").clone();
			let amountTag = $("input[name='amount']").clone();
			let keywordTag = $("input[name='keyword']").clone();
			let typeTag = $("input[name='type']").clone();
			
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(typeTag);
		}
		formObj.submit();
	});
});
</script>