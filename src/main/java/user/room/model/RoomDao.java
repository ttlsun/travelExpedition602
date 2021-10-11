package user.room.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("myRoomDao")
public class RoomDao {

	private static final String NAMESPACE = "user.room.model.RoomBean";
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public int insertData(RoomBean roombean) {
		int cnt = sqlSessionTemplate.insert(NAMESPACE+".insertData", roombean);
		return cnt;
	}

	public int getRoomMaxNum() {
		int maxNum = sqlSessionTemplate.selectOne(NAMESPACE+".getRoomMaxNum");
		return maxNum;
	}

	public List<RoomBean> getRoomList(String cnum) {
		List<RoomBean> lists = sqlSessionTemplate.selectList(NAMESPACE+".getRoomList", cnum);
		return lists;
	}

	public RoomBean getRoomDetail(String num) {
		RoomBean roombean = sqlSessionTemplate.selectOne(NAMESPACE+".getRoomDetail", num);
		return roombean;
	}

	public RoomBean getRoomReserveInfo(String rnum) {
		RoomBean roombean = sqlSessionTemplate.selectOne(NAMESPACE+".getRoomReserveInfo", rnum);
		return roombean;
	}

	public String getCampingName(int cnum) {
		String cname = sqlSessionTemplate.selectOne(NAMESPACE+".getCampingName", cnum);
		return cname;
	}

	public int updateData(RoomBean roombean) {
		int cnt = sqlSessionTemplate.update(NAMESPACE+".updateData", roombean);
		return cnt;
	}

	public String getCampingNum(String num) {
		String cnum = sqlSessionTemplate.selectOne(NAMESPACE+".getCampingNum", num);
		return cnum;
	}

	public int updateRoomStatusBlind(String num) {
		int cnt = sqlSessionTemplate.update(NAMESPACE+".updateRoomStatusBlind", num);
		return cnt;
	}
	
}
