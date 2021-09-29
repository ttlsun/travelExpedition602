package user.camping.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("myCampingDao")
public class CampingDao {
	
	private static final String NAMESPACE = "user.camping.model.CampingBean";
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
}
