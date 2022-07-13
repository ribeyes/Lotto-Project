package egovframework.example.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.dao.LottoDAO;
import egovframework.example.vo.LottoInfo;
import egovframework.example.vo.User;

@Service
public class LottoService {
	@Resource
    private LottoDAO lottoDAO;
    
    public List<User> getUser() {  // user 테이블
    	return lottoDAO.getUser();
    }
    
    public List<LottoInfo> getLottoInfo() {  
    	return lottoDAO.getLottoInfo();
    }
    
    public int insertUser(User user) {  // user 테이블에 넣기
    	return lottoDAO.insertUser(user);
    }
    
    public int insertLotto(LottoInfo lottoInfo) {
		return lottoDAO.insertLotto(lottoInfo);
	}
}
