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

textarea:read-only {
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
                <form>
                    <div class="card-body">
                    	<h4>번호</h4>
                        <input type="text" class="form-control" id="bno" name="bno" readonly
								value='<c:out value="${board.bno}"/>' />
                        <br/>
                        <h4>제목</h4>
                        <input type="text" class="form-control" id="title" name="title" readonly
								value='<c:out value="${board.title}"/>' />
                        <br/>
                        <h4>내용</h4>
                        <textarea class="form-control" id="content" name="content" rows="10" readonly>
                        	<c:out value="${board.content}"/>
                        </textarea>
                        <br/>
                        <h4>작성자</h4>
                        <input type="text" class="form-control" id="writer" name="writer" readonly
                        		value='<c:out value="${board.writer}"/>'/>
                        <br/>	
                    </div>
                </form>
                <div class="card-footer d-flex justify-content-center">
                	<sec:authentication property="principal" var="pinfo"/>
                	<sec:authorize access="isAuthenticated()">
                		<c:if test="${pinfo.username eq board.writer}">
                    		<button type="button" data-oper='modify' class="btn btn-dark">수정</button>
                    	</c:if>
                    </sec:authorize>
                    &nbsp;&nbsp;
					<button data-oper='list' class="btn btn-outline-dark">목록</button>
                </div>
                <form id='operForm' action="modify" method="get">
                	<input type='hidden' id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
                	<input type='hidden' name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
                	<input type='hidden' name="amount" value='<c:out value="${cri.amount}"/>'>
                	<input type='hidden' name="keyword" value='<c:out value="${cri.keyword}"/>'>
                	<input type='hidden' name="type" value='<c:out value="${cri.type}"/>'>
                </form>
            </div>
            <!-- 댓글 처리 창 -->
			<div class="row mt-5">
				<div class="col-md-12 clearfix">							
			        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-wechat" viewBox="0 0 16 16">
					  <path d="M11.176 14.429c-2.665 0-4.826-1.8-4.826-4.018 0-2.22 2.159-4.02 4.824-4.02S16 8.191 16 10.411c0 1.21-.65 2.301-1.666 3.036a.324.324 0 0 0-.12.366l.218.81a.616.616 0 0 1 .029.117.166.166 0 0 1-.162.162.177.177 0 0 1-.092-.03l-1.057-.61a.519.519 0 0 0-.256-.074.509.509 0 0 0-.142.021 5.668 5.668 0 0 1-1.576.22ZM9.064 9.542a.647.647 0 1 0 .557-1 .645.645 0 0 0-.646.647.615.615 0 0 0 .09.353Zm3.232.001a.646.646 0 1 0 .546-1 .645.645 0 0 0-.644.644.627.627 0 0 0 .098.356Z"/>
					  <path d="M0 6.826c0 1.455.781 2.765 2.001 3.656a.385.385 0 0 1 .143.439l-.161.6-.1.373a.499.499 0 0 0-.032.14.192.192 0 0 0 .193.193c.039 0 .077-.01.111-.029l1.268-.733a.622.622 0 0 1 .308-.088c.058 0 .116.009.171.025a6.83 6.83 0 0 0 1.625.26 4.45 4.45 0 0 1-.177-1.251c0-2.936 2.785-5.02 5.824-5.02.05 0 .1 0 .15.002C10.587 3.429 8.392 2 5.796 2 2.596 2 0 4.16 0 6.826Zm4.632-1.555a.77.77 0 1 1-1.54 0 .77.77 0 0 1 1.54 0Zm3.875 0a.77.77 0 1 1-1.54 0 .77.77 0 0 1 1.54 0Z"/>
					</svg> 댓글
					<sec:authorize access="isAuthenticated()">
					    <button type="button" id='addReplyBtn' class='btn btn-sm btn btn-outline-primary' style='float:right'>
					        댓글쓰기
					    </button>	
				    </sec:authorize>		      
			     </div>  
			</div>
			<div class="row mt-2">
				<div class="col-md-12">
					<ul class="chat list-group">
						<!--댓글 출력 형태를 참조 
							<li class='list-group-item clearfix' data-rno='12'>
								<strong class='text-primary'>user00</strong>
								<small class='text-mute' style='float:right'>2023-05-03</small>
								<p>댓글 내용입니다</p>
							</li>
						-->
					</ul>        
				</div>
			</div>
			<br/>
			<div id='replyPage' style="float:right;">
				<!-- 댓글 페이지 -->
			</div>
        </div>
    </div>
    <br/><br/><br/><br/>
</div>
<%@include file="../includes/replyModal.jsp" %>
<%@include file="../includes/footer.jsp" %>
<script src="/resources/js/reply.js"></script>
<!-- 게시판 조회창에서 수정/삭제 버튼 이벤트 처리 -->
<script>
	$(document).ready(function() {
		let operForm = $("#operForm");
		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "modify").submit();
		});
		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#bno").remove();
			operForm.attr("action", "list");
			operForm.submit();
		});
	});
