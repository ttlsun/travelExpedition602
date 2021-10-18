package admin.users.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import user.users.model.UsersBean;
import user.users.model.UsersDao;

@Controller
public class AdminUsersDetailController {
	private static final String COMMAND = "/usersDetail.ad";
	private static final String GETPAGE = "admin/userInfo/usersDetail";
	private static final String IFNULLPAGE = "/usersList.ad";
	
	@Autowired
	private UsersDao usersDao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView doAction(ModelAndView mav, HttpServletRequest request) {
		System.out.println(this.getClass()+" "+request.getMethod());
		
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		
		UsersBean usersBean = usersDao.getData(num);
		
		mav.addObject("pageNumber", pageNumber);
		if(usersBean != null) {
			mav.addObject("usersBean", usersBean);
			mav.setViewName(GETPAGE);
		} else {
			mav.setViewName(IFNULLPAGE);
		}
		return mav;
	}
}
