<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="d-flex justify-content-center m-5">
	<div class="w-40">
	
		<c:if test="${not empty userId}">
		<div class="cleateTimeline-Group write-box border rounded m-3">		
			<textarea id="content" name="content" class="cleateTimeline border-0 w-100" rows="5" ></textarea>
			<div class="cleateTimelineUpload d-flex justify-content-between">
				<div class="file-upload d-flex">
			       <input type="file" id="file" class="d-none" accept=".gif, .jpg, .png, .jpeg">
						<a href="#" id="fileUploadBtn"><img width="35" src="https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-image-512.png"></a>
						<div id="fileName" class="ml-2">
						</div>
				</div>				
				<button type="button" id="uploadBtn" class="btn btn-warning">업로드</button>
				
			</div>	
		</div>
		</c:if>
		<div class="timelinelist-group mt-3">
			<c:forEach var="content" items="${contentViewList}">	
			<div class="nickname-group mt-3">
				<div class="timeline-bar h-10 border rounded d-flex justify-content-between pr-2">
					<span class="display-5 ml-2"><b>${content.user.loginId}</b></span>

						<%-- 클릭할 수 있는 ... 버튼 이미지 --%>
						<%-- 글쓴사용자와 로그인 사용자가 일치할때만 삭제 가능--%>
						<c:if test="${userName eq content.user.name}">
							<a href="#" class="more-btn" data-toggle="modal" data-target="#moreModal" data-post-id="${content.post.id}"> 
								<img src="https://www.iconninja.com/files/860/824/939/more-icon.png" width="30">
							</a>
						</c:if>
					
				</div>
					<ul class="list mr-4 ">
						<li><img width="400" src="${content.post.imagePath}" alt="이미지" class="m-2"/></li>
						<li>${content.post.content}</li>
					</ul>
				<div class="d-flex justify-content-start mt-2 ml-5">
				<a href="#" class="likeBtn mr-2" data-post-id="${content.post.id}" data-user-id="${content.user.id}">
						<%-- 좋아요 누름 --%>
						<c:if test="${content.filledLike eq false}">
							<img width="18" src="https://www.iconninja.com/files/214/518/441/heart-icon.png"/>
						</c:if>
						<%-- 좋아요 해제 --%>
						<c:if test="${content.filledLike eq true}">
							<img width="18" src="https://www.iconninja.com/files/527/809/128/heart-icon.png"/>
						</c:if>
					
				</a>		
					<a class=""><b>좋아요${content.likeCount}개</b></a>
				</div>
			
			</div>
			<div class="comment-group m-2 ml-4 mr-4" >
			<c:if test="${not empty content.commentList}">
				<div class="timeline-bar h-10 border rounded ">
					<span class="ml-2"><b>댓글</b></span>
				</div>
				
				<c:forEach var="comment" items="${content.commentList}">	
					<div class="comment-list  ">
						<span class="ml-2"><b>${comment.user.loginId}</b></span>
						<span>${comment.comment.content}</span>
						<%-- 댓글 삭제버튼 --%>
						<c:if test="${comment.user.id == userId}">
							<a href="#" class="commentDelBtn" data-comment-id="${comment.comment.id}">
								<img src="https://www.iconninja.com/files/603/22/506/x-icon.png" width="10px" height="10px">
							</a>
						</c:if>
					</div>
				</c:forEach>
				
			</c:if>
				<c:if test="${not empty userId}">
					<div class="cleate-comment-group d-flex justify-content-start mt-2 ">
						<input type="text" id="commentText${content.post.id}" name="commentText" class="form-control" placeholder="댓글을 입력해주세요.">
						<button type="button" class="commentBtn btn btn-none" data-post-id="${content.post.id}">게시</button>
					</div>	
				</c:if>
			</div>
			
			</c:forEach>
		</div>	
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="moreModal">
  <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
    <div class="modal-content">
      	<%-- modal 창 안에 내용 넣기 --%>
      	<div class="">
      		<div class="my-3 text-center">
      			<a href="#" class="del-post d-block" >삭제하기</a>
      		</div>
      		<div class="border-top py-3 text-center">
      			<a href="#" class="cancel d-block" data-dismiss="modal">취소</a>
      		</div>
      	</div>
    </div>
  </div>
</div>


