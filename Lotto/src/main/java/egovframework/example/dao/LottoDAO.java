package egovframework.example.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.example.vo.LottoInfo;
import egovframework.example.vo.User;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("boardMapper")
@Repository
public class LottoDAO {
	
	@Autowired 
	@Resource(name="sqlSession")
	private SqlSession query;
	
	
	public List<User> getUser() { // 'user' 테이블에 있는 컬럼 데이터들
		return query.selectList("getUser");
	}
	
	public List<LottoInfo> getLottoInfo() { 
		return query.selectList("getLottoInfo");
	}
	
	public int insertUser(User user) {
		return query.insert("insertUser", user);
	}
}
