package user.like.controller;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.my.travelExpedition.utility.WebUtil;

import net.sf.json.JSONObject;
import user.camping.model.CampingDao;
import user.like.model.LikeDao;
import user.tour.model.TourDao;

@Controller
public class LikesRegisterController {

	public static final String COMMAND = "/myLikesRegister.do";
	
	@Autowired
	private LikeDao likeDao;
	
	@Autowired
	private TourDao tourDao;
	
	
	@Autowired
	private CampingDao campingDao;
	
	//likes테이블에도 insert 해주기
	@RequestMapping(value = COMMAND)
	public void doJsonlikesRegister(HttpServletResponse response,
									@RequestParam Map<String, Object> map) throws Exception {
		
		JSONObject json = new JSONObject();
		
		try {
			
			System.out.println( "userId:" + map.get("userId") + " "  +
								"num:" + map.get("num")+ " "  +
								"acode:" + map.get("acode"));
			
			//likes 테이블에 저장.
			map.put("id", map.get("userId"));
			map.put("anum", map.get("num"));
			map.put("acode", map.get("acode")); //게시글 구분코드(1:캠핑/2:관광지/3:커뮤니티)
			
			int cnt = -1;

			cnt = likeDao.confirmUserId(map);
			System.out.println("이미 찜했는지 확인용 cnt:"+cnt);
			
			if(cnt == 0) {				
				likeDao.insertLikesData(map);
				
				if(map.get("acode").equals("1")) {				
					campingDao.updateSteamed(map);
				}
				else if(map.get("acode").equals("2")) {				
					tourDao.updateSteamed(map);
				}
			}
			//cnt = 0(찜한적없음) / 1(찜한적있음)
			json.put("cnt",cnt);
			
		
			json.put("resultCode", "OK");
			json.put("resultMsg", "성공");
			
		} catch (Exception e) {
			json.put("resultCode", "ERROR");
			json.put("resultMsg", e.getMessage());
		}
		
		WebUtil.jsonSend(json, response);
	}
	
}
