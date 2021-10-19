package user.like.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.my.travelExpedition.utility.Paging;

@Controller("myLikeDao")
public class LikeDao {
	private static final String NAMESPACE = "user.like.model.LikeBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<LikeBean> getLikesList(Map<String, String> map) {
		List<LikeBean> lists = sqlSessionTemplate.selectList(NAMESPACE + ".getLikesList", map);
		return lists;
	}
	
	public int insertLikesData(Map<String, Object> map) {
		System.out.println("map ACODE(게시글 구분코드(1:캠핑/2:관광지/3:커뮤니티) ) : " 
						+ map.get("acode") 
						+ ", ANUM: "  + map.get("anum") 
						+ ", ID: "  + map.get("id"));
		
		int cnt = sqlSessionTemplate.insert(NAMESPACE + ".insertLikesData", map);
		return cnt;
	}
	
	public int deleteLikesData(Map<String, Object> map) {
		System.out.println("map ACODE(게시글 구분코드(1:캠핑/2:관광지/3:커뮤니티) ) : " 
							+ map.get("acode") 
							+ ", ANUM: "  + map.get("anum") 
							+ ", ID: "  + map.get("id"));
		int cnt = sqlSessionTemplate.delete(NAMESPACE + ".deleteLikesData", map);
		return cnt;
	}
	
	/*나의 찜 내역 리스트*/
	public List<LikeBean> getAllLikesList(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset() , pageInfo.getLimit());
		List<LikeBean> lists = sqlSessionTemplate.selectList(NAMESPACE + ".getAllLikesList", map, rowBounds);
		return lists;
	}
	
	/*나의 찜 내역 리스트 cnt */
	public int getAllLikesListTotalCnt(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(NAMESPACE + ".getAllLikesListTotalCnt", map);
		return cnt;
	}
	
	/* 이미 찜 했는지 확인 */
	public int confirmUserId(Map<String, Object> map) {
		int cnt = sqlSessionTemplate.selectOne(NAMESPACE + ".confirmUserId", map);
		return cnt;
	}
	
}
