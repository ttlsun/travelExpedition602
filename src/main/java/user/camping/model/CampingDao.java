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
	
	//캠핑장 등록
	public int insertData(CampingBean campbean) {
		int cnt = sqlSessionTemplate.insert(NAMESPACE+".insertData", campbean);
		return cnt;
	}

	//캠핑장 리스트 게시물 수 가져오기
	public int getTotalCount(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(NAMESPACE+".getTotalCount", map);
		return cnt;
	}

	//캠핑장 리스트 가져오기
	public List<CampingBean> getCampingList(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset() , pageInfo.getLimit());
		List<CampingBean> lists = sqlSessionTemplate.selectList(NAMESPACE+".getCampingList", map, rowBounds);
		System.out.println("lists:" + lists.toString());
		return lists;
	}

	//캠핑장 상세정보 불러오기
	public CampingBean getCampingDetail(String num) {
		CampingBean campbean = sqlSessionTemplate.selectOne(NAMESPACE+".getCampingDetail", num);
		return campbean;
	}
	
	//캠핑장 정보 수정
	public int updateData(CampingBean campbean) {
		int cnt = sqlSessionTemplate.update(NAMESPACE+".updateData", campbean);
		return cnt;
	}

	//캠핑장 이름, 유형 가져오기(객실페이지에서 필요)
	public CampingBean getCampingNameAndTypes(int num) {
		CampingBean campbean = sqlSessionTemplate.selectOne(NAMESPACE+".getCampingNameAndTypes", num);
		return campbean;
	}

	//캠핑장 삭제->상태값 비노출로 변경
	public int updateCampingStatusBlind(String num) {
		int cnt = sqlSessionTemplate.update(NAMESPACE+".updateCampingStatusBlind", num);
		return cnt;
	}
	
	//캠핑장 상세보기 시 조회수 UP
	public int campingReadcountUp(String num) {
		int cnt = sqlSessionTemplate.update(NAMESPACE+".campingReadcountUp", num);
		return cnt;
	}
	
	//pay테이블 관련
	public String getCampingRegid(int cnum) {
	    return sqlSessionTemplate.selectOne(NAMESPACE+".getCampingRegid", cnum);
	}
}
