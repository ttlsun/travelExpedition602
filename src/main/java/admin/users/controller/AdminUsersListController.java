package admin.users.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.Paging;

import user.users.model.UsersBean;
import user.users.model.UsersDao;

@Controller
public class AdminUsersListController {
	private static final String COMMAND = "/usersList.ad";
	private static final String GETPAGE = "admin/userInfo/usersList";
	private static final String GETPAGEELSE = "redirect:/main.do";
	
	@Autowired
	private UsersDao usersDao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView doAction(ModelAndView mav, HttpServletRequest request, HttpSession session,
			@RequestParam(value="whatColumn", required=false) String whatColumn,
			@RequestParam(value="keyword", required=false) String keyword,
			@RequestParam(value="pageNumber", required=false) String pageNumber) {
		System.out.println(this.getClass()+" "+request.getMethod());
		
		UsersBean temp = (UsersBean) session.getAttribute("loginInfo");
		if(temp.getUcode().equals("admin")) {
			//ucode, id, name, email, contact, status
			Map<String, String> map = new HashMap<String, String>();
			map.put("whatColumn", whatColumn);
			map.put("keyword", "%"+keyword+"%");
			int totalCount = usersDao.getTotalCount(map);
			String url = request.getContextPath()+COMMAND;
			
			Paging pageInfo = new Paging(pageNumber, "10", totalCount, url, whatColumn, keyword);
			List<UsersBean> lists = usersDao.getList(pageInfo, map);
			
			mav.addObject("pageNumber", pageNumber);
			mav.addObject("totalCount", totalCount);
			mav.addObject("pageInfo", pageInfo);
			mav.addObject("lists", lists);
			mav.setViewName(GETPAGE);
		} else if(!temp.getUcode().equals("admin")) {
			mav.setViewName(GETPAGEELSE);
		}
		
		return mav;
	}
}
