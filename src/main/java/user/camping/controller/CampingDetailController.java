package user.camping.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import user.camping.model.CampingBean;
import user.camping.model.CampingDao;
import user.room.model.RoomBean;
import user.room.model.RoomDao;

@Controller
public class CampingDetailController {
	
	private static final String COMMAND = "/campingDetail.do";
	private static final String GETPAGE = "user/camping/campingDetailView";
	
	@Autowired
	private CampingDao campingDao;
	
	@Autowired
	private RoomDao roomDao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView campingDetail(ModelAndView mav,
							@RequestParam(value="num", required=false) String num,
							@RequestParam(value="cnum", required=false) String cnum,
							@RequestParam(value="pageNumber") String pageNumber) {
		
		String camp_num = "0";
		if(cnum != null) {
			camp_num = cnum;
		}
		if(num != null) {
			camp_num = num;
		}
		
		//캠핑장 상세내용 select
		CampingBean campbean = campingDao.getCampingDetail(camp_num);
		mav.addObject("campbean", campbean);
		
		//객실 리스트 select(노출값만)
		//맵으로 바꿔서 status "01" 넣자
		List<RoomBean> lists = roomDao.getRoomList(camp_num);
		mav.addObject("lists", lists);
		
		mav.addObject("pageNumber", pageNumber);
		mav.setViewName(GETPAGE);
		return mav;
	}
}
