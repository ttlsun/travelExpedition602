package user.room.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("myRoomDao")
public class RoomDao {

	private static final String NAMESPACE = "user.room.model.RoomBean";
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
}
