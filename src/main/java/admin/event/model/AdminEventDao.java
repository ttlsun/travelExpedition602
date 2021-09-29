package admin.event.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("myAdminEventDao")
public class AdminEventDao {
	private static final String NAMESPACE = "admin.event.model.AdminEventBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
}
