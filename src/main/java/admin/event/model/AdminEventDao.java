package admin.event.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.my.travelExpedition.utility.Paging;

@Component("myAdminEventDao")
public class AdminEventDao {
	
	private static final String NAMESPACE = "admin.event.model.AdminEventBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<AdminEventBean> getEventList(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset() , pageInfo.getLimit());
		List<AdminEventBean> lists = sqlSessionTemplate.selectList(NAMESPACE + ".getEventList", map, rowBounds);
		return lists;
	}
	
	public int getEventListTotalCnt(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(NAMESPACE + ".getEventListTotalCnt", map);
		return cnt;
	}
	
	public AdminEventBean getEventDetail(Map<String, Object> map) {
		AdminEventBean bean = sqlSessionTemplate.selectOne(NAMESPACE + ".getEventDetail", map);
		return bean;
	}
	
	public int getEventMaxNum() {
		int num = sqlSessionTemplate.selectOne(NAMESPACE + ".getEventMaxNum");
		return num;
	}

	public int insertData(AdminEventBean bean) {
		System.out.println("bean : " + bean);
		int cnt = sqlSessionTemplate.insert(NAMESPACE + ".insertEvent", bean);
		return cnt;
	}
	
	public int updateData(AdminEventBean bean) {
		int cnt =  sqlSessionTemplate.update(NAMESPACE + ".updateEvent", bean);
		return cnt;
	}
	
	public int updateEventUpcount(Map<String, Object> map) {
		int cnt =  sqlSessionTemplate.update(NAMESPACE + ".updateEventUpcount", map);
		return cnt;
	}
	
	public int deleteData(int num) {
		int cnt = sqlSessionTemplate.delete(NAMESPACE + ".deleteEvent", num);
		return cnt;
	}
}
