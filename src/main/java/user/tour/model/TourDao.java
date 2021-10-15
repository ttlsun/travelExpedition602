package user.tour.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.my.travelExpedition.utility.Paging;

@Component("myTourDao")
public class TourDao {
	
	private static final String NAMESPACE = "user.tour.model.TourBean";
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public int insertData(TourBean tourbean) {
		int cnt = sqlSessionTemplate.insert(NAMESPACE+".insertTour", tourbean);
		return cnt;
	}

	public int getTotalCount(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(NAMESPACE+".getTotalCount", map);
		return cnt;
	}

	public List<TourBean> getTourList(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset() , pageInfo.getLimit());
		List<TourBean> lists = sqlSessionTemplate.selectList(NAMESPACE+".getTourList", map, rowBounds);
		System.out.println("lists:" + lists.toString());
		return lists;
	}

	public int getTourMaxNum() {
		int num = sqlSessionTemplate.selectOne(NAMESPACE + ".getTourMaxNum");
		return num;
	}
	
	public TourBean getTourDetail(int num) {
		TourBean tourbean = sqlSessionTemplate.selectOne(NAMESPACE+".getTourDetail", num);
		return tourbean;
	}

	public int updateData(TourBean tourbean) {
		int cnt = sqlSessionTemplate.update(NAMESPACE+".updateData", tourbean);
		return cnt;
	}
	
	public int updateTourStatusBlind(String num) {
		int cnt = sqlSessionTemplate.update(NAMESPACE+".updateTourStatusBlind", num);
		return cnt;
	}
	
	/*조회수 카운트 올리기*/
	public int updateTourUpcount(Map<String, String> map) {
		int cnt =  sqlSessionTemplate.update(NAMESPACE + ".updateTourUpcount", map);
		return cnt;
	}
	
	
}
