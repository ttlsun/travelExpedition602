package admin.qna.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("myAdminQnaDao")
public class AdminQnaDao {
	private static final String NAMESPACE = "admin.qna.model.AdminQnaBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
}
