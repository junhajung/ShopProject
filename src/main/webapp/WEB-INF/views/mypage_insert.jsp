<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>    

<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
		 <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
		<meta charset="UTF-8">
		<title>product insert</title>
	</head>
<body>



	<div class="col-md-1">
			<a href = "${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/images/Spring.PNG" width = "200" height = "80" /> </a>
	</div>
	<br/><br/>
	
	<div style="padding:100px 50px 30px 200px;"> <br/>
		<div class=" col-sm-1 mr-5" style=" border:1px solid #D6D6D6; overflow : hidden;" >
			<br/>
			<img src="${pageContext.request.contextPath}/resources/images/face.PNG" width = "100" height = "100" /> <br/>
           	<div  style = " white-space : nowrap;  text-overflow:ellipsis;"> &nbsp &nbsp  관리자 ${vo.name}님 <br/>
           		<a href = "${pageContext.request.contextPath}/mypage/insert"> 판매상품등록</a>
           	</div> <br/> 
           
           
     </div>
        
	<h3>판매 상품 등록</h3> 
	<div class=" col-sm-9" style=" border: 1px solid #D6D6D6; height: 1500px; padding:30px;">
		<form action="${pageContext.request.contextPath}/mypage/insert" method="post" enctype="multipart/form-data">
		
			
			<div style="white-space: nowrap; text-overflow: ellipsis;">
				<br/>
			
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

 		<label style="width:80px; display:inline-block">이미지 업로드</label>
			<div class=" col-mr-6">
			
				<div class=" col-sm-5 mr-2" style=" border: 1px solid #D6D6D6; height: 400px;" >
	             	<input type="file" name="img1"  style="display: block;" id="files" required/> <br/>
  					  <img id="image" style = "height:300px; width:300px;" />
				</div>
				<div class=" col-sm-5" style=" border: 1px solid #D6D6D6; height: 400px;" >
					<br/>
					1. 상품 이미지 사이즈는 300 * 300에 최적화 되어 있습니다. <br/>
					2. 페이지를 새로고침 하실 시 이미지를 다시 업로드 하셔야 합니다. <br/>
					3. 이미지 업로드시 이미지 파일명이 아닐시 이미지가 나타나지 않습니다. <br/>
					4. 이미지는 한장만 등록이 가능합니다.
				</div>
				<br/>
			</div>
	 		
	 		<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	 		<div class=" col-mr-6">
	 		<label style="width:80px; display:inline-block">상품 정보 입력</label>
	 	
	 		<div class=" form-horizontal" style=" border: 1px solid #D6D6D6; height: 500px;">
	 		<br/>
	 		
	 			<div class="form-group">
	            	<div class="col-sm-2 control-label">
	                	<label for="kateid">카테고리</label>
	            	</div>
	            	<div class="col-sm-6">
	           		<select name="kateid" class="form-control">
						<c:forEach var="vo" items="${kategorieList}">
						<option value="${vo.id}"> ${vo.name} </option>
						</c:forEach>
					</select> 
					</div>
      			 </div>
      			 

	 			
	 			<div class="form-group">
	            	<div class="col-sm-2 control-label">
	                	<label for="id">상품명</label>
	            	</div>
	           		 <div class="col-sm-6 text-left">
	              	 	 <input type="text" class="form-control" name="name"  placeholder="상품명" required> 
	            	 </div>
      			 </div>
      			 
      			   
				<div class="form-group">
	            	<div class="col-sm-2 control-label">
	                	<label for="id">가격</label>
	            	</div>
	           		 <div class="col-sm-6 text-left">
	              	 	 <input type="text" class="form-control" name="price"  placeholder="가격" required>
	            	 </div>
      			 </div>

				<div class="form-group">
	            	<div class="col-sm-2 control-label">
	                	<label for="id">상품설명</label>
	            	</div>
	           		 <div class="col-sm-6 text-left" >
	              	 	  <textarea name="contents" rows="15" placeholder="상품설명을 입력하세요." class="form-control"></textarea>
	            	 </div>
      			 </div>
	            
	          
	
			</div>
		</div>
				<br/><br/>

				 <div class="input-group" style = "display: flex; justify-content: center; align-items: center;" >	
               <input type="submit" value="상품등록" class="btn btn-success" value="제출" />
               </div>

		</div>
	</form>
	</div>
</div>

	<script>
	document.getElementById("files").onchange = function () {
	    var reader = new FileReader();

	    reader.onload = function (e) {
	        // get loaded data and render thumbnail.
	        document.getElementById("image").src = e.target.result;
	    };

	    // read the image file as a data URL.
	    reader.readAsDataURL(this.files[0]);
	};
	</script>
	
	<script>
		$(function(){
			$('#logout').click(function(){
				// 시큐리티 CSRF 처리
				const header = '${_csrf.headerName}'; 
				const token = '${_csrf.token}';
				
				$.ajax({ // 같은 기능 == axios, fetch
					url: "${pageContext.request.contextPath}/member/logout",
					data : JSON.stringify({}),
					beforeSend : function(xhr){   // 데이터를 전송하기 전에 헤더에 csrf값 설정
						xhr.setRequestHeader(header, token);
			        },
					contentType: "text/html; charset=utf-8",
					type: 'POST',	
					success: function (res) { //에러가 발생하지 않았을 경우
					    console.log(res); // ret
	                    alert("성공했습니다."); // 알림창
	                    window.location.href='${pageContext.request.contextPath}/';
					},error: function (xhr) { //에러가 발생
					  	console.log(xhr.responseText);
						alert('실패했습니다.'); // 알림창
					} 
				});
			});
		});
	</script>
	

</body>
</html>