package com.shopproject.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Base64;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.shopproject.entity.Kategorie;
import com.shopproject.entity.Member;
import com.shopproject.entity.Notice;
import com.shopproject.entity.Product;
import com.shopproject.repository.KategorieRepository;
import com.shopproject.repository.MemberRepository;
import com.shopproject.repository.NoticeRepository;
import com.shopproject.repository.ProductRepository;
import com.shopproject.security.MyUser;



@Controller
@RequestMapping(value = "/member")
public class SecurityController {
	@Autowired
	KategorieRepository kRepository;
	
	@Autowired
	MemberRepository mRepository;
	
	@Autowired
	ProductRepository pRepository;

	@Autowired
	NoticeRepository nRepository;
	
	@RequestMapping(value = { "/login" })
	public String loginGET(Model model) {
		
		List<Kategorie> kategorieList = kRepository.findAll();
		model.addAttribute("kategorieList", kategorieList);
		
		return "login";
	}
	
	
	@RequestMapping(value= {"/login"}, method = RequestMethod.POST)
	public String loginPOST(HttpSession httpSession,
			@RequestParam(value="id") String id,
			@RequestParam(value="pw") String pw) {
		System.out.println(id);
		
		Member vo = mRepository.findAllByIdAndPw(id,pw);
		
		if(vo != null) {
			httpSession.setAttribute("MEMID", vo.getMemname());
			httpSession.setAttribute("MEMNAME", vo.getName());
		}
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String joinGET(Model model) {
		List<Kategorie> kategorieList = kRepository.findAll();
		model.addAttribute("kategorieList", kategorieList);
		
		return "join";
	}

	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinPOST(@ModelAttribute Member vo) {
		BCryptPasswordEncoder bcpe = new BCryptPasswordEncoder();
		String changePw = bcpe.encode(vo.getMempassword());
		vo.setMempassword(changePw);
		mRepository.save(vo);
		return "redirect:/home";
	}
	
	@RequestMapping(value = { "/logout" })
	public String logoutGET(Model model) {
		
		List<Kategorie> kategorieList = kRepository.findAll();
		model.addAttribute("kategorieList", kategorieList);
		
		return "home";
	}
	
	@RequestMapping(value = "/mypage/admin")
	public String  adminGET(Authentication auth, Model model) {
		// ??????????????? ?????????
		if (auth != null) {

			// ???????????? ??????
			List<Kategorie> kategorieList = kRepository.findAll();


			model.addAttribute("kategorieList", kategorieList);

			// ???????????????
			MyUser user = (MyUser) auth.getPrincipal();
			if (user != null) {
				System.out.println(user.getUsername());
				System.out.println(user.getName()); // ????????? ?????????
				model.addAttribute("vo", user);
				
				String id = user.getMemname();
				List<Product> productlist = pRepository.findByMember_Memname(id); // memberid??? product ????????? ??????.

				for (Product vo : productlist) {
					if (vo.getImg() != null) {
						String tmp1 = Base64.getEncoder().encodeToString(vo.getImg());
						vo.setBase64(tmp1);
						vo.setImg(null);

					}
				}

				model.addAttribute("productlist", productlist);

			}

			return "mypage_admin";

		} else {
			return "redirect:/member/login";
		}


	}

	
	@RequestMapping(value = "/mypage/admin/delete")
	public String deleteGET(@RequestParam(value="name") String name) {
		pRepository.deleteByName(name);
		return "redirect:/member/mypage/admin";
	}
	

	
	@RequestMapping(value = "/notice/admin")
	public String noticeGET(
						Model model,
						@RequestParam(value = "txt", defaultValue = "", required=false) String txt,
						@RequestParam(value="page", defaultValue="0") int page) throws UnsupportedEncodingException {
		

		// page url??? ?????? param ?????? ??????
		if(page == 0) {
			return "redirect:/member/notice/admin?txt=" + URLEncoder.encode(txt, "UTF-8")  + "&page=1"; // ????????????          
		}
		// ?????? ????????? ??????
		// List<Item1> list = iRepository.findAllByOrderByNoDesc(); 
		
		PageRequest pageable = PageRequest.of(page-1, 10);
		
		List<Notice> list = nRepository.findAllByTitleIgnoreCaseContainingOrderByNoDesc(txt, pageable); 
		model.addAttribute("noticelist",list);

	
		
		// ?????? ????????? ??? ?????? 1=>1, 13=>2, 24=>3
		long totPages = nRepository.countByTitleIgnoreCaseContaining(txt);
		model.addAttribute("totPages", (totPages-1)/10+1);
		
		

		
		return "notice_admin";
	}
	
	@RequestMapping(value = "/notice/admin" ,  method = RequestMethod.POST)
	public String noticePOST(
			@RequestParam(value = "content") String content,
			@RequestParam(value = "title") String title,
			@ModelAttribute Notice vo) {
		
		vo.setContent(content);
		vo.setTitle(title);
		nRepository.save(vo);
		return "redirect:/member/notice/admin";
	}
	
	@RequestMapping(value = "/notice/admin/delete")
	public String ndeleteGET(@RequestParam(value="no") Long no) {
		nRepository.deleteById(no);
		return "redirect:/member/notice/admin";
	}
	
	@RequestMapping(value = "/notice/admin/update")
	public String nupdateGET(@RequestParam(value="no") Long no, Model model) {
		Optional<Notice> notice = nRepository.findById(no);
		Notice vo = notice.get();
		model.addAttribute("vo", vo);
		
		return "notice_admin_update";
	}
	
	@RequestMapping(value = "/notice/admin/update", method = RequestMethod.POST)
	public String nupdatePOST(@ModelAttribute Notice vo, @RequestParam(value="no") Long no) {
	
		nRepository.save(vo);
		
		return "redirect:/member/notice/admin";
	}
}
