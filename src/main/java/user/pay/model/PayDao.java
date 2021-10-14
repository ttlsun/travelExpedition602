package user.pay.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.my.travelExpedition.utility.Paging;

@Component("myPayDao")
public class PayDao {
	private static final String NAMESPACE = "user.pay.model.PayBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int getTotalCount(Map<String, String> map) {
		return sqlSessionTemplate.selectOne(NAMESPACE+".getTotalCount", map);
	}
	
	public List<PayBean> getList(Paging pageInfo, Map<String, String> map){
		List<PayBean> lists = new ArrayList<PayBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		lists = sqlSessionTemplate.selectList(NAMESPACE+".getList", map, rowBounds);
		return lists;
	}
	
	public List<PayBean> getListForReserve(Map<String, String> map){
		List<PayBean> lists = new ArrayList<PayBean>();
		lists = sqlSessionTemplate.selectList(NAMESPACE+".getListForReserve", map);
		return lists;
	}
	
	public PayBean getData(int num) {
		return sqlSessionTemplate.selectOne(NAMESPACE+".getData", num);
	}
	
	public int registerPay(PayBean payBean) {
		return sqlSessionTemplate.insert(NAMESPACE+".registerPay", payBean);
	}
	
	public PayBean paycodeCheck(Map<String, String> map) {
		return sqlSessionTemplate.selectOne(NAMESPACE+".paycodeCheck", map);
	}
	
	public int updatePay(PayBean payBean) {
		return sqlSessionTemplate.update(NAMESPACE+".updatePay", payBean);
	}
	
	public void updatePaydetail(PayBean payBean) {
		sqlSessionTemplate.update(NAMESPACE+".updatePaydetail", payBean);
		return;
	}
	
	public int deletePay(int num) {
		return sqlSessionTemplate.insert(NAMESPACE+".deletePay", num);
	}
}
