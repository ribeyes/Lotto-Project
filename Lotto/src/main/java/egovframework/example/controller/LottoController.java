package egovframework.example.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.example.service.LottoService;
import egovframework.example.vo.User;

@Controller
public class LottoController {
	 
	@Resource(name="lottoService")
	private LottoService lottoService;
	
	/* 로그인 페이지 호출*/
	@RequestMapping("/login.do")
	public String loginPage() throws Exception {
		return "login";
	}
	
	/* 회원가입 페이지 호출*/
	@RequestMapping("/signUp.do")
	public String signUpPage() throws Exception {    
		return "signUp";
	}
	
	/* 코드 테스트 용 */
	@RequestMapping(value="/test.do")
	public String testPage(User user) throws Exception {
		List<User> userAccount = lottoService.getUser();
		
		//System.out.println(user.getId());
		return "refactory";
	}
	
	/* 로그인 시도 */
	@ResponseBody
	@RequestMapping(value="/loginAttempt.do", method=RequestMethod.POST)
	public String loginAttempt(User user) throws Exception { 
		List<User> account = lottoService.getUser();
		
		
		String userId;
		String userPw;
		for (int i = 0; i < account.size(); i++) {
			userId = account.get(i).getId();
			userPw = account.get(i).getPw();
			if(user.getId().equals(userId) && user.getPw().equals(userPw)) {
				return "true";
			}
		}
		
		return "false";
	}
	
	/* 회원가입 등록 */
	@ResponseBody
	@RequestMapping(value="/signUpRegister.do", method=RequestMethod.POST)
	public String signUpRegister(User user) throws Exception { 
		int test = lottoService.insertUser(user);
		if(test == 1) {
			System.out.println("DB 등록완료!");
			return "true";
		}
		else {
			System.out.println("실패!");
			return "false";
		}
	}
	
	/* 아이디 중복확인  */
	@ResponseBody
	@RequestMapping(value="/sameId.do", method=RequestMethod.POST)
	public String sameId(User user) throws Exception { 
		List<User> id = lottoService.getUser();
		
		String userId;
		for (int i = 0; i < id.size(); i++) {
			userId = id.get(i).getId();
			if(user.getId().equals(userId)) {
				return "true";
			}
		}
		
		return "false";
	}
	
	
	@RequestMapping("/view.do")
	public ModelAndView dbPage(ModelAndView mav) throws Exception { 
        
		List<User> nameModel = lottoService.getUser();
		
		mav.setViewName("view");
		
		return mav;
	}
	
}
