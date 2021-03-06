<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    
    
<form id="loginIdForm" method="post" action="/user/sign_in">

<section class="d-flex justify-content-center">

	
	<section class="login-box border rounded d-flex justify-content-center ">
		<div class="m-5">
			
				
			<div class="d-flex justify-content-center mb-3">
				<div><input type="text" id="loginId" name="loginId" class="form-control" placeholder="아이디"></div>
			</div>
	
			<div class="d-flex justify-content-center mb-3">
				<div><input type="password" id="password" name="password" class="form-control" placeholder="비밀번호"></div>
			</div>
		
			<div class="d-flex justify-content-center mb-3">
				<button type="submit" id="signInBtn" class="btn-primary form-control col-12">로그인</button>
			</div>
	
			
			<div class="border rounded py-3 text-center">
				계정이 없으신가요? <a href="/user/sign_up_view">가입하기</a>
			</div>
		</div>
	</section>
	
</section>
</form>

<!--form태그 사용시 3종 세트: form태그 , name, 버튼 타입:submit  -->
<script>
	$(document).ready(function(){
		//alert("click");
		$('#loginIdForm').on('submit',function(e) {
			//alert("click");
			e.preventDefault();
			
			var loginId = $('#loginId').val().trim();
			
			if (loginId == '') {
				alert("아이디를 입력해주세요");
				return false;
			}
			var password = $('#password').val();
			if (password == '') {
				alert("비밀번호를 입력해주세요");
				return false;
			}
			
			// ajax 호출
			
			var url = $(this).attr('action');
			var params = $(this).serialize();
			
		 	$.post(url,params)
			.done(function(data) {
				 if (data.result == 'success') {
					alert(loginId + "님 환영합니다!!!");
					 location.href = "/timeline/timeline_list_view"; 
				} else {
					alert(data.errorMessage);
				} 
			});
			
		});
		
		
	});
</script>