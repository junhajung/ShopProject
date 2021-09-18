package com.shopproject.security;

import java.io.IOException;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class MyLoginHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(
			HttpServletRequest request, 
			HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		//세션 객체 만들기 => aop를 통해서 보관되어 마지막 페이지를 가져와야 함.!!
		HttpSession httpSession = request.getSession();
		
		//User또는 MyUser
		User user = (User) authentication.getPrincipal();
		
		//로그인 되었으면
		if(user != null) {
			//System.out.println("아이디 : " + user.getUsername());
			//System.out.println("이름 : " + user.getName());
			Collection<GrantedAuthority> roles= user.getAuthorities();
			for(GrantedAuthority tmp : roles) { //1번만 수행됨.
				System.out.println("권한 : " + tmp.getAuthority());
				
				String url = request.getContextPath() + "/";
				if (tmp.getAuthority().equals("ADMIN")) {
			
					url = request.getContextPath() ;
				}

				else if (tmp.getAuthority().equals("USER")) {
					
					String backUrl = (String)httpSession.getAttribute("CURRENT_URL");
					System.out.println("ccccccccccccc" + backUrl);
					url = request.getContextPath() + backUrl;
				}
				
				//페이지 이동하기
				response.sendRedirect(url);
			}
		}
		
		
	}
}