package user.camping.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.Paging;

import user.camping.model.CampingBean;
import user.camping.model.CampingDao;
import user.community.model.CommunityBean;
import user.community.model.CommunityDao;
import user.room.model.RoomBean;
import user.room.model.RoomDao;

@Controller
public class BCampingDetailController {
	
	private static final String COMMAND = "/bCampingDetail.do";
	private static final String GETPAGE = "user/camping/bCampingDetailView";
	
	@Autowired
	private CampingDao campingDao;
	
	@Autowired
	private RoomDao roomDao;
	
	@Autowired
	private CommunityDao communityDao; //커뮤니티
	
	@RequestMapping(value=COMMAND)
	public ModelAndView campingDetail(HttpServletRequest request, 
								@RequestParam Map<String,String> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		//num, cnum으로 캠핑장 번호가 다르게 들어오는 경우 존재
		String num = request.getParameter("num") == null ? (String)map.get("cnum") : (String)map.get("num");
		System.out.println("num:::" + num);
		
		//캠핑장 상세내용 select
		CampingBean campbean = campingDao.getCampingDetail(num);
		mav.addObject("campbean", campbean);
		
		//객실 리스트 select(노출값만)
		map.put("cnum", num); 
		map.put("status", "01");
		List<RoomBean> lists = roomDao.getRoomList(num); //지금 cnum이 캠핑장 num라 num으로 일단 넣어서 리스트 보이게함.
		System.out.println("lists : " + lists.toString());
		mav.addObject("lists", lists); //객실리스트
		
		//후기 리스트
		map.put("reviewnum", num); //캠핑 고유번호
		map.put("reviewtype", "01"); //후기 구분자(01:캠핑/02:관광지/03:모든후기)
		map.put("status", "01"); //노출만 리스트 뿌리기.
		int communityTotalCount = communityDao.getCommunityListTotalCnt(map);
		String communityPageUrl = request.getContextPath()+ COMMAND; //페이지 URL
		Paging communityPageInfo = new Paging(map, "10", communityTotalCount, communityPageUrl);
		List<CommunityBean> communityLists = communityDao.getCommunityList(communityPageInfo, map);
	
		//별등급 가져오기. 
		map.put("reviewnum", map.get("cnum")); //캠핑 고유번호
		map.put("reviewtype", "01"); //후기 구분자(01:캠핑/02:관광지/03:모든후기)
		int startAvg = communityDao.getStarAVG(map);
		System.out.println("startAvg::::::" + startAvg);
		
		//사업자 본인 캠핑장은 조회수 카운트하지 않음
		//int cnt = campingDao.campingReadcountUp(num);
		
		mav.addObject("communityLists",communityLists); //커뮤니티 리스트
		mav.addObject("communityPageInfo", communityPageInfo); //커뮤니티 페이징 정보
		mav.addObject("communityTotalCount",communityTotalCount); //커뮤니티 총카운트
		mav.addObject("communityPageNumber", map.get("communityPageNumber")); //후기댓글 페이지
		
		mav.addObject("startAvg",startAvg); //별갯수 총카운트
		mav.addObject("pageNumber", map.get("pageNumber")); //캠핑 페이지수
		
		return mav;
	}
}
