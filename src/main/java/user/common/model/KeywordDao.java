package user.common.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("myKeywordDao")
public class KeywordDao {

	private static final String NAMESPACE = "user.common.model.KeywordBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	/*회원 관련 키워드 리스트 조회*/
	public List<KeywordBean> getKeywordList(String acode) {
		List<KeywordBean> lists = sqlSessionTemplate.selectList(NAMESPACE + ".getKeywordList", acode);
		return lists;
	}
	
	
}
