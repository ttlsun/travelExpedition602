package user.camping.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.my.travelExpedition.utility.Paging;

@Component("myCampingDao")
public class CampingDao {
	
	private static final String NAMESPACE = "user.camping.model.CampingBean";
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public int insertData(CampingBean campbean) {
		int cnt = sqlSessionTemplate.insert(NAMESPACE+".insertData", campbean);
		return cnt;
	}

	public int getTotalCount(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(NAMESPACE+".getTotalCount", map);
		return cnt;
	}

	public List<CampingBean> getCampingList(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset() , pageInfo.getLimit());
		List<CampingBean> lists = sqlSessionTemplate.selectList(NAMESPACE+".getCampingList", map, rowBounds);
		System.out.println("lists:" + lists.toString());
		return lists;
	}

	public CampingBean getCampingDetail(String num) {
		CampingBean campbean = sqlSessionTemplate.selectOne(NAMESPACE+".getCampingDetail", num);
		return campbean;
	}
	
	public int updateData(CampingBean campbean) {
		int cnt = sqlSessionTemplate.update(NAMESPACE+".updateData", campbean);
		return cnt;
	}

	public CampingBean getCampingNameAndTypes(int num) {
		CampingBean campbean = sqlSessionTemplate.selectOne(NAMESPACE+".getCampingNameAndTypes", num);
		return campbean;
	}

	public int updateCampingStatusBlind(String num) {
		int cnt = sqlSessionTemplate.update(NAMESPACE+".updateCampingStatusBlind", num);
		return cnt;
	}
	
	public String getCampingRegid(int cnum) {
		return sqlSessionTemplate.selectOne(NAMESPACE+".getCampingRegid", cnum);
	}
}
