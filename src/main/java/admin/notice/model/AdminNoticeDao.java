package admin.notice.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("myAdminNoticeDao")
public class AdminNoticeDao {
	private static final String NAMESPACE = "admin.notice.model.AdminNoticeBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
}
