package user.tour.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.WebUtil;

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
	private ServletContext servletContext;
	
	@Autowired
	private PostimgDao postimgDao;
	
	
	@RequestMapping(value=COMMAND)
	public ModelAndView tourDetail(ModelAndView mav,
							@RequestParam(value="num") String num,
							@RequestParam(value="pageNumber") String pageNumber
							) {
		
		TourBean tourbean = tourDao.getTourDetail(num);
		
		Map<String, Object> imgMap = new HashMap<String, Object>();
		imgMap.put("acode", "5");
		imgMap.put("anum", num);
		List<PostimgBean> imgList = postimgDao.getPostimgList(imgMap);
		System.out.println("imgList:" + imgList.toString());
		
		mav.addObject("imgList",imgList);
		mav.addObject("tourbean",tourbean);
		mav.addObject("pageNumber", pageNumber);
		
		
		
		mav.setViewName(GETPAGE);
		return mav;
	}
}