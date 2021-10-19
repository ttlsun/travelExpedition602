package user.room.controller;

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
import user.postimg.model.PostimgBean;
import user.postimg.model.PostimgDao;
import user.room.model.RoomBean;
import user.room.model.RoomDao;


@Controller
public class BRoomUpdateController {

	private static final String COMMAND = "/bRoomUpdate.do";
	private static final String GETPAGE = "user/room/bRoomUpdateForm";
	private static final String GOTOPAGE = "redirect:/bRoomDetail.do";
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private RoomDao roomDao;
	
	@Autowired
	private CampingDao campingDao;

	@Autowired
	private PostimgDao postimgDao;
	
	@RequestMapping(value=COMMAND, method=RequestMethod.GET)
	public ModelAndView roomUpdateGet(ModelAndView mav,
							@RequestParam("num") String num,
							@RequestParam("pageNumber") String pageNumber) {
		
		//객실 상세 정보 가져오기
		RoomBean room = roomDao.getRoomDetail(num);
		
		//해당 캠핑장 이름,유형
		CampingBean campbean = campingDao.getCampingNameAndTypes(room.getCnum()); 
		
		//파일 이미지 select
		Map<String, Object> imgMap = new HashMap<String, Object>();
		imgMap.put("acode", "4"); //커뮤니티 구분자값
		imgMap.put("anum", num); 
		List<PostimgBean> imgList = postimgDao.getPostimgList(imgMap);
		//System.out.println("imgList:" + imgList.toString());
		
		mav.addObject("room", room);
		mav.addObject("cname", campbean.getName());
		mav.addObject("camptype", campbean.getCamptype());
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("originImgUrl", room.getImgurl());
		mav.addObject("imgList", imgList);
		mav.setViewName(GETPAGE);
		return mav;
	}
	
	@RequestMapping(value=COMMAND, method=RequestMethod.POST)
	public ModelAndView roomUpdatePost(ModelAndView mav,
							@ModelAttribute("room") @Valid RoomBean roombean,
							BindingResult result,
							@RequestParam(value = "originImgUrl") String originImgUrl,
							@RequestParam("cname") String cname,
							@RequestParam("camptype") String camptype,
							@RequestParam("pageNumber") String pageNumber) {
		
		System.out.println("roomUpdate1:"+roombean.toString());
		try {
			//이미지 파일 리스트 불러오기.
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("acode", "4"); //커뮤니티 구분자값
			map.put("anum", roombean.getNum()); 
			List<PostimgBean> imgList = postimgDao.getPostimgList(map);
						
			mav.addObject("num", roombean.getNum());
			mav.addObject("cname", cname);
			mav.addObject("camptype", camptype);
			mav.addObject("pageNumber", pageNumber);
			mav.addObject("originImgUrl", originImgUrl);
			mav.addObject("imgList", imgList);
			
			if(result.hasErrors()
					&& !WebUtil.isResultErrorIgnore(result, new String[] {
							"imgurl","imgname"}))  {
				
				System.out.println("유효성 검사 오류 S: ----------------------------------------------");
				WebUtil.resultErrorConvert(result);
				System.out.println("유효성 검사 오류 E: ----------------------------------------------");
				mav.setViewName(GETPAGE);
				return mav;
			}
			
			//로그인 세션에 저장되어 있는 id값 넣기
			roombean.setModid(roombean.getModid());
			
			int cnt = -1;
			
			if(roombean.getUpdateFile() != null && !roombean.getUpdateFile().getOriginalFilename().equals("")) {
				// 대표이미지 파일 업로드
				String uploadFile = WebUtil.fileUpload(servletContext, roombean.getUpdateFile(), originImgUrl);
				System.out.println("uploadFile:" + uploadFile);
				roombean.setImgurl(uploadFile);
			}
			
			if(roombean.getMultipleUpdateFile() != null && roombean.getMultipleUpdateFile().length > 0) {
				// 파일을 지정하지 않아도 기본 배열1개가 있다 그리고 파일명이 없어서 수정되지 않은거로 파악
				if(roombean.getMultipleUpdateFile().length > 1 || !roombean.getMultipleUpdateFile()[0].getOriginalFilename().equals("")) {
					
					map.put("regid", roombean.getModid());
					// 기존파일 삭제를 위해 이미지테이블을 조회한다.
					List<PostimgBean> postImglists = postimgDao.getPostimgList(map);
					String[] arPostImgFileName = new String[postImglists.size()];
					
					for(int i = 0; i < postImglists.size(); i++) {
						arPostImgFileName[i] = postImglists.get(i).getImgname(); //이미지명
					}
					
					// 기존파일 삭제 및 추가파일 업로드
					String[] uploadFileList = WebUtil.fileUpload(servletContext, roombean.getMultipleUpdateFile(), arPostImgFileName);
					// 기존파일 DB에서 삭제
					postimgDao.deletePostimgData(map);
					
					for(String tmp : uploadFileList) {
						System.out.println("업로드파일명 : " + tmp);
						//여기에 이미지 테이블 업뎃
						map.put("imgname", tmp);
						postimgDao.insertPostimgData(map);
					}
				}else {
					//이미지테이블에도 수정관련 업뎃.(파일수정시, 기존파일 삭제후 다시 생성 로직으로 구현하여, 파일 수정안했을 경우에 수정관련 업뎃쌓아준다.)
					map.put("modid", roombean.getModid()); //수정자아이디
					postimgDao.updatePostimgData(map);
				}
			}
			
			System.out.println("roombean:"+roombean.toString());
			cnt = roomDao.updateData(roombean);
			
			if(cnt != -1) {
				System.out.println("room 수정 성공");
				mav.setViewName(GOTOPAGE);
			}
			else {
				System.out.println("room 수정 실패");
				mav.setViewName(GETPAGE);
			}
			
			} catch (Exception e) {
				e.printStackTrace();
				mav.setViewName(GETPAGE);
				System.out.println("roomUpdate 오류");
			}
			
			return mav;
	}
}
