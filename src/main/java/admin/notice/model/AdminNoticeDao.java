package admin.notice.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.my.travelExpedition.utility.Paging;

@Component("myAdminNoticeDao")
public class AdminNoticeDao {
	
	private static final String NAMESPACE = "admin.notice.model.AdminNoticeBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<AdminNoticeBean> getNoticeList(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset() , pageInfo.getLimit());
		List<AdminNoticeBean> lists = sqlSessionTemplate.selectList(NAMESPACE + ".getNoticeList", map, rowBounds);
		return lists;
	}
	
	public int getNoticeListTotalCnt(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(NAMESPACE + ".getNoticeListTotalCnt", map);
		return cnt;
	}
	
	public AdminNoticeBean getNoticeDetail(Map<String, Object> map) {
		AdminNoticeBean bean = sqlSessionTemplate.selectOne(NAMESPACE + ".getNoticeDetail", map);
		return bean;
	}
	
	public int getNoticeMaxNum() {
		int num = sqlSessionTemplate.selectOne(NAMESPACE + ".getNoticeMaxNum");
		return num;
	}
	
	public int insertData(AdminNoticeBean bean) {
		System.out.println("bean : " + bean);
		int cnt = sqlSessionTemplate.insert(NAMESPACE + ".insertNotice", bean);
		return cnt;
	}
	
	public int updateData(AdminNoticeBean bean) {
		int cnt =  sqlSessionTemplate.update(NAMESPACE + ".updateNotice", bean);
		return cnt;
	}
	
	public int updateNoticeUpcount(Map<String, Object> map) {
		int cnt =  sqlSessionTemplate.update(NAMESPACE + ".updateNoticeUpcount", map);
		return cnt;
	}
	
	public int deleteData(int num) {
		int cnt = sqlSessionTemplate.delete(NAMESPACE + ".deleteNotice", num);
		return cnt;
	}
}
