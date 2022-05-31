package egovframework.example.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.example.service.LottoService;

@Controller
public class LottoController {
	
	@Resource(name="lottoService")
	private LottoService lottoService;
	
	@RequestMapping("/view.do")
	public ModelAndView dbPage(ModelAndView mav) throws Exception { 
        
		List<Map> nameModel = lottoService.getName();
		
		mav.addObject("name", nameModel); 
		mav.setViewName("view");
		
		return mav;
	}
	
}
