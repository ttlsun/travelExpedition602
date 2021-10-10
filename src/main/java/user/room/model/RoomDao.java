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
	
}
