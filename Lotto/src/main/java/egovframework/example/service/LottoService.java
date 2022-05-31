package egovframework.example.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.dao.LottoDAO;

@Service
public class LottoService {
	@Resource
    private LottoDAO lottoDAO;
    
    public List<Map> getName() {  // user 테이블
    	return lottoDAO.getName();
    }
}
