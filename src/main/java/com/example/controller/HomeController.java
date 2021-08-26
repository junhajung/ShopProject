package com.example.controller;



import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.entity.Kategorie;
import com.example.entity.Notice;
import com.example.entity.Product;
import com.example.repository.KategorieRepository;
import com.example.repository.NoticeRepository;
import com.example.repository.ProductRepository;


@Controller
public class HomeController {
	
	@Autowired
	ProductRepository pRepository;
	
	@Autowired
	KategorieRepository kRepository;
	
	@Autowired
	NoticeRepository nRepository;
	
	@RequestMapping(value = {"/home", "/main", "/"})
	public String homeGET(Model model) {
		
		List<Product> list = pRepository.findAll();

		for(Product vo : list) {
			if(vo.getImg() != null) {
				String tmp = Base64.getEncoder().encodeToString(vo.getImg());
				vo.setBase64( tmp );
				vo.setImg(null); 
			}
		}
		Collections.shuffle(list);

		
		// 요즘 뜨는 가전/디지털
		List<Product> prolist = pRepository.findAllByKate(9);
		for(Product vo1 : prolist) {
			if(vo1.getImg() != null) {
				String tmp = Base64.getEncoder().encodeToString(vo1.getImg());
				vo1.setBase64( tmp );
				vo1.setImg(null); 
			}
		}
		Collections.shuffle(prolist);	

		
		List<Product> list1 = new ArrayList<Product>();
		
		// random으로 돌린 값 중 prolist에서 출력된 값이면 list에서 미출력. (remove)
		for(int i=0; i<list.size(); i++) { // 전체반복
			int n=0;
			for(int j=0; j<prolist.size(); j++) { // 일부부분 반복
				if(list.get(i).getName().equals(prolist.get(j).getName())) { // 일치확인
					n=1;
					//list.remove(i); // 제거
					break;
				}
			}
			if(n == 0) { // 같은게 x
				list1.add(list.get(i));
			}
			
		}
		model.addAttribute("list", list1);
		model.addAttribute("prolist", prolist);
		
		
		List<Kategorie> kategorieList = kRepository.findAll();
		model.addAttribute("kategorieList", kategorieList);
		
		return "home";
	}


	@RequestMapping(value = "/notice")
	public String noticeGET(
						Model model,
						@RequestParam(value = "txt", defaultValue = "", required=false) String txt,
						@RequestParam(value="page", defaultValue="0") int page) throws UnsupportedEncodingException {
		// page url에 기본 param 값을 추가
		if(page == 0) {
			return "redirect:/notice?txt=" + URLEncoder.encode(txt, "UTF-8")  + "&page=1"; // 한글처리          
		}
		// 전체 목록을 정렬
		// List<Item1> list = iRepository.findAllByOrderByNoDesc(); 
		
		PageRequest pageable = PageRequest.of(page-1, 10);
		
		List<Notice> list = nRepository.findAllByTitleIgnoreCaseContainingOrderByNoDesc(txt, pageable); 
		model.addAttribute("noticelist",list);

		List<Kategorie> kategorieList = kRepository.findAll();
		model.addAttribute("kategorieList", kategorieList);
		
		// 전체 피이지 수 계산 1=>1, 13=>2, 24=>3
		long totPages = nRepository.countByTitleIgnoreCaseContaining(txt);
		model.addAttribute("totPages", (totPages-1)/10+1);
				
		
		return "notice";
	}
	
	@RequestMapping(value = "/notice/detail")
	public String noticedetailGET(
						Model model,
						@RequestParam(value = "no") Long no) {
		
		Notice notice = nRepository.findAllById(no);
		model.addAttribute("notice", notice);
	
		List<Kategorie> kategorieList = kRepository.findAll();
		model.addAttribute("kategorieList", kategorieList);
		
		return "notice_detail";
	}
	
//	
//	Notice notice = nRepository.findAllById(no);
//	model.addAttribute("notice", notice);
//	
//	return "notice_detail";
	
}
