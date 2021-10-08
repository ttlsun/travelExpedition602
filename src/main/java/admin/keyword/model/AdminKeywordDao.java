package admin.keyword.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.my.travelExpedition.utility.Paging;

import user.common.model.KeywordBean;

@Component("myAdminKeywordDao")
public class AdminKeywordDao {

	private static final String NAMESPACE = "user.common.model.KeywordBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<KeywordBean> getKeywordsList(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset() , pageInfo.getLimit());
		List<KeywordBean> lists = sqlSessionTemplate.selectList(NAMESPACE + ".getKeywordsList", map, rowBounds);
		return lists;
	}
	
	public int getKeywordsListTotalCnt(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(NAMESPACE + ".getKeywordsListTotalCnt", map);
		return cnt;
	}
	
	public KeywordBean getKeywordsDetail(Map<String, Object> map) {
		KeywordBean bean = sqlSessionTemplate.selectOne(NAMESPACE + ".getKeywordsDetail", map);
		return bean;
	}
	
	public int insertData(KeywordBean bean) {
		System.out.println("bean : " + bean);
		int cnt = sqlSessionTemplate.insert(NAMESPACE + ".insertKeyword", bean);
		return cnt;
	}
	
	public int updateData(KeywordBean bean) {
		int cnt =  sqlSessionTemplate.update(NAMESPACE + ".updateKeyword", bean);
		return cnt;
	}
	
	public int deleteData(int num) {
		int cnt = sqlSessionTemplate.delete(NAMESPACE + ".deleteKeyword", num);
		return cnt;
	}
	
}
