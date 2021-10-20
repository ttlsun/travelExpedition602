package user.users.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.my.travelExpedition.utility.Paging;

import user.qna.model.QnaBean;

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
	
	public int byeUsers(UsersBean users) {
		return sqlSessionTemplate.update(NAMESPACE+".byeUsers", users);
	}
	
	public int deleteUsers(int num) {
		String id = sqlSessionTemplate.selectOne(NAMESPACE+".findIdwithNum", num);
		sqlSessionTemplate.delete(NAMESPACE+".deletePay", id);
		
		List<QnaBean> lists = new ArrayList<QnaBean>();
		lists = sqlSessionTemplate.selectList(NAMESPACE+".findQnARef", id);
		for(int i=0; i<lists.size(); i++) {
			sqlSessionTemplate.delete(NAMESPACE+".deleteQnA", lists.get(i).getRef());
		}
		sqlSessionTemplate.delete(NAMESPACE+".deleteLikes", id);
		
		return sqlSessionTemplate.delete(NAMESPACE+".deleteUsers", num);
	}
	
	public int updateMyInfo(UsersBean users) {
		return sqlSessionTemplate.update(NAMESPACE+".updateMyInfo", users);
	}
	
	public int updateUserInfo(UsersBean users) {
		return sqlSessionTemplate.update(NAMESPACE+".updateUserInfo", users);
	}
	
	public int updatePw(UsersBean users) {
		return sqlSessionTemplate.update(NAMESPACE+".updatePw", users);
	}
	
	public int getTotalCount(Map<String, String> map) {
		return sqlSessionTemplate.selectOne(NAMESPACE+".getTotalCount", map);
	}
	
	public List<UsersBean> getList(Paging pageInfo, Map<String, String> map){
		List<UsersBean> lists = new ArrayList<UsersBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		lists = sqlSessionTemplate.selectList(NAMESPACE+".getList", map, rowBounds);
		return lists;
	}
	
	public UsersBean getData(int num) {
		return sqlSessionTemplate.selectOne(NAMESPACE+".getData", num);
	}
}
