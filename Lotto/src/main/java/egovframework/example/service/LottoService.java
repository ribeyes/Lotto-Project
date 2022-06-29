package egovframework.example.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.dao.LottoDAO;
import egovframework.example.vo.User;

@Service
public class LottoService {
	@Resource
    private LottoDAO lottoDAO;
    
    public List<User> getUser() {  // user 테이블
    	return lottoDAO.getUser();
    }
}
