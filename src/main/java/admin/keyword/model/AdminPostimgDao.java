package admin.keyword.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.my.travelExpedition.utility.Paging;

import user.postimg.model.PostimgBean;

@Component("myAdminPostimgDao")
public class AdminPostimgDao {
	private static final String NAMESPACE = "user.postimg.model.PostimgBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public List<PostimgBean> getPostimgLists(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset() , pageInfo.getLimit());
		List<PostimgBean> lists = sqlSessionTemplate.selectList(NAMESPACE + ".getPostimgLists", map, rowBounds);
		return lists;
	}
	
	public int getPostimgsListTotalCnt(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(NAMESPACE + ".getPostimgsListTotalCnt", map);
		return cnt;
	}
	
	
}
