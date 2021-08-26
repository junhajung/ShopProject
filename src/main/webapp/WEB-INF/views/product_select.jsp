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
<title>Product Select</title>
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
    <a class="navbar-brand" href="${pageContext.request.contextPath}/home">HOME</a>
    
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
				 	<input type="text"  name="txt"  class="pull-right form-control" placeholder="검색어를 입력하세요"/>
				 	<input type="submit" class=" pull-right form-control"  value="Search"/>
			</form>
			</div>
			
		</div>
		</div>
	</div>
	<hr/>

	
		
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
	
	<div class = "container">
   		<h3> 검색상품 </h3>
   		
	     <c:if test="${!empty productlist}">
            <c:forEach var="vo" items="${productlist}">
              	  
              		
   				<div class="col-md-2 mr-5" style="height:100%, width:100%; border:1px solid #D6D6D6; overflow:hidden; ">
   					
                    	<c:if test = "${vo.base64 ne null }">
                    
	                    	<a href = "${pageContext.request.contextPath}/product/detail?prname=${vo.name}" >
	                    		<img src="data:image/png;base64,${vo.base64}" width="150px" height="150px"> <br/> </a>
	                    		
	                    		<hr style = "border-color: #D6D6D6"/>
	                    		
	                    	<a href = "${pageContext.request.contextPath}/product/detail?prname=${vo.name}" style="color:black" >
	                    		<div  style = " white-space : nowrap; overflow : hidden; text-overflow:ellipsis;  "> ${vo.name} </div> <br/> </a>
	                    		
	                    		<div style = "font-weight:bold;" > 
	                    			<fmt:formatNumber value="${vo.price}" pattern="###,###"/>원</div> <br/>
                    	</c:if>
                		<c:if test = "${vo.base64 eq null }">
                    		no image
                    	</c:if>
                    
                </div>
		  </c:forEach>
        </c:if>
            <c:if test="${empty productlist}"> 자료가 없습니다 </c:if>
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