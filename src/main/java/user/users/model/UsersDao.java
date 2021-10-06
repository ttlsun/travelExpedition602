package user.users.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller("myUsersDao")
public class UsersDao {
	private static final String NAMESPACE = "user.users.model.UsersBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int registerUsers(UsersBean users) {
		return sqlSessionTemplate.insert(NAMESPACE+".registerUsers", users);
	}
	
	public UsersBean idCheck(String id) {
		return sqlSessionTemplate.selectOne(NAMESPACE+".idCheck", id);
	}
	
	public UsersBean emailCheck(String email) {
		return sqlSessionTemplate.selectOne(NAMESPACE+".emailCheck", email);
	}
	
	public UsersBean findId(UsersBean users) {
		return sqlSessionTemplate.selectOne(NAMESPACE+".findId", users);
	}
	
	public UsersBean findPw(UsersBean users) {
		return sqlSessionTemplate.selectOne(NAMESPACE+".findPw", users);
	}
	
	public UsersBean login(UsersBean users) {
		return sqlSessionTemplate.selectOne(NAMESPACE+".login", users);
	}
}