<script>
$(document).ready(function(){
	
	// 파일 업로드 이미지 버튼 클릭 - 사용자가 업로드를 할 수 있게 해줌
	$('#fileUploadBtn').on('click', function(e) {
		e.preventDefault(); // 기본 작동 중지
		$('#file').click(); // input file을 클릭한 것과 같은 동작
	});
	
	// 사용자가 파일 업로드를 했을 때 유효성 확인 및 업로드 된 파일 이름을 노출
	$('#file').on('change', function(e) {
		var name = e.target.files[0].name;
		
		// 확장자 유효성 확인
		var extension = name.split('.');
		if (extension.length < 2 || 
		 	(extension[extension.length - 1] != 'gif' 
		 	&& extension[extension.length - 1] != 'png' 
		 	&& extension[extension.length - 1] != 'jpg'
		 	&& extension[extension.length - 1] != 'jpeg')) {
		 	
		 	alert("이미지 파일만 업로드 할 수 있습니다.");
		 	$(this).val(""); // 이미 올라간 것을 확인한 것이기 때문에 비워주어야 한다.
		 	return;
		 }
		 
		 $("#fileName").text(name);
	});
	
	
	$('#uploadBtn').on('click', function(e){
		//alert("click");
		let content = $('#content').val();
		//console.log(content);
		
		// 파일이 업로드 된 경우 확장자 체크
		let file = $('#file').val(); // 파일 경로만 가져온다
		// console.log(file); //C:\fakepath\partlyCloudy.jpg
		//validation
		if(file != ''){
			let ext = file.split('.').pop().toLowerCase(); // 파일 경로를 .으로 나누고 확장자가 있는 마지막 문자열을 가져온 후 모두 소문자로 변경 
			if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1){ // -1 확장자가 포함되지 않음
				alert("gif,png,jpg,jpeg 파일만 업로드 할 수 있습니다.");
				 $('#file').val(''); // 파일을 비운다.
				return;
			}
			
		}
		
		// 폼태그를 자바스크립트에서 만든다.
		let formData = new FormData();
		formData.append("content", content);
		formData.append("file", $('#file')[0].files[0]); // $('#file')[0] 첫번째 input file 태그를 의미 , flies[0] 업로드된 첫번째 파일을 의미 
		
		//AJAX from 데이터 전송 $.ajax({
		$.ajax({
			type: "POST"
			, url: "/post/create"
			, data: formData
			, enctype: "multipart/form-data" // 파일업로드를 위한 필수 설정
			, processData: false // 파일업로드를 위한 필수 설정
			, contentType: false // 파일업로드를 위한 필수 설정
			//---request
			, success: function(data){ //response
				if(data.result == 'success'){
					alert("게시글이 저장되었습니다.");
					location.href="/timeline/timeline_list_view";
				}else{
					alert("로그인 후 사용가능 합니다.")
					location.href="/user/sign_in_view";
				}
				
			}
			, error: function(e) {
				alert("게시글이 저장에 실패했습니다. 관리자에게 문의해주세요.");
			}
		});
	});
		
	// 댓글쓰기 - 게시 버튼 클릭
	$('.commentBtn').on('click',function(){
	let postId= $(this).data('post-id'); //data-post-id 
		//alert(postId);
	
		let commentText = $('#commentText' + postId).val();
		//alert(commentText);
		
		if(commentText == ''){
			alert("댓글을 입력해주세요.")
			return;
		}
		
		$.ajax({
			type:"POST"
			,url:"/comment/create"
			,data: {"postId":postId, "content":commentText}
			,success: function(data){
				if(data.result == 'success'){
					alert("댓글이 입력되었습니다.")
					location.reload();
				}
				
			}
			,error: function(e){
				alert("댓글입력에 실패하였습니다. 관리자에 연락해주세요.")	
			}
			
			
			
		});
		
	});
	$('.likeBtn').on('click', function(e){
			e.preventDefault();
			
		let	postId = $(this).data('post-id');
		let userId = $(this).data('user-id');
		
		console.log(postId);
		console.log(userId);
		
		if(userId == ''){
			alert("로그인후 사용가능합니다.");
			return;
		}
		
		$.ajax({
			type: "POST"
			, url: "/like/" + postId
			, success: function(data){
				if(data.result == 'success'){
					location.reload();
					
				}else {
					alert(data.errorMassage);
				}
			}
			, error: function(e){
				alert("좋아요의 실패하였습니다.");	
			}
			
		});
	});
	
	//카드에서 더보기(...) 클릭시 모달에 삭제될 글 번호를 넣어준다.
	$('.more-btn').on('click', function(e){
		e.preventDefault();
		
		let postId = $(this).data('post-id');
		//alert(postId);
		
		$('#moreModal').data('post-id', postId);// set data-post-id="1" 같다 
	});
	
	
	// 모달창 안에 있는 삭제하기 버튼 클릭
	$('#moreModal .del-post').on('click', function(e){
		e.preventDefault();
		
		let postId = $('#moreModal').data('post-id'); // get 꺼내서 사용할수 있게 된다
		//alert(postId);
		
		// 삭제 AJAX DELETE
		
		$.ajax({
			type:"DELETE"
			,url:"/post/delete"
			,data:{"postId": postId}
			,success: function(data){
				if(data.result == 'success'){
					alert("삭제 되었습니다.");
					location.reload();
					
				}else{
					alert(data.errorMessage);
				}
			
			}
			,error: function(e){
				alert("삭제가 실패되었습니다. 관리자에 문의해주세요.");
			}
			
			
		});
		
	});

	// 댓글 삭제
	$('.commentDelBtn').on('click',function(e){
		e.preventDefault();
		
		let commentId = $(this).data('comment-id');
		//alert(commentId);
		
		
		$.ajax({
			type:"DELETE"
			,url:"/comment/delete"
			,data:{"commentId":commentId}
		
			,success:function(data){
				if(data.result == "success"){
					alert("삭제되었습니다.");
					location.reload();				
				}else{
					alet(data.errorMessage);
				}
				
			}
			,error: function(e){
				alert("댓글 삭제가 실패했습니다. 관리자에 문의바랍니다.")
			}
		});
		
	});
	
});
</script>