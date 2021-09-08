package com.example.security;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.entity.Member;
import com.example.repository.MemberRepository;



// 상속 또는 구현 기존에 제공해주는 클래스(security)를 개발자가 변경해서 사용할 것
@Service
public class MyUserDetailsService implements UserDetailsService{
	
	@Autowired
	MemberRepository mRepository;

	// 로그인을 누르면 아이디/암호가 전달됨
	// 아이디를 이용해서 로그인 사용자의 정보를 가져온 후 UserDetails로 리턴하면 security가 비교해서 로그인 처리
	@Override
	public UserDetails loadUserByUsername(String memname) throws UsernameNotFoundException {
		
		System.out.println(memname);
		Member obj = mRepository.findByMemname(memname);
		
		if(obj == null) {
			return null;
		}
		System.out.println(obj.getMemname() + "," + obj.getMempassword());
		String[] strRoles = {obj.getRole() };
		
		Collection<GrantedAuthority> roles = AuthorityUtils.createAuthorityList(strRoles);
		
		// 아이디와 권한만 세션에 들어감 + 이름, 가입일자
		return new MyUser(obj.getMemname(), obj.getMempassword(), roles, obj.getName());
	}
	
}
