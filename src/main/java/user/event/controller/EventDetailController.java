package user.event.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import admin.event.model.AdminEventBean;
import admin.event.model.AdminEventDao;
import user.postimg.model.PostimgBean;
import user.postimg.model.PostimgDao;

@Controller
public class EventDetailController {

	public static final String COMMAND = "/eventDetail.do";
	public static final String GETPAGE = "user/event/eventDetailForm";
	
	@Autowired
	private AdminEventDao adminEventDao;
	
	@Autowired
	private PostimgDao postimgDao;
	
	@RequestMapping(value = COMMAND, method = RequestMethod.GET)
    public ModelAndView eventDetailView(HttpServletRequest request,
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
		
		//조회수 올리기.
		adminEventDao.updateEventUpcount(eventMap);
		
		mav.addObject("pageNumber", map.get("pageNumber"));
		mav.addObject("type", map.get("type")); //01:진행중인 이벤트 , 02:종료된 이벤트
		mav.addObject("event", event); //이벤트 상세
		mav.addObject("imgList", imgList); //이미지리스트
		
		return mav;
	}
}
