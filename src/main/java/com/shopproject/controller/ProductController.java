package com.shopproject.controller;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.shopproject.entity.Cart;
import com.shopproject.entity.Kategorie;
import com.shopproject.entity.Member;
import com.shopproject.entity.Order;
import com.shopproject.entity.Product;
import com.shopproject.entity.QNA;
import com.shopproject.repository.CartRepository;
import com.shopproject.repository.KategorieRepository;
import com.shopproject.repository.MemberRepository;
import com.shopproject.repository.OrderRepository;
import com.shopproject.repository.ProductRepository;
import com.shopproject.repository.QnaRepository;
import com.shopproject.security.MyUser;


@Controller
@RequestMapping(value = "/product")
public class ProductController {
	@Autowired
	ProductRepository pRepository;
	
	@Autowired
	MemberRepository mRepository;
	
	@Autowired
	KategorieRepository kRepository;
	
	@Autowired
	CartRepository cRepository;
	
	@Autowired
	OrderRepository oRepository;
	
	@Autowired
	QnaRepository qRepository;
	

	
	
	@RequestMapping(value = "/select")
	public String selectGET(Model model,
			@RequestParam(value = "txt", defaultValue = "", required=false) String txt,
			@RequestParam(value="page", defaultValue="0") int page) throws UnsupportedEncodingException {
	
		List<Product> productlist = pRepository.findAllByNameIgnoreCaseContaining(txt);

	
		for(Product vo : productlist) {
		
			if(vo.getImg() != null) {
				String tmp = Base64.getEncoder().encodeToString(vo.getImg());
				vo.setBase64( tmp );
				vo.setImg(null); 
			}
		}
		model.addAttribute("productlist", productlist);
		
		// ???????????? ??????
		List<Kategorie> kategorieList = kRepository.findAll();
		System.out.println(kategorieList.get(0).getId());
		model.addAttribute("kategorieList", kategorieList);
		
		return "product_select";
	}
	
	@RequestMapping(value = "/select1")
	public String select1GET(Model model,
			@ModelAttribute Product vo1,
			@RequestParam(value="id") int id) throws UnsupportedEncodingException {
	
		
		List<Product> katelist = pRepository.findAllByKate(id);
	
		for(Product vo : katelist) {
	
			if(vo.getImg() != null) {
				String tmp = Base64.getEncoder().encodeToString(vo.getImg());
				vo.setBase64( tmp );
				vo.setImg(null); 
			}
		}
		
		model.addAttribute("katelist", katelist);
		
		// ???????????? ??????
		List<Kategorie> kategorieList = kRepository.findAll();
		System.out.println(kategorieList.get(0).getId());
		model.addAttribute("kategorieList", kategorieList);
		
		// product/selet?id=1 ????????? id ?????? ???????????? ?????? kateid?????? ??????

		return "product_select1";
	}
	
	

	
	@RequestMapping(value = "/detail")
	public String detailGET(Model model,
			@RequestParam(value="prname") String prname,
			Authentication auth
			) throws UnsupportedEncodingException {
	
		
		// ?????? ??????
		Product vo = pRepository.findByName(prname);
		if(vo.getImg() != null) {
			String tmp = Base64.getEncoder().encodeToString(vo.getImg());
			vo.setBase64( tmp );
			vo.setImg(null); 
	
		}
		model.addAttribute("vo", vo);
		
		// ???????????? ??????
		List<Kategorie> kategorieList = kRepository.findAll();
		System.out.println(kategorieList.get(0).getId());
		model.addAttribute("kategorieList", kategorieList);
		
		if(auth != null) {
		
			// qna ?????? ?????????
			List<QNA> qna = qRepository.findByProduct_Name(prname);
			model.addAttribute("qna", qna);
			
			MyUser user = (MyUser)auth.getPrincipal();
			String id = user.getMemname();
			Member vo2 = mRepository.findByMemname(id);
			model.addAttribute("vo2",vo2);
	

		}
		return "product_detail";
			
		
	}
	
	@RequestMapping(value = "/detail" , method = RequestMethod.POST)
	public String detailPOST(
			@ModelAttribute QNA vo,
			Authentication auth,
			Model model,
			@RequestParam(value="prname") String prname,
			@RequestParam(value="content") String content) throws UnsupportedEncodingException {
		
		if(auth == null) {
			return "redirect:/member/login";
		}

		else {
			MyUser user = (MyUser)auth.getPrincipal();
	
			// ?????? ????????? ?????? ?????? ????????? vo??? ??????
			Product vo1 = pRepository.findByName(prname);	
	
			// ????????????
			
			String id = user.getMemname();
			Member vo2 = mRepository.findByMemname(id);
			
			vo.setContent(content);
			vo.setProduct(vo1);
			vo.setMember(vo2);
			qRepository.save(vo);
			
			return "redirect:/product/detail?prname=" + URLEncoder.encode(prname , "utf-8");

		}
	}
	

	
	
	@RequestMapping(value = "/order")
	public String orderGET(
			Model model,
			@RequestParam(value="prname") String prname,
			@RequestParam(value="count") Long count,
			Authentication auth
			){
		
		// ????????? ???????????? ??????
		if(auth == null) {
			return "redirect:/member/login";
		}

		// ?????? ????????? ?????? ?????? ????????? vo??? ??????
		Product vo = pRepository.findByName(prname);		
		
		// ???????????????
		if(vo.getImg() != null) {
			String tmp = Base64.getEncoder().encodeToString(vo.getImg());
			vo.setBase64( tmp );
			vo.setImg(null); 
	
		}
		model.addAttribute("vo", vo); // ????????????
		model.addAttribute("count", count); //  ????????????
		
		return "product_order";
	}
	
	// ?????????????????? ??????
	@RequestMapping(value = "/order" , method = RequestMethod.POST)
	public String orderPOST(
			Model model,
			@RequestParam(value="chBox") Long[] cartid,
			Authentication auth
			){

		// ????????????
		 MyUser user = (MyUser)auth.getPrincipal();
		 String id = user.getMemname();
		 Member vo1 = mRepository.findByMemname(id);	 

		for(int i=0; i<cartid.length; i++) {
			Cart cart = cRepository.getOne(cartid[i]);
			
			Order vo2 = new Order();
			vo2.setCount(cart.getCount());
			vo2.setProduct(cart.getProduct());
			vo2.setMember(vo1);
			
			oRepository.save(vo2);
			cRepository.deleteById(cartid[i]);
			
		}
	
		return "redirect:/";
	}
	
	
	// ?????? ??????
	@RequestMapping(value = "/order1" , method = RequestMethod.POST)
	public String order1POST(
			Model model,
			@RequestParam(value = "count") Long count,
			@RequestParam(value = "prname") Product prname,
			Authentication auth){

		// ????????????
		 MyUser user = (MyUser)auth.getPrincipal();
		 String id = user.getMemname();
		 Member vo1 = mRepository.findByMemname(id);	 

		
			
		Order vo2 = new Order();
		vo2.setCount(count);
		vo2.setProduct(prname);
		vo2.setMember(vo1);
		
		oRepository.save(vo2);
			
		return "redirect:/";
	}
	

	@RequestMapping(value = "/detail/delete")
	public String deleteGET(
			@RequestParam(value = "no") Long no,
			@RequestParam(value="prname") String prname) throws UnsupportedEncodingException  {
		qRepository.deleteById(no);
	
		return "redirect:/product/detail?prname=" + URLEncoder.encode(prname , "utf-8");
	}


}
