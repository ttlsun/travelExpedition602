package admin.event.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.WebUtil;

import admin.event.model.AdminEventBean;
import admin.event.model.AdminEventDao;
import user.postimg.model.PostimgBean;
import user.postimg.model.PostimgDao;

@Controller
public class AdminEventDetailController {

	public static final String COMMAND = "/eventDetail.ad";
	public static final String GETPAGE = "admin/event/eventDetailForm";
	public static final String GOTOPAGE = "redirect:/eventList.ad";
	public static final String GOTOPAGE_ENDEVENT = "redirect:/endEventList.ad";
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private AdminEventDao adminEventDao;
	
	@Autowired
	private PostimgDao postimgDao;
	
	@RequestMapping(value = COMMAND, method = RequestMethod.GET)
    public ModelAndView adminEventDetailView(HttpServletRequest request,
    										@RequestParam Map<String, String> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		Map<String, Object> eventMap = new HashMap<String, Object>();
		eventMap.put("num", map.get("num"));
		AdminEventBean event = adminEventDao.getEventDetail(eventMap);
		
		//여럿 파일 이미지들(이미지관리테이블) 조회
		Map<String, Object> imgMap = new HashMap<String, Object>();
		imgMap.put("acode", "2"); //이벤트 구분자값
		imgMap.put("anum", map.get("num")); 
		List<PostimgBean> imgList = postimgDao.getPostimgList(imgMap);
		//System.out.println("lists:" + lists.toString());
		
		mav.addObject("pageNumber", map.get("pageNumber"));
		mav.addObject("type", map.get("type")); //01:진행중인 이벤트 , 02:종료된 이벤트
		mav.addObject("event", event); //이벤트 상세
		mav.addObject("imgList", imgList); //이미지리스트
		
		return mav;
	}
	
	@RequestMapping(value = COMMAND, method = RequestMethod.POST)
    public ModelAndView doActionPost(ModelAndView mav,@RequestParam Map<String, Object> map) {
		
		System.out.println("map:" + map.get("num") );
		
		try {
			//여럿 파일 이미지들(이미지관리테이블) 조회
			map.put("acode", "2"); //이벤트 구분자값
			map.put("anum", map.get("num")); 
			List<PostimgBean> postImglists = postimgDao.getPostimgList(map);
			System.out.println("DB 이미지 갯수 :" + postImglists.size());
			
			// (이미지관리테이블 삭제) 기존파일 삭제를 위해 이름을 조회한다
			String[] arPostImgFileName = new String[postImglists.size()];
			for(int i = 0; i < postImglists.size(); i++) {
				arPostImgFileName[i] = postImglists.get(i).getImgname(); //이미지명
			}
			
			// 이미지 테이블에 기존이미지들 파일들 삭제
			WebUtil.deletefileUpload(servletContext, arPostImgFileName);
			
			// 기존파일 DB에서 삭제
			postimgDao.deletePostimgData(map);
			
			int num = Integer.parseInt((String)map.get("num"));
			//System.out.println("num::::" + num);
			
			//이벤트 테이블 데이터 삭제
			adminEventDao.deleteData(num);
			
			//만일 진행중인이벤트(01) 인 삭제일경우, 진행중인 이벤트 페이지로 이동. 
			if(map.get("type").equals("01")) {
				mav.setViewName(GOTOPAGE);
			}else { //아닐경우, 종료된 이벤트 페이지로 이동.
				mav.setViewName(GOTOPAGE_ENDEVENT);
			}
			
			mav.addObject("pageNumber", map.get("pageNumber"));
			mav.addObject("type", map.get("type")); //01:진행중인 이벤트 , 02:종료된 이벤트
			
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println("내부오류");
		}
		
		return mav;
	}
	
}
