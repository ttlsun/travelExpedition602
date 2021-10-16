package user.tour.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.Paging;

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
		
		String pageUrl = request.getContextPath()+ COMMAND; //페이지 URL
		
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
		Paging communityPageInfo = new Paging(map, "10", communityTotalCount, pageUrl);
		List<CommunityBean> communityLists = communityDao.getCommunityList(communityPageInfo, map);
	
		//별등급 가져오기. 
		map.put("reviewnum", map.get("num")); //관광지고유번호
		map.put("reviewtype", "02"); //후기 구분자(01:캠핑/02:관광지/03:모든후기)
		int startAvg = communityDao.getStarAVG(map);
		//System.out.println("startAvg::::::" + startAvg);
		
		//조회수올리기.
		tourDao.updateTourUpcount(map);
		
		//주변관광지 리스트 (시,군) : 이건 정하셔요~ ..이게 원하시는게 맞는지 모르겠네요,, 내꺼 제외는 따로 해야할것 같아요..
		map.put("status", "01"); //노출만 보여주기.
		map.put("address1", tourbean.getAddress1()); //시
		map.put("address2", tourbean.getAddress2()); //군
		map.put("aroundAddrRegId", tourbean.getRegid()); //등록자아이디꺼만 제외
		int totalCount = tourDao.getTotalCount(map);
		Paging pageInfo = new Paging(map,"10",totalCount, pageUrl);		
		List<TourBean> lists = tourDao.getTourList(pageInfo,map);
		mav.addObject("pageInfo", pageInfo); //주변관광지 리스트 페이징 정보
		mav.addObject("totalCount", totalCount); // 주변관광지 총카운트
		mav.addObject("lists", lists); //주변관광지 리스트
		
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