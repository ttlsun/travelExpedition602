package admin.keyword.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.Paging;

import admin.keyword.model.AdminPostimgDao;
import user.postimg.model.PostimgBean;

@Controller
public class AdminPostImgListController {

	public static final String COMMAND = "/postimgList.ad";
	public static final String GETPAGE = "admin/keyword/postimgList";
	
	@Autowired
	private AdminPostimgDao adminPostimgDao;
	
	@RequestMapping(value = COMMAND)
    public ModelAndView adminPostImgListView(HttpServletRequest request, @RequestParam Map<String, String> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		int totalCount = adminPostimgDao.getPostimgsListTotalCnt(map);
	
		String pageUrl = request.getContextPath() + COMMAND; //페이지 URL
		
		Paging pageInfo = new Paging(map, "10", totalCount, pageUrl);
		List<PostimgBean> lists = adminPostimgDao.getPostimgLists(pageInfo, map);
		
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("totalCount", totalCount);
		mav.addObject("lists", lists);
		
		return mav;
	}
}
