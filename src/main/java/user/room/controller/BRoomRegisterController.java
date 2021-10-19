package user.room.controller;

import java.util.HashMap;
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
import user.postimg.model.PostimgDao;
import user.room.model.RoomBean;
import user.room.model.RoomDao;


@Controller
public class BRoomRegisterController {

	private static final String COMMAND = "/bRoomRegister.do";
	private static final String GETPAGE = "user/room/bRoomRegisterForm";
	private static final String GOTOPAGE = "redirect:/bCampingDetail.do";
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private RoomDao roomDao;
	
	@Autowired
	private CampingDao campingDao;
	
	@Autowired
	private PostimgDao postimgDao;
	
	@RequestMapping(value=COMMAND, method=RequestMethod.GET)
	public ModelAndView roomRegisterGet(ModelAndView mav,
								@RequestParam("num") String num,
								@RequestParam("pageNumber") String pageNumber) {
		
		//해당 캠핑장 이름, 유형
		CampingBean campbean = campingDao.getCampingNameAndTypes(Integer.parseInt(num)); 
		
		mav.addObject("cnum", num);
		mav.addObject("cname", campbean.getName());
		mav.addObject("camptype", campbean.getCamptype());
		mav.addObject("pageNumber", pageNumber);
		mav.setViewName(GETPAGE);
		return mav;
	}
	
	@RequestMapping(value=COMMAND, method=RequestMethod.POST)
	public ModelAndView roomRegisterPost(ModelAndView mav,
								@ModelAttribute("room") @Valid RoomBean roombean,
								BindingResult result,
								@RequestParam("cnum") String cnum,
								@RequestParam("cname") String cname,
								@RequestParam("camptype") String camptype,
								@RequestParam("pageNumber") String pageNumber) {
				
		mav.addObject("cnum", cnum);
		mav.addObject("cname", cname);
		mav.addObject("camptype", camptype);
		mav.addObject("pageNumber", pageNumber);
		
		System.out.println("roombean:" + roombean.toString());
		
		try {
			
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
			String uploadFile;
			
			uploadFile = WebUtil.fileUpload(servletContext, roombean.getUpdateFile(), null);
		
			System.out.println("uploadFile:" + uploadFile);
			roombean.setImgurl(uploadFile);
		
			//대표이미지 넣지 않은 경우
			if(roombean.getImgurl() == null || roombean.getImgurl().equals("")) {
				mav.setViewName(GETPAGE);
				return mav;
			}
			
			//room고유번호 최댓값
			int maxNum = roomDao.getRoomMaxNum();
			
			//로그인 세션에 저장되어 있는 id값 넣기
			roombean.setRegid(roombean.getRegid());
			
			//이미지테이블에 상세 이미지들 저장.
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("acode", "4");
			map.put("anum", maxNum);
			map.put("regid", roombean.getRegid());
			
			String[] uploadFileList = WebUtil.fileUpload(servletContext, roombean.getMultipleUpdateFile(), null);
			for (String str : uploadFileList) {
				System.out.println("file : " + str);
				
				//map.put("imgname", str);
				//cnt = postimgDao.insertPostimgData(map);
				//roombean.setImgname(str);
				
				//파일이 있을경우만, 이미지테이블에 데이터를 쌓는다.
				if(str != null) {
					map.put("imgname", str);
					cnt = postimgDao.insertPostimgData(map);
					roombean.setImgname(str);
				}
				
			}
						
			//room 레코드 insert
			roombean.setNum(maxNum);
			cnt = roomDao.insertData(roombean);
			
			if(cnt != -1) {
				System.out.println("room 등록 성공");
				mav.setViewName(GOTOPAGE);
			}
			else {
				System.out.println("room 등록 실패");
				mav.setViewName(GETPAGE);
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName(GETPAGE);
			System.out.println("roomRegister 오류");
		}
		
		return mav;
	}
}
