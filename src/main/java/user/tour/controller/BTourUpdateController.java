package user.tour.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
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

import user.common.model.KeywordBean;
import user.common.model.KeywordDao;
import user.postimg.model.PostimgBean;
import user.postimg.model.PostimgDao;
import user.tour.model.TourBean;
import user.tour.model.TourDao;


@Controller
public class BTourUpdateController {
	
	private static final String COMMAND = "/bTourUpdate.do";
	private static final String GETPAGE = "user/tour/bTourUpdateForm";
	private static final String GOTOPAGE = "redirect:/bTourDetail.do";
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private TourDao tourDao;
	
	@Autowired
	private KeywordDao keywordDao;
	
	@Autowired
	private PostimgDao postimgDao;
	
	@RequestMapping(value=COMMAND, method=RequestMethod.GET)
	public ModelAndView tourUpdateGet(ModelAndView mav,
								@RequestParam("num") int num,
								@RequestParam("pageNumber") String pageNumber) {
		
		//수정 아이디 확인 후, 비밀번호 입력 일치 시에 페이지 이동 가능하도록
		
		System.out.println("num:" + num);
		
		Map<String, Object> imgMap = new HashMap<String, Object>();
		imgMap.put("acode", "5"); //커뮤니티 구분자값
		imgMap.put("anum", num); 
		List<PostimgBean> imgList = postimgDao.getPostimgList(imgMap);
		System.out.println("imgList:" + imgList.toString());
		
		String acode = "2"; //게시글 구분코드(1:캠핑/2:관광지/3:커뮤니티,4:문의)
    	List<KeywordBean> keywordLists = keywordDao.getKeywordList(acode); 
    	
		
		TourBean tour = tourDao.getTourDetail(num);
		System.out.println("tour:" + tour.getLatitude());
		System.out.println("tour:" + tour.getLongitude());
		System.out.println("tour:" + tour.toString());
		
		mav.addObject("keywordLists", keywordLists); //
		mav.addObject("imgList", imgList);
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("tour", tour);
		mav.addObject("originImgUrl", tour.getImgurl());
		mav.setViewName(GETPAGE);
		return mav;
	}
	
	@RequestMapping(value=COMMAND, method=RequestMethod.POST)
	public ModelAndView campingUpdatePost(ModelAndView mav,
								@RequestParam("num") String num,
								@RequestParam(value = "pageNumber") String pageNumber,
								@RequestParam(value = "originImgUrl") String originImgUrl,
								@ModelAttribute("tour") @Valid TourBean tourbean,
								BindingResult result) {
		try {
			
			
		String acode = "2"; //게시글 구분코드(1:캠핑/2:관광지/3:커뮤니티,4:문의)
    	List<KeywordBean> keywordLists = keywordDao.getKeywordList(acode);
	    
		Map<String, Object> imgMap = new HashMap<String, Object>();
		imgMap.put("acode", "5");
		imgMap.put("anum", num); 
		List<PostimgBean> imgList = postimgDao.getPostimgList(imgMap);
		
		System.out.println("tourbean:" + tourbean.toString());
			
		mav.addObject("keywordLists",keywordLists);
		mav.addObject("imgList",imgList);
		mav.addObject("num", tourbean.getNum());
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("originImgUrl", originImgUrl);
		
		//isResultErrorIgnore(Error 목록에서 특정 필드를 제외)
		if(result.hasErrors()
				&& !WebUtil.isResultErrorIgnore(result, new String[] {
						"address1","address2","address3","address4","imgname","imgurl","price"}))  {
			
			System.out.println("유효성 검사 오류 S: ----------------------------------------------");
			WebUtil.resultErrorConvert(result);
			System.out.println("유효성 검사 오류 E: ----------------------------------------------");
			mav.setViewName(GETPAGE);
			return mav;
		}
		
		int cnt = -1;
		
		if(tourbean.getUpdateFile() != null && !tourbean.getUpdateFile().getOriginalFilename().equals("")) {
			// 대표이미지 파일 업로드
			String uploadFile = WebUtil.fileUpload(servletContext, tourbean.getUpdateFile(), originImgUrl);
			System.out.println("uploadFile:" + uploadFile);
			tourbean.setImgurl(uploadFile);
		}
		
		

		cnt = tourDao.updateData(tourbean);
		
		if(cnt != -1) {
			System.out.println("수정 성공");
			mav.setViewName(GOTOPAGE);
		}
		else {
			System.out.println("수정 실패");
			mav.setViewName(GETPAGE);
		}
		
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName(GETPAGE);
			System.out.println("Update 오류");
		}
		
		return mav;
	}
}