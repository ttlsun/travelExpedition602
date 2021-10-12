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

import user.camping.model.CampingBean;
import user.camping.model.CampingDao;
import user.common.model.KeywordBean;
import user.common.model.KeywordDao;
import user.postimg.model.PostimgDao;
import user.tour.model.TourBean;
import user.tour.model.TourDao;

@Controller
public class TourRegisterController {
	
	private static final String COMMAND = "/tourRegister.do";
	private static final String GETPAGE = "user/tour/tourRegisterForm";
	private static final String GOTOPAGE = "redirect:/tourList.do";
	
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private TourDao tourDao;
	
	@Autowired
	private KeywordDao keywordDao;
	
	@Autowired
	private PostimgDao postimgDao;
	
	@RequestMapping(value=COMMAND, method=RequestMethod.GET)
	public ModelAndView tourRegisterGet(ModelAndView mav) {
		
		mav.setViewName(GETPAGE);
		
    	String acode = "2"; //게시글 구분코드(1:캠핑/2:관광지/3:커뮤니티,4:문의)
    	List<KeywordBean> keywordLists = keywordDao.getKeywordList(acode); 
    	mav.addObject("keywordLists", keywordLists);
    	
		return mav;
	}
	
	@RequestMapping(value=COMMAND, method=RequestMethod.POST)
	public ModelAndView tourRegisterPost(ModelAndView mav,
									@ModelAttribute("tour") @Valid TourBean tourbean, 
									BindingResult result,
									@RequestParam(value="coordsMa",required = false) String longitude,
									@RequestParam(value="coordsLa",required = false) String latitude) {
		
		
		System.out.println("tourbean:" + tourbean.toString());
		
		try {
		
			//isResultErrorIgnore(Error 목록에서 특정 필드를 제외)
			if(result.hasErrors()
					&& !WebUtil.isResultErrorIgnore(result, new String[] {
							"imgurl","imgname"}))  {
				
				System.out.println("유효성 검사 오류 S: ----------------------------------------------");
				WebUtil.resultErrorConvert(result);
				System.out.println("유효성 검사 오류 E: ----------------------------------------------");
				mav.setViewName(GETPAGE);
				return mav;
			}
			
			int cnt = -1;
			
			//대표이미지 파일 업로드 
			String uploadFile = WebUtil.fileUpload(servletContext, tourbean.getUpdateFile(), null);
			System.out.println("uploadFile:" + uploadFile);
			tourbean.setImgurl(uploadFile);
			
			//System.out.println("bean.getImgurl():" + bean.getImgurl());
			//이미지를 안넣을 경우 , 
			if(tourbean.getImgurl() ==null || tourbean.getImgurl().equals("")) {
				mav.setViewName(GETPAGE);
				return mav;
			}
			
			//내 고유번호 최대값 구하기.
			int maxNum = tourDao.getTourMaxNum(); 
			
			System.out.println("maxNum:::" + maxNum);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("acode", "5");
			map.put("anum", maxNum);
			map.put("regid", tourbean.getRegid());
			
			//이미지테이블에 이미지들 저장.
			String[] uploadFileList = WebUtil.fileUpload(servletContext, tourbean.getMultipleUpdateFile(), null);
			for (String str : uploadFileList) {
				System.out.println("file : " + str);
				
				map.put("imgname", str);
				cnt = postimgDao.insertPostimgData(map);
				tourbean.setImgname(str);
			}
			
			
			tourbean.setNum(maxNum);
			
			//관광지 레코드 insert
			cnt = tourDao.insertData(tourbean);
			
			if(cnt != -1) {
				System.out.println("관광지 등록 성공");
				mav.setViewName(GOTOPAGE);
			}
			else {
				System.out.println("관광지 등록 실패");
				mav.setViewName(GETPAGE);
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName(GETPAGE);
			System.out.println("관광지 등록 오류");
		}
		
		return mav;
	}
	
}
