package egovframework.example.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("boardMapper")
@Repository
public class LottoDAO {
	
	@Autowired
	@Resource(name="sqlSession")
	private SqlSession query;
	
	
	public List<Map> getName() { // 'name' column(열) 데이터
		return query.selectList("getName");
	}
}
