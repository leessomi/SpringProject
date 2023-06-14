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

</style>

<!-- Page content wrapper-->
    <div class="container">
        <div class="container-fluid">
            <div class="row">
                <form id='searchForm' method='get' action="list" class="d-flex justify-content-space-between align-items-end">
                    <h1 class="col mt-4">게시판</h1>
                    <div class="col col-5">
                        <div class="input-group mb-3">
                        	<select name='type'>
                        		<option value=""
                        			<c:out value="${pageMaker.cri.type == null ? 'selected' : ''}"/>>--</option>
                        		<option value= "T"
                        			<c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : ''}"/>>제목</option>
                        		<option value= "C"
                        			<c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}"/>>내용</option>
                        		<option value= "W"
                        			<c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : ''}"/>>작성자</option>
                        		<option value= "TC"
                        			<c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : ''}"/>>제목 or 내용</option>
                        		<option value= "TW"
                        			<c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : ''}"/>>제목 or 작성자</option>
                        		<option value= "TWC"
                        			<c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected' : ''}"/>>제목 or 내용 or 작성자</option>
                        	</select>
                        	<input class="form-control" type='text' name='keyword' 
								value='<c:out value="${pageMaker.cri.keyword}"/>' /> 
							<input type='hidden' name='pageNum'
								value='<c:out value="${pageMaker.cri.pageNum}"/>' /> 
							<input type='hidden' name='amount'
								value='<c:out value="${pageMaker.cri.amount}"/>' />
                            <button id="search" class="btn btn-sm btn-outline-dark">검색</button>
                            <button type="button" id="clear" class="btn btn-sm btn-outline-dark btn-clear">취소</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="row">
                <div class="col col-12">
                    <div class="card">
                        <div class="card-header text-bg-dark">
                            <div class="row">
                                <div class="col-10">게시판</div>
                                <div class="col-2 d-flex justify-content-end">
                                    <button type="button" id="regBtn" class="btn btn-sm btn btn-outline-primary">등록</button>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <table class="table table-striped table-bordered">
                            	<thead>
	                                <tr>
	                                    <th class="col-1 text-center">번호</th>
	                                    <th class="col-4 text-center">제목</th>
	                                    <th class="col-2 text-center">작성자</th>
	                                    <th class="col-1 text-center">조회수</th>
	                                    <th class="col-2 text-center">작성일</th>
	                                    <th class="col-2 text-center">수정일</th>
	                                </tr>
                                </thead>
                                <c:forEach items="${list}" var="board">
                                	<tr style="text-align: center;">
                                		<td><c:out value="${board.bno}"/></td>
                                		<td>
                                			<a class='move' href='<c:out value="${board.bno}"/>' style="text-decoration: none">
	                                			<c:out value="${board.title}"/>
	                                			<span class='badge text-bg-secondary' style="float:right;">
	                                				<c:out value="${board.replyCnt}"/>
	                                			</span>
                                			</a>
                                		</td>
                                		<td><c:out value="${board.writer}"/></td>
                                		<td><c:out value="${board.viewcount}"/></td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}"/></td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/></td>
                                	</tr>
                                </c:forEach>
                            </table>
                        </div>
                        <div class="card-footer d-flex justify-content-center">
                        	<nav aria-label="Page navigation example">
								<ul class="pagination justify-content-center" style="margin: 5px 0;">
									<c:if test="${pageMaker.prev}">
									    <li class="page-item">
									      <a class="page-link" href="${pageMaker.startPage -1}" aria-label="Previous">
									        <span aria-hidden="true">&laquo;</span>
									      </a>
									    </li>
									</c:if>
								    <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
								    	<li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : ''}"><a class="page-link" href="${num}">${num}</a></li>
								    </c:forEach>
								    <c:if test = "${pageMaker.next}">
									    <li class="page-item">
									      <a class="page-link" href="${pageMaker.endPage +1}" aria-label="Next">
									        <span aria-hidden="true">&raquo;</span>
									      </a>
									    </li>
								    </c:if>
								</ul>
							</nav>
							<form id='actionForm' action="list" method='get'>
								<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
								<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
								<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'/>
								<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type}"/>'/>
							</form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<%@include file="../includes/messageModal.jsp" %>
<%@include file="../includes/footer.jsp" %>
<script>
    $(document).ready(function(){
    	
    	//등록페이지 이동
    	$("#regBtn").on("click", function(){
    		self.location = "register";
    	});
    	
    	//제목 클릭시 조회창으로 이동
    	$('.move').on("click", function(e){
    		e.preventDefault(); 
    		actionForm.append("<input type='hidden' name='bno' value='"+
    	$(this).attr("href") + "'>");
    		actionForm.attr("action", "get");
    		actionForm.submit();
    	});
    	
    	//페이징처리
    	let actionForm = $("#actionForm");
    	$(".page-item a").on("click", function(e){
    		e.preventDefault();
    		console.log('page 번호 클릭');
    		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
    		actionForm.submit();
    	});
    	
    	//검색처리
    	let searchForm = $("#searchForm");
    	$('#searchForm #search').on("click", function(e){
    		if(!searchForm.find("option:selected").val()){
    			alert("검색종류를 선택하세요");
    			return false;
    		}
    		
    		if(!searchForm.find("input[name='keyword']").val()){
    			alert("키워드를 입력하세요");
    			return false;
    		}
    		
    		searchForm.find("input[name='pageNum']").val("1");
    		e.preventDefault();
    		searchForm.submit();
    	});
    	
    	$('#searchForm #clear').click(function(e){
    		searchForm.empty().submit();
    	});
    	
    	//모달창
    	let result='<c:out value="${result}"/>';
    	checkModal(result);
    	
    	function checkModal(result) {
    		
    		if(result == "") {
    			return;
    		}
    		if(parseInt(result) > 0) {
    			$(".modal-body #mbody").html("게시글 : " + parseInt(result) + "번이 등록되었습니다");
    		}
    		else if(result == "success") {
    			$(".modal-body #mbody").html("게시글 수정/삭제가 처리되었습니다");
    		}
    		else {
    			return;
    		} 
    		$("#messageModal").modal("show");
    	}
	});
</script>