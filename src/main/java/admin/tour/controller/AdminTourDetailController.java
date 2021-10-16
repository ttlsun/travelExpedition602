package admin.tour.controller;

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

import user.community.model.CommunityDao;
import user.postimg.model.PostimgBean;
import user.postimg.model.PostimgDao;
import user.tour.model.TourBean;
import user.tour.model.TourDao;

@Controller
public class AdminTourDetailController {

	private static final String COMMAND = "/tourDetail.ad";
	private static final String GETPAGE = "admin/tour/tourDetailView";
	public static final String GOTOPAGE = "redirect:/tourList.ad";
	public static final String GOTOPAGE_DETAIL = "redirect:/tourDetail.ad";
	
	@Autowired
	private TourDao tourDao;
	
	@Autowired
	private PostimgDao postimgDao;
	
	@Autowired
	private CommunityDao communityDao; //커뮤니티
	
	@RequestMapping(value=COMMAND, method = RequestMethod.GET)
	public ModelAndView tourDetail(HttpServletRequest request,
							@RequestParam Map<String,String> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		//관리자 페이지에서는 조회수 올릴필요없어요.... 사용자단에서는 올려야합니다...사업자도 안됨!!
		
		//관광지상세
		int num = Integer.parseInt((String)map.get("num"));
		TourBean tourbean = tourDao.getTourDetail(num);
		
		//이미지 테이블 리스트 조회
		Map<String, Object> imgMap = new HashMap<String, Object>();
		imgMap.put("acode", "5");
		imgMap.put("anum", map.get("num"));
		List<PostimgBean> imgList = postimgDao.getPostimgList(imgMap);
		//System.out.println("imgList:" + imgList.toString());
		
		//별등급 가져오기. 
		map.put("reviewnum", map.get("num")); //관광지고유번호
		map.put("reviewtype", "02"); //후기 구분자(01:캠핑/02:관광지/03:모든후기)
		int startAvg = communityDao.getStarAVG(map);
		
		mav.addObject("startAvg",startAvg); //별갯수 총카운트
		
		mav.addObject("pageNumber", map.get("pageNumber")); //관광지 페이지수
		mav.addObject("imgList",imgList); //이미지 리스트
		mav.addObject("tourbean",tourbean); //관광지 상세
	
		return mav;
	}
	
	@RequestMapping(value = COMMAND, method = RequestMethod.POST)
    public ModelAndView communityDetailPost(ModelAndView mav,
    										@RequestParam (value = "num") int num,
    										@RequestParam (value = "pageNumber") String pageNumber,
    										@RequestParam (value = "status") String status) {
		
		System.out.println("num:" + num + " ,status : " + status);
		
		try {
			
			if(status.equals("00")) {
				
				//이미지파일들 테이블 삭제.. 서버에 있는 이미지 삭제..
				
				//삭제일경우에만 리스트로 가게..하셔요.. 저는 깜빡하고 리스트로 가게했네요 ㅠㅠ..
				mav.setViewName(GOTOPAGE);
			}else {
				//완전삭제가 아닐경우, 상태값만 업뎃
				
				mav.setViewName(GOTOPAGE_DETAIL);
			}
			
			mav.addObject("pageNumber", pageNumber);
			mav.addObject("num", num);
			
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println("내부오류");
		}
		
		return mav;
	}
	
	
}
