package admin.event.controller;

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
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.WebUtil;

import admin.event.model.AdminEventBean;
import admin.event.model.AdminEventDao;
import user.postimg.model.PostimgDao;

@Controller
public class AdminEventRegisterController {

	public static final String COMMAND = "/eventRegister.ad";
	public static final String GETPAGE = "admin/event/eventRegisterForm";
	public static final String GOTOPAGE = "redirect:/eventList.ad";
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private AdminEventDao adminEventDao;
	
	@Autowired
	private PostimgDao postimgDao;
	
	@RequestMapping(value = COMMAND, method = RequestMethod.GET)
    public String adminEventRegisterView() {
		return GETPAGE;
	}
	
	@RequestMapping(value = COMMAND, method = RequestMethod.POST)
	public ModelAndView doActionPost(ModelAndView mav, HttpServletRequest request,
									@ModelAttribute("event") @Valid AdminEventBean bean,
									BindingResult result) {
		try {
			
			System.out.println("bean:" + bean.toString());
			
			//isResultErrorIgnore(Error 목록에서 특정 필드를 제외)
			if(result.hasErrors()
					&& !WebUtil.isResultErrorIgnore(result, new String[] {"imgname"}))  {
				
				System.out.println("유효성 검사 오류 S: ----------------------------------------------");
				WebUtil.resultErrorConvert(result);
				System.out.println("유효성 검사 오류 E: ----------------------------------------------");
				mav.setViewName(GETPAGE);
				return mav;
			}
			
			int cnt = -1;
			
			//내 고유번호 최대값 구하기.
			int maxNum = adminEventDao.getEventMaxNum();
			System.out.println("maxNum:::" + maxNum);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("acode", "2");
			map.put("anum", maxNum);
			map.put("regid", bean.getId());
			
			//이미지테이블에 이미지들 저장.
			String[] uploadFileList = WebUtil.fileUpload(servletContext, bean.getMultipleUpdateFile(), null);
			
			System.out.println("uploadFileList :" + uploadFileList);
			
			for (String str : uploadFileList) {
				System.out.println("file : " + str);
				
				map.put("imgname", str);
				cnt = postimgDao.insertPostimgData(map);
				bean.setImgname(str);
			}
			
			bean.setNum(maxNum);
			cnt = adminEventDao.insertData(bean);
			
			String msg = cnt < 0 ? "삽입 실패" : "삽입 성공";
			System.out.println(msg);
			
			if(cnt != -1) {
				mav.setViewName(GOTOPAGE);
				
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
