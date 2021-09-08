package com.example.controller;

import java.io.IOException;
import java.util.Base64;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.entity.Cart;
import com.example.entity.Kategorie;
import com.example.entity.Member;
import com.example.entity.Order;
import com.example.entity.Product;
import com.example.entity.QNA;
import com.example.repository.CartRepository;
import com.example.repository.KategorieRepository;
import com.example.repository.MemberRepository;
import com.example.repository.OrderRepository;
import com.example.repository.ProductRepository;
import com.example.repository.QnaRepository;
import com.example.security.MyUser;

@Controller
@RequestMapping(value = "/mypage")
public class MypageController {
	@Autowired
	ProductRepository pRepository;
	
	@Autowired
	KategorieRepository kRepository;
	
	@Autowired
	OrderRepository oRepository;

	@Autowired
	MemberRepository mRepository;

	@Autowired
	CartRepository cRepository;
	
	@Autowired
	QnaRepository qRepository;
	
	@RequestMapping(value = "/insert")
	public String insertGET(Model model) {
		List<Kategorie> kategorieList = kRepository.findAll();
		model.addAttribute("kategorieList", kategorieList);
		
		
		return "mypage_insert"; //jsp만들기
	}
	

	
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insertPOST(
			@ModelAttribute Product vo, 
			@RequestParam("img1") MultipartFile file,
			Authentication auth,
			@RequestParam(value = "kateid") long kateid) throws IOException {
		
		// 회원정보
		 MyUser user = (MyUser)auth.getPrincipal();
		 String id = user.getMemname();
		 Member vo1 = mRepository.findByMemname(id);	
		 
		 
		
		// 이미지
		if(file.getBytes().length > 0) { //파일이 첨부되었다면
			vo.setImg(file.getBytes());
		}
		
		Optional<Kategorie> kate = kRepository.findById(kateid);
		
		vo.setMember(vo1);
		vo.setKate(kate.get());
		

		
		pRepository.save(vo);

		
		
		//DB처리
		return "redirect:/member/mypage/admin"; 
	}
	
	@RequestMapping(value = "/select", method = RequestMethod.GET)
	public String home1(Authentication auth, Model model) {

		// 회원정보를 넘겨줌
		if (auth != null) {

			// 카테고리 내용
			List<Kategorie> kategorieList = kRepository.findAll();
			model.addAttribute("kategorieList", kategorieList);

			// 사용자정보
			MyUser user = (MyUser) auth.getPrincipal();
			if (user != null) {
				System.out.println(user.getUsername());
				System.out.println(user.getName()); // 추가된 사용자
				model.addAttribute("vo", user);

				String id = user.getMemname();
				List<Order> orderlist = oRepository.findByMember_Memname(id); // memberid로 order 속에서 찾음.

				for (Order tmp : orderlist) {
					Product vo = tmp.getProduct();
					if (vo.getImg() != null) {
						String tmp1 = Base64.getEncoder().encodeToString(vo.getImg());
						vo.setBase64(tmp1);
						vo.setImg(null);

					}
				}

				model.addAttribute("orderlist", orderlist);

			}

			return "mypage_select";

		} else {
			return "redirect:/member/login";
		}

	}
	
	
	@RequestMapping(value = "/cart")
	public String cartGET(Authentication auth, Model model) {
		if(auth == null) {
			return "redirect:/member/login";
		}
		
		// 카테고리 내용
		List<Kategorie> kategorieList = kRepository.findAll();
		model.addAttribute("kategorieList", kategorieList);

		// 사용자정보
		MyUser user = (MyUser) auth.getPrincipal();
		if (user != null) {
			System.out.println(user.getUsername());
			System.out.println(user.getName()); // 추가된 사용자
			model.addAttribute("vo", user);

			String id = user.getMemname();
			List<Cart> cartlist = cRepository.findByMember_Memname(id); // memberid로 order 속에서 찾음.

			for (Cart tmp : cartlist) {
				Product vo = tmp.getProduct();
				if (vo.getImg() != null) {
					String tmp1 = Base64.getEncoder().encodeToString(vo.getImg());
					vo.setBase64(tmp1);
					vo.setImg(null);

				}
			}

			model.addAttribute("cartlist", cartlist);

		}

		return "mypage_cart"; 

	}
	

	@RequestMapping(value = "/cart" , method = RequestMethod.POST)
	public String cartPOST(
			Model model,
			@RequestParam(value="prname") String prname,
			@RequestParam(value="count") Long count,
			Authentication auth
			){
	
		if(auth == null) {
			return "redirect:/member/login";
		}
		

		// 회원정보
		 MyUser user = (MyUser)auth.getPrincipal();
		 String id = user.getMemname();
		 Member vo1 = mRepository.findByMemname(id);	 
		
		
		// 외래키로 걸었던 항목들을 객체화
		Product vo = pRepository.findByName(prname); // 제품객체		

	
		Cart vo2 = new Cart();
		vo2.setCount(count);
		vo2.setCartid(0L);
		vo2.setMember(vo1);
		vo2.setProduct(vo); // member

		cRepository.save(vo2);

		return "redirect:/mypage/cart";
	}
	
	@RequestMapping(value = "/cart/delete")
	public String deleteGET(@RequestParam(value="no") long no) {
		cRepository.deleteById(no);
		return "redirect:/mypage/cart";
	}
	
	@RequestMapping(value = "/delete")
	public String memdeleteGET(@RequestParam(value="no") String no, HttpSession session) {
		mRepository.deleteByName(no);
		
		session.invalidate(); // 회원탈퇴 후 세션을 초기화 시켜서 로그아웃 시킴.
		
		return "redirect:/";
	}

	@RequestMapping(value = "/qna", method = RequestMethod.GET)
	public String qnaGET(Model model, Authentication auth) {
		// 카테고리 내용
		List<Kategorie> kategorieList = kRepository.findAll();
		model.addAttribute("kategorieList", kategorieList);

		// 사용자정보
		MyUser user = (MyUser) auth.getPrincipal();
		if (user != null) {
			model.addAttribute("vo", user);
		}
			
		String id = user.getMemname();
		List<QNA> qnalist = qRepository.findByMember_Memname(id); // memberid로 order 속에서 찾음.
		
		for (QNA tmp : qnalist) {
			Product vo = tmp.getProduct();
			if (vo.getImg() != null) {
				String tmp1 = Base64.getEncoder().encodeToString(vo.getImg());
				vo.setBase64(tmp1);
				vo.setImg(null);

			}
		}

		model.addAttribute("qnalist", qnalist);

		
		return "mypage_qna";
	}
}
