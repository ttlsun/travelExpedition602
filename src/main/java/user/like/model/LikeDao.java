package user.like.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

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
							+ map.get("reviewtype") 
							+ ", ANUM: "  + map.get("anum") 
							+ ", ID: "  + map.get("id"));
		int cnt = sqlSessionTemplate.delete(NAMESPACE + ".deleteLikesData", map);
		return cnt;
	}
	
}
