<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>HOME</title>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
		 <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
		
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




	<div class = "container" style="width:1000px max-width:none !important;" >
   		<h3> 상품 상세 </h3>

			<form  action="${pageContext.request.contextPath}/product/order" method= "get" >
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div>
					  	<c:if test = "${vo.base64 ne null }">
						
						<div class="col-xs-4 mr-5" style="border:1px solid #D6D6D6; overflow:hidden; ">
	              		<img src="data:image/png;base64,${vo.base64}" width="300px" height="300px"> 
	              		</div>
	              				
           			   	</c:if>
	              		
	              		
	              		<div class="col-xs-6" style="font-size:20px;">
	              		
	              		 ${vo.name} <br/> <br/> 
	              		<input type="hidden" name = "prname" value = "${vo.name}"/>
	              		
	              		<div style = "font-weight:bold; font-size:30px;" > 	
	              			<div class = "col-xs-9">
	              			<fmt:formatNumber value="${vo.price}" pattern="###,###"/>원
	              			</div>
	              			
	              			<div class = "col-xs-3" style = "font-size:20px;">
	              				 <input type="number" name="count" class="pull-right form-control" value = "1" min ="1"/>
	              			</div>	
						</div>
						
						<br/><br/><br/><br/><br/><br/> <hr/> 
						
						
						<div class="col-xs-7" style="font-size:15px;">
							총 합계 금액 <br/><br/><br/><br/><br/>
							<security:authorize access="hasAuthority('ADMIN')">
							    <input type="button" value="주문하기" class="btn btn-success" onclick="button2();">
							    <input type="button" value="장바구니" class="btn btn-warning" onclick="button1();">
							    
							    <script>
								  function button2() {
									  alert("관리자는 주문 하실 수 없습니다.");
								  }
								  function button1() {
									  alert("관리자는 장바구니에 담으실 수 없습니다.");
								  }
							    </script>
						    </security:authorize>
						    
						    <security:authorize access="!hasAuthority('ADMIN')">
							    <input type="submit" value="주문하기" class="btn btn-success" formaction="${pageContext.request.contextPath}/product/order">
							    <input type="submit" value="장바구니" class="btn btn-warning" formaction = "${pageContext.request.contextPath}/mypage/cart" formmethod= "post">
						    </security:authorize>
						    
						</div>
	              		<div class="col-xs-5" style="font-size:30px; float:right; color:blue; font-weight:bold;">
							<label id="total">	<fmt:formatNumber value="${vo.price*1}" pattern="###,###" /></label>원 <br />
					
						</div>	
	              			 <br/>
	              		</div>

              		</div>
              	
             	</form> 		
 
 		
	
           		<c:if test = "${vo.base64 eq null }">
               		no image
               	</c:if>
  
				
            <c:if test="${empty vo}"> 자료가 없습니다 </c:if>
	</div>
	




	<form  action="${pageContext.request.contextPath}/product/detail?prname=${vo.name}" method= "post" >
		
				
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />             	
		   	<div class= "container" style="width:1000px max-width:none !important;">
		   		<div style = "float :left;">	
		   			<a href = "#contnet"> <h3> 상품설명 &nbsp </h3></a>	
		   		</div>
		   		<div style = "float :left;">	
		   			<a href = "#QNA"> <h3> 상품문의 </h3></a>
		   		</div>
		   		
		   		<br/><br/><hr/>
		   		<a name = "contnet"></a>	
		   			<p style = "font-size:large; font-weight:bold; ">상품설명</p>
		   		<hr/>
		  	 		${fn:replace(vo.contents, newLineChar, "<br />")} 		
		  		<hr/>
		   		
		   			<p style = "font-size:large; font-weight:bold; ">상품문의</p>
		   		<hr/>
		   		
		   		<a name = "QNA"></a>
		   			<div class="form-group">
			             <div class="col-sm-6 text-left" >
							
							  <security:authorize access="hasAuthority('ADMIN')">
			             	   	<textarea name="content" rows="5" placeholder="상품문의 사항을 입력하세요." class="form-control" style="width:1100px;" required></textarea>
				             	  <br/>
				             	  <input type="button" value="등록"  class="btn btn-secondary" onclick="button();"> <hr style="width:1100px;"/>
				             	  
				             	  <script>
					             	  function button() {
					             		  alert("관리자는 상품문의를 하실 수 없습니다.");
					             	  }
				             	  </script>
				             	  
			             	  </security:authorize>
			             	  
							 <security:authorize access="!hasAuthority('ADMIN')">
					             <textarea name="content" rows="5" placeholder="상품문의 사항을 입력하세요." class="form-control" style="width:1100px;" required></textarea>
					             <br/>
					             <input type="submit"  value="등록" class="btn btn-secondary"> <hr style="width:1100px;"/>
							</security:authorize>
			             	  
			             	  
			             </div>
		      		</div>
		      		
		      		 <c:if test="${!empty qna}">
		      		 
				      	<div class="form-group">
				      	 	<div class="col-sm-10 mr-2 text-left" >
				      	 
				      	 	<c:forEach var="qnavo" items="${qna}">
					      	 	<div class = "col-sm-2">
					      	 		<img src="${pageContext.request.contextPath}/resources/images/face.PNG" width = "80" height = "80" /> <br/>
					      	 	</div>
					      	 				
					      	 	<div class = "col-sm-10">
					      	 		
					      	 		<div class = "col-mr-5" style = "color : darkblue; font-weight: bold ; font-size:15px;">
				      	 				 <div class ="col-sm-9">
				      	 				 	${qnavo.member.memname}님
				      	 				 </div>
				      	 				 
				      	 				  <c:if test="${qnavo.member.memname eq vo2.memname}">
					      	 				 <div class ="col-sm-3 col-sm-push-3">
					      	 				 	<a href = "${pageContext.request.contextPath}/product/detail/delete?no=${qnavo.no}&prname=${vo.name}">삭제</a> <br/><br/>	
					      	 				 </div>
				      	 				 </c:if>
				      	 				  <c:if test="${qnavo.member.memname ne vo2.memname}">
					      	 				 <div class ="col-sm-3">
					      	 				 		<br/><br/>
					      	 				 </div>
				      	 				 </c:if>
				      	 				  
						   			</div>
						   			
						   			
						   			<div class = "col-mr-5 ">
						   				<div class ="col-sm-9">
							   				${qnavo.content} <br/><hr style="width:900px;"/>
							      		</div>
							      		<div class ="col-sm-3 col-sm-push-3">
							      			<fmt:formatDate pattern="yyyy-MM-dd" value="${qnavo.date}"/>	
							      		</div>
							      		
							      	</div>

					      		</div>

					      	</c:forEach>
					      	
				      		</div>
				      	</div>	
			      	
			      	</c:if>
			 		 <c:if test="${empty qna}">
		                
		                   <h3>문의사항이 없습니다</h3>
		                
		            </c:if>
		      		
		      </div>	

   	</form>
   	
   	
   	<!-- 사이트 정보 footer  -->

    <div class="jumbotron text-center mt-5 mb-0" style = "height: 30px; width: 100%;">
    	<p> Spring Project / Designed by <span style="font-weight:bold;">전하정</span> 
    	<br/>
    </div>
   	
   
   
   <script  src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	$(function(){
		$.numberWithComma = function(x) {
			return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");//내용
		}
			
		$("input[name='count']").change(function(){
			var price =Number('${vo.price}');
			var count = Number($(this).val());
			$('#total').text( $.numberWithComma (count*price) )
		}); 
	});
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