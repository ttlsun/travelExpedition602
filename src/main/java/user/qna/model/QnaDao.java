package user.qna.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.my.travelExpedition.utility.Paging;

@Controller("myQnaDao")
public class QnaDao {
	private static final String NAMESPACE = "user.qna.model.QnaBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<QnaBean> getQnaList(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset() , pageInfo.getLimit());
		List<QnaBean> lists = sqlSessionTemplate.selectList(NAMESPACE + ".getQnaList", map, rowBounds);
		return lists;
	}
	
	public int getQnaListTotalCnt(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(NAMESPACE + ".getQnaListTotalCnt", map);
		return cnt;
	}
	
	public QnaBean getQnaDetail(Map<String, Object> map) {
		QnaBean bean = sqlSessionTemplate.selectOne(NAMESPACE + ".getQnaDetail", map);
		return bean;
	}
	
	/*문의글 비밀번호 확인 */
	public String getPwData(int num) {
		String pw = sqlSessionTemplate.selectOne(NAMESPACE + ".getPwData", num);
		return pw;
	}
	
	/*문의 고유번호 추출*/
	public int getQnaMaxNum() {
		int num = sqlSessionTemplate.selectOne(NAMESPACE + ".getQnaMaxNum");
		return num;
	}
	
	/*회원 insert*/
	public int insertData(QnaBean bean) {
		System.out.println("bean : " + bean);
		int cnt = sqlSessionTemplate.insert(NAMESPACE + ".insertQna", bean);
		return cnt;
	}
	
	/*관리자 답글 insert*/
	public int insertQnaRef(QnaBean bean) {
		int cnt = sqlSessionTemplate.insert(NAMESPACE + ".insertQnaRef", bean);
		return cnt;
	}
	
	/*문의글 update*/
	public int updateData(QnaBean bean) {
		int cnt =  sqlSessionTemplate.update(NAMESPACE + ".updateQna", bean);
		return cnt;
	}
	
	/*답글 갯수 update*/
	public int updateQnaRef(Map<String, Object> map) {
		int cnt =  sqlSessionTemplate.update(NAMESPACE + ".updateQnaRef", map);
		return cnt;
	}
	
	/*답변 상태값 update*/
	public int updateQnaStatus(Map<String, Object> map) {
		int cnt =  sqlSessionTemplate.update(NAMESPACE + ".updateQnaStatus", map);
		return cnt;
	}
	
	/*문의 삭제*/
	public int deleteData(int num) {
		int cnt = sqlSessionTemplate.delete(NAMESPACE + ".deleteQna", num);
		return cnt;
	}

}
