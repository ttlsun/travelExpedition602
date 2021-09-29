package user.qna.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller("myQnaDao")
public class QnaDao {
	private static final String NAMESPACE = "user.qna.model.QnaBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
}
