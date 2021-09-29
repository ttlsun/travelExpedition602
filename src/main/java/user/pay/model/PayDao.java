package user.pay.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("myPayDao")
public class PayDao {
	private static final String NAMESPACE = "user.pay.model.PayBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
}
