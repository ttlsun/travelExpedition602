package user.community.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.my.travelExpedition.utility.Paging;

@Component("myCommunityDao")
public class CommunityDao {

	private static final String NAMESPACE = "user.community.model.CommunityBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<CommunityBean> getCommunityList(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset() , pageInfo.getLimit());
		List<CommunityBean> lists = sqlSessionTemplate.selectList(NAMESPACE + ".getCommunityList", map, rowBounds);
		return lists;
	}
	
	public int getCommunityListTotalCnt(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(NAMESPACE + ".getCommunityListTotalCnt", map);
		return cnt;
	}
	
	public CommunityBean getCommunityDetail(Map<String, Object> map) {
		CommunityBean bean = sqlSessionTemplate.selectOne(NAMESPACE + ".getCommunityDetail", map);
		return bean;
	}
	
	public int insertData(CommunityBean bean) {
		System.out.println("bean : " + bean);
		int cnt = sqlSessionTemplate.insert(NAMESPACE + ".insertCommunity", bean);
		return cnt;
	}
	
	public int updateData(CommunityBean bean) {
		int cnt =  sqlSessionTemplate.update(NAMESPACE + ".updateCommunity", bean);
		return cnt;
	}
	
	public int deleteData(int num) {
		int cnt = sqlSessionTemplate.delete(NAMESPACE + ".deleteCommunity", num);
		return cnt;
	}

	public int getCommunityMaxNum() {
		int num = sqlSessionTemplate.selectOne(NAMESPACE + ".getCommunityMaxNum");
		return num;
	}
	
	/*예약완료인 후기썻는지 확인*/
	public int getCommunityWritCount(Map<String, Object> map) {
		int num = sqlSessionTemplate.selectOne(NAMESPACE + ".getCommunityWritCount",map);
		return num;
	}
	
	/*상태값 변경*/
	public int updateCommunityStatusChange(Map<String, Object> map) {
		int cnt =  sqlSessionTemplate.update(NAMESPACE + ".updateCommunityStatusChange", map);
		return cnt;
	}
	
	/*찜, 별, 조회수 카운트 올리기*/
	public int updateCommunityUpcount(Map<String, Object> map) {
		System.out.println("upconut: "+ map.get("num") + " ," 
							+ map.get("recommend")+ " ," 
							+ map.get("steamed"));
		
		int cnt =  sqlSessionTemplate.update(NAMESPACE + ".updateCommunityUpcount", map);
		return cnt;
	}
	
	/*후기 댓글쪽 */
	public List<CommunityReplyBean> getCommunityReplyList(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset() , pageInfo.getLimit());
		List<CommunityReplyBean> lists = sqlSessionTemplate.selectList(NAMESPACE + ".getCommunityReplyList", map, rowBounds);
		return lists;
	}
	
	public int getCommunityReplyListTotalCnt(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(NAMESPACE + ".getCommunityReplyListTotalCnt", map);
		return cnt;
	}
	
	public int insertCommunityReply(CommunityReplyBean bean) {
		int cnt = sqlSessionTemplate.insert(NAMESPACE + ".insertCommunityReply", bean);
		return cnt;
	}

	public int deleteCommunityReply(int num) {
		int cnt = sqlSessionTemplate.delete(NAMESPACE + ".deleteCommunityReply", num);
		return cnt;
	}
	
	public int deleteAllCommunityReply(int num) {
		int cnt = sqlSessionTemplate.delete(NAMESPACE + ".deleteAllCommunityReply", num);
		return cnt;
	}
	
	/*별등급 평균 내기*/
	public int getStarAVG(Map<String, String> map) {
		System.out.println("reviewtype:(01:캠핑/02:관광지) : " + map.get("reviewtype") +"," + "리뷰고유번호(캠핑고유번호 or 관광지고유 번호) : " + map.get("reviewnum"));
		Integer svgStar = sqlSessionTemplate.selectOne(NAMESPACE + ".getStarAVG", map);
		if (svgStar == null)
			return 0;
		
		return svgStar;
	}
	
	/*캠핑 or 관광지 리뷰수 올려주기 */
	public int updateReviewCount(Map<String, Object> map) {
		System.out.println("reviewtype:(01:캠핑/02:관광지) : "+ map.get("reviewtype") + "리뷰고유번호(캠핑고유번호 or 관광지고유 번호) : " + map.get("reviewnum"));
		int cnt =  sqlSessionTemplate.update(NAMESPACE + ".updateReviewCount", map);
		return cnt;
	}
	
	/*캠핑 or 관광지 리뷰수 내려주기 */
	public int deleteUpdateReviewCount(Map<String, Object> map) {
		int cnt =  sqlSessionTemplate.update(NAMESPACE + ".deleteUpdateReviewCount", map);
		return cnt;
	}
	
	/*캠핑 or 관광지 추천수 올려주기 */
	public int updateRecommend(Map<String, Object> map) {
		int cnt =  sqlSessionTemplate.update(NAMESPACE + ".updateRecommend", map);
		return cnt;
	}
	
	/*캠핑 or 관광지 추천수 내려주기 */
	public int deleteUpdateRecommend(Map<String, Object> map) {
		int cnt =  sqlSessionTemplate.update(NAMESPACE + ".deleteUpdateRecommend", map);
		return cnt;
	}
	
	/*캠핑 or 관광지 추천 리스트 뿌리기*/
	public List<CommunityBean> getRecommendList(Map<String, String> map) {
		List<CommunityBean> lists = sqlSessionTemplate.selectList(NAMESPACE + ".getRecommendList", map);
		return lists;
	}
	
	/* 메인에 보여줄 후기 리스트(3개만 보여줌) */
	public List<CommunityBean> getCommunityMainList() {
		List<CommunityBean> lists = sqlSessionTemplate.selectList(NAMESPACE + ".getCommunityMainList");
		return lists;
	}
	
}
