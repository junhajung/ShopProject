<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HOME</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	 <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
	<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
	<meta http-equiv="X-UA-Compatible" content="ie=edge"> 
</head>
<body>
 	<script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
      <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
      
      <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" ></script> 
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" ></script> 
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"  ></script> 

 	<!-- 네비게이션  -->
	<nav class="navbar navbar-expand-sm navbar-light bg-light border-bottom">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/">HOME</a>
    
    <!-- 모바일 같은 작은 화면시 토글버튼으로 변경 -->
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    	<span class="navbar-toggler-icon"></span>
    </button>
    
   ﻿<div class="collapse navbar-collapse navbar-ex1-collapse" id = "collapsibleNavbar">

       <ul class="nav navbar-nav navbar-right">
       	<security:authorize access="!isAuthenticated()">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/member/login">Login</a>
            </li>
                    
            <li class="nav-item">
	        <a class="nav-link" href="${pageContext.request.contextPath}/member/join">Join</a>
	      	</li>
	      
		</security:authorize>
		
		<security:authorize access="isAuthenticated()">
			<li class="nav-item">
				 <a class="nav-link" id = "logout" href="#">Logout</a>
            </li>
        </security:authorize> 

	      	
	    
		   	<security:authorize access="hasAuthority('USER')">
		   	<li class="nav-item">
	       	 <a class="nav-link" href="${pageContext.request.contextPath}/mypage/cart">Cart</a>
	     	</li>
		     <li class="nav-item">
		             <a class="nav-link" href="${pageContext.request.contextPath}/mypage/select">Mypage</a>
		     </li>
		     <li class="nav-item">
		             <a class="nav-link" href="${pageContext.request.contextPath}/notice">Notice</a>
		     </li>
		     
		     </security:authorize>
		     
		    <security:authorize access="hasAuthority('ADMIN')">
		   	 <li class="nav-item">
		   	 	<a class="nav-link" href="${pageContext.request.contextPath}/member/mypage/admin">Mypage</a>
		     </li>
		     <li class="nav-item">
		   	 	<a class="nav-link" href="${pageContext.request.contextPath}/member/notice/admin">Notice</a>
		     </li>
		     
		    </security:authorize>
        </ul>
    </div>

	</nav>



	<!-- 사이트 제목 , 검색  -->
	<div class = "container">
		<div class="container-fluid full-width">
		<div class="row">	
			
			<div class="col-md-6">
			<a href = "${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/images/Spring.PNG" width = "200" height = "80" /> </a>
			</div>
			
			<div class="col-md-6">
			<form class="form-inline" action="${pageContext.request.contextPath}/product/select" method="get" style ="float:right"  >
				 	<input type="text" name="txt" class="pull-right form-control" placeholder="검색어를 입력하세요"/>
				 	<input type="submit" class=" pull-right form-control"  value="Search"/>
			</form>
			</div>
			
		</div>
		</div>
	</div>
	
	
   <!--  전체 카테고리 -->
	<nav class="navbar  navbar-light bg-withe" style = " position:fixed; z-index : 100;">
	 	
	 	  <ul class="nav navbar-nav mr-auto" style="float:left; list-style-type: none; ">
	 	  	<li class = "dropdown ">
	 	  		<a class = "dropdown-toggle" data-toggle = "dropdown" href="#" style = "color : black"> 전체 카테고리 </a>

				<ul class = "dropdown-menu">
					<c:forEach var="vo" items="${kategorieList}">
	 	  			<li> <a href = "${pageContext.request.contextPath}/product/select1?id=${vo.id}">${vo.name}</a></li>
	 	  			</c:forEach>
	 	  		</ul>
	 	  </ul> 
 
	</nav>
	<br/><br/><hr/>
	

		<div style="padding:50px 50px 50px 300px;"> 
		<div class = "col-sm-9" style="height:200px, width:200px; border:1px solid #D6D6D6; background-color : #F8F9FA; "><h3> 공지사항 </h3></div>
   			 <br/> <br/> <br/> <br/> 
 			 <div class="col-sm-9 " style="height:200px, width:200px; border:1px solid #D6D6D6; height:2000px; ">
 			 
 			 <br/><br/>
 			 <table class="table" style="border:1px solid #cccccc">
		        <thead>
		            <tr>
		                <th style="border:1px solid #D6D6D6;">공지사항</th>
		                <th style="border:1px solid #D6D6D6;">등록일자</th>
		                <th style="border:1px solid #D6D6D6;">삭제 / 수정 </th>
		           
			       </tr>
		        </thead>
        
		        <tbody>
		        
		                <c:if test="${!empty noticelist}">
		                 <c:forEach var="vo" items="${noticelist}">
		                  <tr>

  
				                 <td style="border:1px solid #D6D6D6;">
				                  	<a href = "${pageContext.request.contextPath}/notice/detail?no=${vo.no}" style="color:black;">${vo.title}</a>
				                  	<input type = "hidden" name = "title" value = "${vo.title}">
				                 </td>
				                 
				                  <td>
		                  			<fmt:formatDate pattern="yyyy-MM-dd" value="${vo.date}"/>
		                  		 </td>
		                  		 
				                 <td style="border:1px solid #D6D6D6;">
				                   	<a href="${pageContext.request.contextPath}/member/notice/admin/delete?no=${vo.no}" >삭제 / </a>
				                   	<a href="${pageContext.request.contextPath}/member/notice/admin/update?no=${vo.no}" >수정</a>
				                  </td>
		
				           </tr>
		                  
		                </c:forEach>
		            </c:if>
		            <c:if test="${empty noticelist}">
		                <tr>
		                    <td colspan="5">자료가 없습니다.</td>
		                </tr>
		            </c:if>
		        </tbody>
   			 </table>

			<form action="${pageContext.request.contextPath}/member/notice/admin" method="get" class="form-line"  >
				<div class="input-group" style = "display: flex; justify-content: center; align-items: center;" >
					<input type="text" name="txt" placeholder="검색어" class="form-control" style = "postion:relative;  width :500px;"/> 
					<input type="submit" value="검색"	 class="btn btn-primary" style = "postion:relative;  width :50px"/>
				</div>

			</form>
			<br />


			<div id="pagination-div" class="input-group" style = "display: flex; justify-content: center; align-items: center;">
				<!-- jquery cdn -->
				<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
				<!-- twbspagination cdn -->
				<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js"></script>

				<script>
					$(function() {
						$('#pagination-div')
								.twbsPagination(
										{
											totalPages : Number('${totPages}'),
											visiblePages : 10,
											startPage : Number('${param.page}'),
											initiateStartPageClick : false,
											onPageClick : function(event, page) {
												window.location.href = "${pageContext.request.contextPath}/member/notice/admin?txt="+'${param.txt}'+ "&page="+page;
											}
										});
					});
				</script>
			</div>


			<form  action="${pageContext.request.contextPath}/member/notice/admin" method="post" id="orderForm" >
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				
				
				<div class=" form-horizontal" style="padding:20px 20px 20px 20px; border: 1px solid #D6D6D6; height: 700px; margin:50px;">
				<div >
	            
	                	<h2  style="padding:0px 0px 0px 400px; "> 공지사항 작성 </h2>
	            	
	           		 <div class="col-sm-12 text-left"  style="padding:0px 150px 50px 150px; ">
	              	 	  <br/> <br/>  
	              	 	  <label for="id">제목</label> 
	              	 		 <input type = "text" name = "title" placeholder = "제목" class = "form-control"  /> <br/>
	              	 	 
	              	 	 <label for="id">내용</label> 
	              	 	 	<textarea name="content" rows="15" placeholder="공지사항을 입력하세요." class="form-control"></textarea>
	              	 	  <br/>
	              	 	   <div class="input-group" style = "display: flex; justify-content: center; align-items: center;" >
	              	 	  <input type="submit" value="작성하기" id="orderSuccess" class="btn btn-success"  style = "postion:relative;  ">
	              	 	  </div>
	            	 </div>
      			 </div>
      			 </div>

		
			</form>
 			 
 			 </div>
	
		</div>
		

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