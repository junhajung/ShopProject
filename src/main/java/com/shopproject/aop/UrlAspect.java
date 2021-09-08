package com.example.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Component
@Aspect
public class UrlAspect {

	// 모든 controller를 방문시 수행
	@Around("execution(* com.example.controller.*Controller.*(..))")
	public Object sessionLog(ProceedingJoinPoint joinPoint) throws Throwable {
		
		//request 객체 가져오기
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		
		//session 객체 가져오기
		HttpSession httpSession = request.getSession();
		
		//controller 수행시 표시되는 url정보를 가져옴.
		//ex) 127.0.0.1:9090/ROOT/member/main?userid=aaaa
		String path = request.getServletPath(); // /member/main
		String query = request.getQueryString(); // userid=aaaa
			
		//제거할 url정보
		if(!path.startsWith("/member/login") && !path.startsWith("/member/logout")) {
			//세션에 url정보를 추가함.
			if(query == null) {
				System.out.println("aaa" + path);
				httpSession.setAttribute("CURRENT_URL", path);
			}
			else {
				System.out.println("bbbb" + path + "?" + query);
				httpSession.setAttribute("CURRENT_URL", path + "?" + query);
			}
			
		}
		
		return joinPoint.proceed();
	}
}
