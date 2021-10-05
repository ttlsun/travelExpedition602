package user.rating.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import admin.community.model.CommunityRatingBean;

@Component("myRatingDao")
public class RatingDao {

	private static final String NAMESPACE = "user.rating.model.RatingBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	
	public List<RatingBean> getRatingList(Map<String, String> map) {
		List<RatingBean> lists = sqlSessionTemplate.selectList(NAMESPACE + ".getRatingList", map);
		return lists;
	}
	
	public int insertRatingData(Map<String, Object> map) {
		System.out.println("map REVIEW_TYPE(구분타입:01:캠핑/02:관광지 /03:모든후기 ) : " 
						+ map.get("reviewtype") 
						+ ", REVIEW_NUM: "  + map.get("reviewnum") 
						+ ", STAR_RANKING: "  + map.get("starranking") 
						+ ", REGID: " 		 + map.get("regid") 
						+ ", RATING_TYPE :"+ map.get("ratingtype"));
		
		int cnt = sqlSessionTemplate.insert(NAMESPACE + ".insertRatingData", map);
		return cnt;
	}
	
	public int updateRatingData(Map<String, Object> map) {
		int cnt = sqlSessionTemplate.update(NAMESPACE + ".updateRatingData", map);
		return cnt;
	}
	
	public int deleteRatingData(Map<String, Object> map) {
		System.out.println("map REVIEW_TYPE(구분타입:1:캠핑/2:관광지/3:커뮤니티 ) : " 
				+ map.get("reviewtype") 
				+ "REVIEW_NUM: "  + map.get("reviewnum") 
				+ ",RATING_TYPE :"+ map.get("ratingtype"));
		int cnt = sqlSessionTemplate.delete(NAMESPACE + ".deleteRatingData", map);
		return cnt;
	}
	
	public int getRatingStarAVG(Map<String, Object> map) {
		int svgStar = sqlSessionTemplate.selectOne(NAMESPACE + ".getRatingStarAVG", map);
		return svgStar;
	}
	
	public List<CommunityRatingBean> getcommunityRatingSum() {
		List<CommunityRatingBean> lists = sqlSessionTemplate.selectList(NAMESPACE + ".getcommunityRatingSum");
		return lists;
	}


}
