package user.like.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller("myLikeDao")
public class LikeDao {
	private static final String NAMESPACE = "user.like.model.LikeBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
}
