<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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


<br/><br/>

	<!-- 사이트 배너  -->
	<div class = "container">
		<div class="container-fluid full-width">
		<div class="row">	
			
			<div class="col-md-6">
			<a href = "${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/images/Spring.PNG" width = "200" height = "80" /> </a>
			</div>
						
		</div>
		</div>
	</div>
	
	


<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수
 
                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;
 
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }
 
                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }
 
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;
 
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_address2').focus();
            }
        }).open();
    }
</script> 
 
<hr/>


<div class="row">
     
    <div class="col-xs-12 col-sm-12">
    <h2>&nbsp;</h2> 
    <h2 class="text-center">회원가입</h2>
    </div>        
     
    <div class="col-xs-3 col-sm-3"></div>   
    <div class="col-xs-8 col-sm-8">
         
      <div >      
        <p>&nbsp;</p>
         
        <form class="form-horizontal" action="${pageContext.request.contextPath}/member/join" method="post">
        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
         <div class="form-group">
            <div class="col-sm-2 control-label">
                <label for="id">아이디</label>
            </div>
            <div class="col-sm-6 text-left">
                <input type="text" class="form-control" name="memname" id="memname" placeholder="아이디" required>
            </div>
         </div>
          
         <div class="form-group">
            <div class="col-sm-2 control-label">
                <label id="pw">패스워드</label>
            </div>
            <div class="col-sm-6">
                <input type="password" class="form-control" name="mempassword" id="mempassword" placeholder="패스워드" required>
            </div>
         </div>
          

         
         <div class="form-group">
            <div class="col-sm-2 control-label">
                <label id="name">이름</label>
            </div>
            <div class="col-sm-6">
                <input type="text" class="form-control" name="name" id="name" placeholder="이름" required>
            </div>
         </div>        
          
         <div class="form-group">
            <div class="col-sm-2 control-label">
                <label id="email">이메일</label>
            </div>
            <div class="col-sm-6">
                <input type="email" class="form-control" name="email" id="email" placeholder="이메일">
            </div>
         </div>   
      
          
          <div class="form-group">
            <div class="col-sm-2 control-label">
                <label id="zip_num">우편번호</label>
            </div>
            <div class="col-sm-3">
             <input type="text" id="sample6_postcode" placeholder="우편번호"  name="zip_num" class="form-control" required >
            </div>
            <div class="col-sm-3">
            <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-primary">
          
            </div>
         </div>   
         
            <div class="form-group" >
             <div class="col-sm-2 control-label">
                <label id="address1">주소</label>
             </div>
             <div class="col-sm-6">
                <input type="text" id="sample6_address" placeholder="주소"  name="address1"   class="form-control" required>
             </div>   
           </div>
      
          <div class="form-group"> 
             <div class="col-sm-2 control-label">
                <label id="address1">상세주소</label>
             </div>
             <div class="col-sm-6"> 
               <input type="text" id="sample6_address2" placeholder="상세주소" name="address2"   class="form-control" required>
               </div>
          </div>
          
     
 
          <div class="form-group">
            <div class="col-sm-2 control-label">
                <label id="phone">전화번호</label>
            </div>
            <div class="col-sm-6">
                <input type="text" class="form-control" name="phone" id="phone" placeholder="전화번호" required>
            </div>
         </div>
          
           
          <div class="form-group">
            <div class="col-sm-2 control-label">
                <label id="role">권한</label>
            </div>
            <div class="col-sm-6">
               <select name="role" class="form-control" >
               	<option value="ADMIN" >관리자</option>
               	<option value="USER">회원</option>
               </select>
            </div>
         </div>
         
         <input type="hidden" name="ip" value="${GetIpAddress.getIp()}">
         <div class="form-group" >
            <div class="col-sm-9  text-center">
            <input type="submit" value="회원가입" class="btn btn-success">
            <input type="reset" value="취소" class="btn btn-warning">
            </div>
         </div>
         
         
        </form> 
      </div>
    </div>
 
</div>
 
 
 




</body>
</html>