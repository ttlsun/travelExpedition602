package user.users.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller("myUsersDao")
public class UsersDao {
	private static final String NAMESPACE = "user.users.model.UsersBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
}
