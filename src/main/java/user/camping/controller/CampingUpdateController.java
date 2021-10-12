package user.camping.controller;

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

@Controller
public class CampingUpdateController {
	
	private static final String COMMAND = "/campingUpdate.do";
	private static final String GETPAGE = "user/camping/campingUpdateForm";
	private static final String GOTOPAGE = "redirect:/campingDetail.do";
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private CampingDao campingDao;
	
	@RequestMapping(value=COMMAND, method=RequestMethod.GET)
	public ModelAndView campingUpdateGet(ModelAndView mav,
								@RequestParam("num") String num,
								@RequestParam("pageNumber") String pageNumber) {
		
		//수정 아이디 확인 후, 비밀번호 입력 일치 시에 페이지 이동 가능하도록
		
		CampingBean camping = campingDao.getCampingDetail(num);
		
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("camping", camping);
		mav.addObject("originImgUrl", camping.getImgurl());
		mav.setViewName(GETPAGE);
		return mav;
	}
	
	@RequestMapping(value=COMMAND, method=RequestMethod.POST)
	public ModelAndView campingUpdatePost(ModelAndView mav,
								@RequestParam(value = "pageNumber") String pageNumber,
								@RequestParam(value = "originImgUrl") String originImgUrl,
								@ModelAttribute("camping") @Valid CampingBean campbean,
								BindingResult result) {
		System.out.println("campbean:"+campbean.toString());
		try {
		
		mav.addObject("num", campbean.getNum());
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("originImgUrl", originImgUrl);
		
		if(result.hasErrors()) {
			mav.setViewName(GETPAGE);
			return mav;
		}
		
		int cnt = -1;
		
		if(campbean.getUpdateFile() != null && !campbean.getUpdateFile().getOriginalFilename().equals("")) {
			// 대표이미지 파일 업로드
			String uploadFile = WebUtil.fileUpload(servletContext, campbean.getUpdateFile(), originImgUrl);
			System.out.println("uploadFile:" + uploadFile);
			campbean.setImgurl(uploadFile);
		}
		
		//로그인 세션에 저장되어 있는 id값 넣기
		campbean.setModid(campbean.getModid()+"id");
				
		cnt = campingDao.updateData(campbean);
		
		if(cnt != -1) {
			System.out.println("camping 수정 성공");
			mav.setViewName(GOTOPAGE);
		}
		else {
			System.out.println("camping 수정 실패");
			mav.setViewName(GETPAGE);
		}
		
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName(GETPAGE);
			System.out.println("campingUpdate 오류");
		}
		
		return mav;
	}
}
