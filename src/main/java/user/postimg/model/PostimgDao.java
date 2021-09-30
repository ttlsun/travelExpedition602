package user.postimg.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("myPostimgDao")
public class PostimgDao {
	private static final String NAMESPACE = "user.postimg.model.PostimgBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public List<PostimgBean> getPostimgList(Map<String, Object> map) {
		List<PostimgBean> lists = sqlSessionTemplate.selectList(NAMESPACE + ".getPostimgList", map);
		return lists;
	}
	
	public int insertPostimgData(Map<String, Object> map) {
		System.out.println("map acode(구분값:1:공지사항/2:이벤트/3:문의게시판/4:캠핑/5:관광지/6:커뮤니티 ) : " + map.get("acode") 
						+ ",imgname(이미지명) :"+ map.get("imgname"));
		int cnt = sqlSessionTemplate.insert(NAMESPACE + ".insertPostimgData", map);
		return cnt;
	}
	
	public int updatePostimgData(Map<String, Object> map) {
		System.out.println("map : acode : " + map.get("acode") 
						+ ",imgname(이미지명) :"+ map.get("imgname"));
		int cnt = sqlSessionTemplate.update(NAMESPACE + ".updatePostimgData", map);
		return cnt;
	}
	
	public int deletePostimgData(Map<String, Object> map) {
		System.out.println("map : acode : " + map.get("acode")
							+ ", anum(각테이블 고유번호값): :"+ map.get("anum"));
		
		List<PostimgBean> lists = sqlSessionTemplate.selectList(NAMESPACE + ".getPostimgList", map);
		
		//System.out.println("lists:" + lists.toString());
		
		//내 해당테이블 고유번호에 묶여있는 이미지들 다 삭제하기.
		int cnt =-1;
		Map<String, Integer> imgMap = new HashMap<String, Integer>();
		for(int i = 0; i < lists.size(); i++) {
			imgMap.put("num", lists.get(i).getNum()); //이미지고유번호
			cnt = sqlSessionTemplate.delete(NAMESPACE + ".deletePostimgData", imgMap);
		}
		
		return cnt;
	}
	
}