</script>

<script>
	$(document).ready(function(){
		let bnoValue = '<c:out value="${board.bno}"/>';
		let replyUL = $(".chat");
		
		showList(1);
		//댓글 목록
		function showList(page){
			
			ReplyService.getList({bno: bnoValue, page: page || 1}, function(rpDto){
				
				//페이지처리 추가 부분
				let replyCnt = rpDto.replyCnt;
				let list = rpDto.list;
				
				if(page == -1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				
				let str = "";
				
				if(list == null || list.length == 0) {
					replyUL.html("");
					
					return;
				}
				for(let i=0, len=list.length || 0; i<len; i++){
					str += "<li class='list-group-item clearfix' data-rno='"+list[i].rno+"'>";
					str += "<strong class='text-primary'>"+list[i].replyer+"</strong>";
					str += "<small class='text-mute' style='float:right'>"+ReplyService.displayTime(list[i].replyDate)+"</small>";
					str += "</br></br>";
					str += "<p>"+list[i].reply+"</p>";
					str += "</li>";
				}
				replyUL.html(str);
				
				showReplyPage(replyCnt);
			});
		} 
		
		//페이지
		let pageNum = 1;
		let replyPageFooter = $("#replyPage");
		
		function showReplyPage(replyCnt) {
			
			let endNum = Math.ceil(pageNum / 10.0) * 10;
			let startNum = endNum - 9;
			
			let prev = startNum != 1;
			let next = false;
			
			if(endNum * 10 >= replyCnt){
				endNum = Math.ceil(replyCnt/10.0);
			}
			
			if(endNum * 10 < replyCnt){
				next = true;
			}
			
			let str = "<ul class='pagination justify-content-center' style='margin: 5px 0;'>";
			if(prev) {
				str += "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>";
			}
			for(let i=startNum; i<=endNum; i++){
				let active = pageNum == i ? "active" : "";
				str += "<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
			}
			if(next){
				str += "<li class='page-item'><a class='page-link' href='"+(endNum +1)+"' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>";
			}
			str += "</ul>";
			
			replyPageFooter.html(str);
		}
		
		let modal = $("#replyModal");
		let modalInputReply = modal.find("input[name='reply']");
		let modalInputReplyer = modal.find("input[name='replyer']");
		let modalInputReplyDate = modal.find("input[name='replyDate']");
		
		let modalModBtn = $("#modalModBtn");
		let modalRemoveBtn = $("#modalRemoveBtn");
		let modalRegisterBtn = $("#modalRegisterBtn");
		
		//시큐리티 처리
		let replyer = null;
		<sec:authentication property="principal" var="pinfo"/>
		<sec:authorize access="isAuthenticated()">
			replyer = '<sec:authentication property="principal.username"/>';
		</sec:authorize>
		
		let csrfHeaderName = "${_csrf.headerName}";
		let csrfTokenValue = "${_csrf.token}";
		
		$(document).ajaxSend(function(e, xhr, options){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});
		
		//모달창 나가기 버튼
		$("#modalCloseBtn").on("click", function(e){
			modal.modal('hide');
		});
		
		//댓글 등록 모달창 
		$("#addReplyBtn").on("click", function(e){
			modal.find("input").val("");
			modal.find("input[name='replyer']").val(replyer);
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide();
			
			modalRegisterBtn.show();
			
			$("#replyModal").modal("show");
		});
		
		//댓글 등록 
		modalRegisterBtn.on("click", function(e){
			
			let reply = {
					reply : modalInputReply.val(),
					replyer : modalInputReplyer.val(),
					bno : bnoValue
			};
						
			
			ReplyService.add(reply, function(result){
				alert("등록완료");
				
				modal.find("input").val("");
				modal.modal("hide");
				
				showList(1); 
				//showList(-1);
			});
		});
		
		//댓글 조회
		$(".chat").on("click", "li", function(e){
			
			let rno = $(this).data("rno");
			
			ReplyService.get(rno, function(reply){
				
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(ReplyService.displayTime(reply.replyDate))
				.attr("readonly", "readonly");
				modal.data("rno", reply.rno);
				
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				$("#replyModal").modal("show");
			});
		});
		
		//댓글 수정
		modalModBtn.on("click", function(e){
			
			let originalReplyer = modalInputReplyer.val();
			
			let reply = {rno:modal.data("rno"), 
						reply:modalInputReply.val(),
						replyer:originalReplyer};
			
			if(!replyer){
				alert("로그인 후 수정이 가능합니다.");
				modal.modal("hide");
				return;
			}
			console.log("Original Replyer: " + originalReplyer);
			
			if(replyer != originalReplyer){
				alert("자신이 작성한 댓글만 수정 가능합니다.");
				modal.modal("hide");
				return;
			}
			
			ReplyService.update(reply, function(result){
				alert("수정완료");
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		//댓글 삭제
		modalRemoveBtn.on("click", function(e){
			
			let rno = modal.data("rno");
			
			console.log("RNO: " + rno);
	       	console.log("REPLYER: " + replyer);
	       	
	       	if(!replyer){
	       		alert("로그인 후 삭제가 가능합니다.");
	       		modal.modal("hide");
	       		return;
	       	}
	       	
	       	let originalReplyer = modalInputReplyer.val();
	       	console.log("Original Replyer: " + originalReplyer);
	       	
	       	if(replyer != originalReplyer){
	       		alert("자신이 작성한 댓글만 삭제 가능합니다.");
	       		modal.modal("hide");
	       		return;
	       	}
			
			ReplyService.remove(rno, originalReplyer, function(result){
				alert("삭제완료");
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		//페이지 클릭
		replyPageFooter.on("click", "li a", function(e){

			e.preventDefault();
			
			let targetPageNum = $(this).attr("href");
			pageNum = targetPageNum;
			showList(pageNum);
		});
	});
</script>
<!-- 댓글 테스트
<script>
	console.log("JS TEST");
	console.log("JS TEST");
	
	let bnoValue = '<c:out value="${board.bno}"/>'
	
	ReplyService.add(
			{reply:"JS Test", replyer:"tester", bno:bnoValue},
			function(result){ 
			      alert("RESULT: " + result);
			    }
	);
	
	ReplyService.getList({bno:bnoValue, page:1}, function(list){
		for(var i = 0,  len = list.length||0; i < len; i++ ){
			console.log(list[i]);
		}
	});
	
	ReplyService.remove(11, function(count) { 

		   console.log(count);

		   if (count === "success") {
		     alert("REMOVED");
		   }
		 }, function(err) {
		   alert('ERROR...');
	});
	
	ReplyService.update({
		  rno : 2,
		  bno : bnoValue,
		  reply : "Modified Reply...."
		}, 
		function(result) {

		  alert("수정 완료...");

	});
	
	ReplyService.get(5,function(data){
		console.log(data);
	});
</script>
 -->
