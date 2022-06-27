package egovframework.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import egovframework.example.service.LottoService;

@Controller
public class LottoController {
	
	@Resource(name="lottoService")
	private LottoService lottoService;
	
	@RequestMapping("/login.do")
	public String loginPage() throws Exception {
		return "login";
	}
	
	@RequestMapping("/signUp.do")
	public String signUpPage() throws Exception {
		return "signUp";
	}
	
	@RequestMapping(value="/post", method=RequestMethod.POST)
	public void testPost(@RequestBody HashMap<String, Object> map) throws Exception { 
		//List<Map> nameModel = lottoService.getName();
		System.out.println(map);
		
	}
	
	@RequestMapping("/view.do")
	public ModelAndView dbPage(ModelAndView mav) throws Exception { 
        
		List<Map> nameModel = lottoService.getName();
		
		mav.setViewName("view");
		
		return mav;
	}
	
}
