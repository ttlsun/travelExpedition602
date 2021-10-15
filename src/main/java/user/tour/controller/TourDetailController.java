package user.tour.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.Paging;
import com.my.travelExpedition.utility.WebUtil;

import user.community.model.CommunityBean;
import user.community.model.CommunityDao;
import user.postimg.model.PostimgBean;
import user.postimg.model.PostimgDao;
import user.tour.model.TourBean;
import user.tour.model.TourDao;

@Controller
public class TourDetailController {
	
	private static final String COMMAND = "/tourDetail.do";
	private static final String GETPAGE = "user/tour/tourDetailView";
	
	@Autowired
	private TourDao tourDao;
	
	@Autowired
	private PostimgDao postimgDao;
	
	@Autowired
	private CommunityDao communityDao; //커뮤니티
	
	@RequestMapping(value=COMMAND)
	public ModelAndView tourDetail(HttpServletRequest request,
							@RequestParam Map<String,String> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		//관광지상세
		int num = Integer.parseInt((String)map.get("num"));
		TourBean tourbean = tourDao.getTourDetail(num);
		
		//이미지 테이블 리스트 조회
		Map<String, Object> imgMap = new HashMap<String, Object>();
		imgMap.put("acode", "5");
		imgMap.put("anum", map.get("num"));
		List<PostimgBean> imgList = postimgDao.getPostimgList(imgMap);
		//System.out.println("imgList:" + imgList.toString());
		
		//후기 리스트
		map.put("reviewnum", map.get("num")); //관광지 번호
		map.put("reviewtype", "02"); //후기 구분자(01:캠핑/02:관광지/03:모든후기)
		map.put("status", "01"); //노출만 리스트 뿌리기.
		int communityTotalCount = communityDao.getCommunityListTotalCnt(map);
		String communityPageUrl = request.getContextPath()+ COMMAND; //페이지 URL
		Paging communityPageInfo = new Paging(map, "10", communityTotalCount, communityPageUrl);
		List<CommunityBean> communityLists = communityDao.getCommunityList(communityPageInfo, map);
	
		//별등급 가져오기. 
		map.put("reviewnum", map.get("num")); //관광지고유번호
		map.put("reviewtype", "02"); //후기 구분자(01:캠핑/02:관광지/03:모든후기)
		int startAvg = communityDao.getStarAVG(map);
		//System.out.println("startAvg::::::" + startAvg);
		
		//조회수올리기.
		tourDao.updateTourUpcount(map);
		
		
		//리스트
		
		
		
		mav.addObject("communityLists",communityLists); //커뮤니티 리스트
		mav.addObject("communityPageInfo", communityPageInfo); //커뮤니티 페이징 정보
		mav.addObject("communityTotalCount",communityTotalCount); //커뮤니티 총카운트
		mav.addObject("communityPageNumber", map.get("communityPageNumber")); //후기댓글 페이지
		
		mav.addObject("startAvg",startAvg); //별갯수 총카운트
		
		mav.addObject("pageNumber", map.get("pageNumber")); //관광지 페이지수
		mav.addObject("imgList",imgList); //이미지 리스트
		mav.addObject("tourbean",tourbean); //관광지 상세
	
		return mav;
	}
}