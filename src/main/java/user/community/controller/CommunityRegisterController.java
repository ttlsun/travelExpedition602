package user.community.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.WebUtil;

import user.community.model.CommunityBean;
import user.community.model.CommunityDao;
import user.postimg.model.PostimgDao;
import user.rating.model.RatingDao;

@Controller
public class CommunityRegisterController {

	public static final String COMMAND = "/communityRegister.do";
	public static final String GETPAGE = "user/community/communityRegisterForm";
	
	public static final String GOTOPAGE = "redirect:/communityList.do";
	public static final String GOTOPAGE_REVIEW = "redirect:/reviewCommunityList.do";
	public static final String GOTOPAGE_RESERVATION = "redirect:/reservationCommunityList.do";
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private CommunityDao communityDao;
	
	@Autowired
	private PostimgDao postimgDao;
	
	@Autowired
	private RatingDao ratingDao;
	
	
	@RequestMapping(value = COMMAND, method = RequestMethod.GET)
	public ModelAndView communityRegisterView(HttpServletRequest request,
											  @RequestParam(value = "type",required = false) String type,
											  @RequestParam(value = "reviewtype") String reviewtype) {
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		//리뷰고유번호 (캠핑번호 or 관광지 번호)
		String reviewnum = request.getParameter("reviewnum") == null ? "0" : request.getParameter("reviewnum");
		//예약 번호
		String reservationnum = request.getParameter("reservationnum") == null ? "0" : request.getParameter("reservationnum");
		
		mav.addObject("reviewType", reviewtype); //리뷰타입 (01:캠핑/글램핑,02:관광지,03:커뮤니티후기)
		mav.addObject("reviewnum", reviewnum); //리뷰고유번호 (캠핑번호 or 관광지 번호)
		mav.addObject("reservationnum", reservationnum); //예약자번호
		mav.addObject("type", type); //페이지 타입.(1:모든후기,2:방문후기 , 3:My후기)
		
		return mav;
	}
	
	@RequestMapping(value = COMMAND, method = RequestMethod.POST)
	public ModelAndView doActionPost(ModelAndView mav, HttpServletRequest request,
									@RequestParam(value = "type",required = false) String type,
									@RequestParam(value = "reviewType",required = false) String reviewType,
									@RequestParam(value = "reviewnum",required = false) String reviewnum,
									@RequestParam(value = "reservationnum",required = false) String reservationnum,
									@ModelAttribute("community") @Valid CommunityBean bean,
									BindingResult result) {
		try {
			
			
			mav.addObject("reviewType", reviewType); //리뷰타입 (01:캠핑/글램핑,02:관광지,03:커뮤니티후기)
			mav.addObject("type", type); //페이지 타입.
			mav.addObject("reviewnum", reviewnum); //리뷰고유번호 (캠핑번호 or 관광지 번호)
			mav.addObject("reservationnum", reservationnum); //예약자번호
			
//			ObjectMapper mapper = new ObjectMapper();
//			mapper.disable(Feature.FAIL_ON_EMPTY_BEANS);
//			System.out.println("bean:" + mapper.writeValueAsString(bean));
			System.out.println("bean:" + bean.toString());
			
			//isResultErrorIgnore(Error 목록에서 특정 필드를 제외)
			if(result.hasErrors()
					&& !WebUtil.isResultErrorIgnore(result, new String[] {
							"imgurl","imgname","reservationnum","reviewnum"}))  {
				
				System.out.println("유효성 검사 오류 S: ----------------------------------------------");
				WebUtil.resultErrorConvert(result);
				System.out.println("유효성 검사 오류 E: ----------------------------------------------");
				mav.setViewName(GETPAGE);
				return mav;
			}
			
			int cnt = -1;
			
			//대표이미지 파일 업로드
			String uploadFile = WebUtil.fileUpload(servletContext, bean.getUpdateFile(), null);
			System.out.println("uploadFile:" + uploadFile);
			bean.setImgurl(uploadFile);
			
			//System.out.println("bean.getImgurl():" + bean.getImgurl());
			//이미지를 안넣을 경우 , 
			if(bean.getImgurl() ==null || bean.getImgurl().equals("")) {
				mav.setViewName(GETPAGE);
				return mav;
			}
			
			//내 고유번호 최대값 구하기.
			int maxNum = communityDao.getCommunityMaxNum();
			
			System.out.println("maxNum:::" + maxNum);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("acode", "6");
			map.put("anum", maxNum);
			map.put("regid", bean.getRegid());
			
			//이미지테이블에 이미지들 저장.
			String[] uploadFileList = WebUtil.fileUpload(servletContext, bean.getMultipleUpdateFile(), null);
			for (String str : uploadFileList) {
				System.out.println("file : " + str);
				
				map.put("imgname", str);
				cnt = postimgDao.insertPostimgData(map);
				bean.setImgname(str);
			}
			
			//System.out.println("maxNum:::" + maxNum);
			
			//타입이 후기 일경우, 별등급 테이블에 별 등급을 쌓지 않음.
			if(!bean.getReviewtype().equals("03")) {
				//등급별 테이블에 저장.
				map.put("reviewnum", maxNum);
				map.put("reviewtype", bean.getReviewtype());
				map.put("ratingtype", "03");
				map.put("starranking", bean.getStarranking());
				map.put("regid", bean.getRegid());
				ratingDao.insertRatingData(map);
				
				//캠핑 or 관광지 리뷰수 올려주기.
				Map<String, Object> reviceCountMap = new HashMap<String, Object>();
				reviceCountMap.put("reviewnum", reviewnum);
				reviceCountMap.put("reviewtype", reviewType);
				communityDao.updateReviewCount(reviceCountMap);
			}
			
			//후기 저장.
			bean.setNum(maxNum);
			cnt = communityDao.insertData(bean);
			
			String msg = cnt < 0 ? "삽입 실패" : "삽입 성공";
			System.out.println(msg);
			
			if(cnt != -1) {
				if(type.equals("3")) {
					mav.setViewName(GOTOPAGE_RESERVATION);
				}else if(type.equals("2")) {
					mav.setViewName(GOTOPAGE_REVIEW);
				}else {
					mav.setViewName(GOTOPAGE);
				}
				
			}else {
				mav.setViewName(GETPAGE);
				return mav;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName(GETPAGE);
			System.out.println("내부 오류");
		}
		
		return mav;
	}
	
}
