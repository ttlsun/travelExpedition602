package user.room.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import user.postimg.model.PostimgBean;
import user.postimg.model.PostimgDao;
import user.room.model.RoomBean;
import user.room.model.RoomDao;

@Controller
public class RoomDetailController {

	private static final String COMMAND = "/roomDetail.do";
	private static final String GETPAGE = "user/room/roomDetailView";
	
	@Autowired
	private RoomDao roomDao;
	
	@Autowired
	private PostimgDao postimgDao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView roomDetailView(ModelAndView mav,
							@RequestParam("num") String num,
							@RequestParam("name") String cname,
							@RequestParam("pageNumber") String pageNumber) {
		
		RoomBean roombean = roomDao.getRoomDetail(num);
		
		//이미지들 가져오기
		Map<String, Object> imgMap = new HashMap<String, Object>();
		imgMap.put("acode", "4"); //커뮤니티 구분자값
		imgMap.put("anum", num); 
		
		System.out.println(roombean.getNum());
		List<PostimgBean> imgList = postimgDao.getPostimgList(imgMap);
		System.out.println("imgList:" + imgList.toString());
		
		mav.addObject("roombean", roombean);
		mav.addObject("imgList", imgList);
		mav.addObject("cname", cname);
		mav.addObject("pageNumber", pageNumber);
		mav.setViewName(GETPAGE);
		return mav;
	}
}
