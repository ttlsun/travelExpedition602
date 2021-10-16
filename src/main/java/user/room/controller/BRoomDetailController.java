package user.room.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import user.postimg.model.PostimgBean;
import user.postimg.model.PostimgDao;
import user.reservation.model.ReservationBean;
import user.reservation.model.ReservationDao;
import user.room.model.RoomBean;
import user.room.model.RoomDao;

@Controller
public class BRoomDetailController {

	private static final String COMMAND = "/bRoomDetail.do";
	private static final String GETPAGE = "user/room/bRoomDetailView";
	
	@Autowired
	private RoomDao roomDao;
	
	@Autowired
	private PostimgDao postimgDao;
	
	@Autowired
	private ReservationDao reservationDao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView roomDetailView(ModelAndView mav,
							@RequestParam("num") String num,
							@RequestParam("pageNumber") String pageNumber) {
		//객실 상세 정보 가져오기
		RoomBean roombean = roomDao.getRoomDetail(num);
		
		//해당 객실의 캠핑장 이름 가져오기
		String cname = roomDao.getCampingName(roombean.getCnum());
		
		//이미지들 가져오기
		Map<String, Object> imgMap = new HashMap<String, Object>();
		imgMap.put("acode", "4"); //게시글 구분코드(1:공지사항/2:이벤트/3:문의게시판/4:캠핑/5:관광지/6:커뮤니티)
		imgMap.put("anum", num); 
		
		System.out.println(roombean.getNum());
		List<PostimgBean> imgList = postimgDao.getPostimgList(imgMap);
		//System.out.println("imgList:" + imgList.toString());
		
		mav.addObject("roombean", roombean);
		mav.addObject("imgList", imgList);
		mav.addObject("cname", cname);
		mav.addObject("pageNumber", pageNumber);
		mav.setViewName(GETPAGE);
		return mav;
	}
	
}
