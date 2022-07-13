package egovframework.example.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.example.service.LottoService;
import egovframework.example.vo.LottoInfo;
import egovframework.example.vo.User;

@Controller
public class LottoController {
	 
	@Resource(name="lottoService")
	private LottoService lottoService;
	
	/* 메인 페이지 호출*/
	@RequestMapping("/intro.do")
	public String introPage() throws Exception {
		return "intro";
	}
	
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
		System.out.println(account.get(0).getId());
		System.out.println(account.get(0).getPassword());
		for (int i = 0; i < account.size(); i++) {
			userId = account.get(i).getId();
			userPw = account.get(i).getPassword();
			if(user.getId().equals(userId) && user.getPassword().equals(userPw)) {
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
	
	/* 로또 회 차 정보 받아오기*/
	@ResponseBody
	@RequestMapping(value="/orderNum.do", method=RequestMethod.POST) 
	public String orderNum() throws Exception { 
		List<LottoInfo> lotto = lottoService.getLottoInfo();
		int lastOrder = lotto.get(lotto.size()-1).getOrder();
		  
		return lastOrder + 1 + ""; //현재 회 차 보내기
	}
	 
	/* 로또 지난 회 차 당첨번호 받아오기*/
	@ResponseBody
	@RequestMapping(value="/lastNum.do", method=RequestMethod.POST) 
	public String lastNum() throws Exception { 
		List<LottoInfo> lotto = lottoService.getLottoInfo(); 
		String lastNumber = lotto.get(lotto.size()-1).getPrzwin_no(); 
		System.out.println("지난 당첨번호: " + lastNumber);
		  
		return lastNumber; 
	}
	
	/* 로또 회 차, 당첨번호 DB에 저장*/
	@ResponseBody
	@RequestMapping(value="/lottoInfo.do", method=RequestMethod.POST) 
	public String lottoInfoInsert(LottoInfo lottoInfo) throws Exception { 
		List<LottoInfo> lotto = lottoService.getLottoInfo();
		int lastOrder = lotto.get(lotto.size()-1).getOrder();
		lottoInfo.setOrder(lastOrder+1);
		int test = lottoService.insertLotto(lottoInfo); 
		if(test == 1) {
			System.out.println("DB 등록완료!");
		}
		else {
			System.out.println("실패!");
		}
		  
		return ""; 
	}
	
	@RequestMapping("/view.do")
	public ModelAndView dbPage(ModelAndView mav) throws Exception { 
        
		List<User> nameModel = lottoService.getUser();
		
		mav.setViewName("view");
		
		return mav;
	}
	
}
