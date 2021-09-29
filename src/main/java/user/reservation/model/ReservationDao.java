package user.reservation.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("myReservationDao")
public class ReservationDao {

	private static final String NAMESPACE = "user.reservation.model.ReservationBean";
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
}
