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
<title>Mypage</title>
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
	

	<div style="padding:50px 50px 50px 500px;"> 
 		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div class="col-sm-1 mr-5" >
			<br/><br/><br/>
			<img src="${pageContext.request.contextPath}/resources/images/face.PNG" width = "100" height = "100" /> <br/>
           	<div  style = " white-space : nowrap;  text-overflow:ellipsis;"> 
           		&nbsp &nbsp  ${vo.name}님 <br/>

           	</div> <br/> 
        </div>

	
  	<div class="col-sm-6 ">
		<table class="table" style="border: 1px solid #cccccc">
			<thead>
			<h3>${vo.name}님 문의 내역 확인</h3>
				<tr>

					<th style="border: 1px solid #D6D6D6;">문의 날짜</th>
					<th style="border: 1px solid #D6D6D6;">문의 내역</th>
					<th style="border: 1px solid #D6D6D6;">문의 상품</th>
				
				</tr>
			</thead>

			<tbody>


				 <c:if test="${!empty qnalist}">
		                 <c:forEach var="vo" items="${qnalist}">
		                  <tr>
		                  		<td width = "100px">
		                  		<fmt:formatDate pattern="yyyy-MM-dd" value="${vo.date}"/>
		                  		</td>

				                 <td style="border:1px solid #D6D6D6;">
				                 <a href="${pageContext.request.contextPath}/product/detail?prname=${vo.product.name}" style="color:black;">
				                    	${vo.content} </a>
				                   </td>
				                
				                <c:if test = "${vo.product.base64 ne null }">
				                    <td style="border:1px solid #D6D6D6;" width="120px">
				                    	<a href="${pageContext.request.contextPath}/product/detail?prname=${vo.product.name}">
				                    		<img src="data:image/png;base64,${vo.product.base64}" width="100px" height="100px"/> </a>  
				                    
				                  </c:if>
				                 

				              	<c:if test = "${vo.product.base64 eq null }">
				              		<td style="border:1px solid #D6D6D6;">
               							no image
               						</td>
      							</c:if>  	     
				                    	     
				                    
				                </tr>
		                  
		                </c:forEach>
		            </c:if>
					 <c:if test="${empty qnalist}">
		                <tr>
		                    <td colspan="5">문의내역이 없습니다.</td>
		                </tr>
		            </c:if>
			</tbody>
		</table>
		</div>
	</div>
	</body>
</html>