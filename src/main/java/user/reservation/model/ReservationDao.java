package user.reservation.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.my.travelExpedition.utility.Paging;

@Component("myReservationDao")
public class ReservationDao {

	private static final String NAMESPACE = "user.reservation.model.ReservationBean";
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/*모든 예약 내역 리스트(추후 변경하세요.) */
	public List<ReservationBean> getAllReservationList(Map<String, Object> map) {
		System.out.println("캠핑 고유번호: cnum :" + map.get("cnum") +"방고유번호 : rnum :" + map.get("rnum") );
		
		List<ReservationBean> lists = sqlSessionTemplate.selectList(NAMESPACE + ".getAllReservationList", map);
		return lists;
	}
	
	/*예약 등록 (추후 변경하세요. 일단 만들어놨어요.)*/
	public int insertReservationData(ReservationBean bean) {
		int cnt = sqlSessionTemplate.insert(NAMESPACE + ".insertReservation", bean);
		return cnt;
	}
	
	/*예약 진행사항 상태 변경*/
	public int updateReservationStatusChange(Map<String, Object> map) {
		int cnt =  sqlSessionTemplate.update(NAMESPACE + ".updateReservationStatusChange", map);
		return cnt;
	}

	/*나의 캠핑 예약 내역 리스트*/
	public List<MyReservationBean> getMyReservationList(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset() , pageInfo.getLimit());
		List<MyReservationBean> lists = sqlSessionTemplate.selectList(NAMESPACE + ".getMyReservationList", map, rowBounds);
		return lists;
	}
	
	/*나의 캠핑 예약 리스트 cnt */
	public int getMyReservationListTotalCnt(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(NAMESPACE + ".getMyReservationListTotalCnt", map);
		return cnt;
	}
	
	/*나의 캠핑 예약 내역 리스트 상세*/
	public MyReservationBean getMyReservationDetail(Map<String, Object> map) {
		MyReservationBean bean = sqlSessionTemplate.selectOne(NAMESPACE + ".getMyReservationDetail", map);
		return bean;
	}
	
	/* 캠핑 객실 예약 */
	public int insertReservation(Map<String, String> map) {
		int cnt = sqlSessionTemplate.insert(NAMESPACE + ".insertReservation", map);
		return cnt;
	}
	

	
	
}
