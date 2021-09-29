package user.postimg.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller("myPostimgDao")
public class PostimgDao {
	private static final String NAMESPACE = "user.postimg.model.PostimgBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
}
