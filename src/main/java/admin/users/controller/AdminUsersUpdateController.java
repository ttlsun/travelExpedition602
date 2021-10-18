package admin.users.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import user.users.model.UsersBean;
import user.users.model.UsersDao;

@Controller
public class AdminUsersUpdateController {
	private static final String COMMAND = "/usersUpdate.ad";
	private static final String GETPAGE = "admin/userInfo/usersUpdateForm";
	
	@Autowired
	private UsersDao usersDao;
	
	@RequestMapping(value = COMMAND, method = RequestMethod.GET)
	public ModelAndView doGet(ModelAndView mav, HttpServletRequest request) {
		System.out.println(this.getClass()+" "+request.getMethod());
		
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		
		UsersBean usersBean = usersDao.getData(num);
		if(usersBean.getGender() != "" && usersBean.getGender() != null) {
			if(usersBean.getGender().equals("남")) {
				usersBean.setGender("남성");
			} else if(usersBean.getGender().equals("여")){
				usersBean.setGender("여성");
			}
		}
		
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("usersBean", usersBean);
		mav.setViewName(GETPAGE);
		return mav;
	}
	
	@RequestMapping(value = COMMAND, method = RequestMethod.POST)
	public void doPost(PrintWriter pw, HttpServletResponse response, HttpServletRequest request, HttpSession session) throws IOException {
		System.out.println(this.getClass()+" "+request.getMethod());
		
		pw = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		String ucode = request.getParameter("ucode");
		String gender = request.getParameter("gender");
		String birth = request.getParameter("birth");
		String status = request.getParameter("status");
		
		UsersBean temp = (UsersBean) session.getAttribute("loginInfo");
		String modid = temp.getId();
		
		if(ucode.equals("business")) {
			gender = "";
		}
		
		UsersBean usersBean = new UsersBean();
		usersBean.setNum(num);
		usersBean.setGender(gender);
		usersBean.setBirth(birth);
		usersBean.setStatus(status);
		usersBean.setModid(modid);
		
		int cnt = -1;
		cnt = usersDao.updateUserInfo(usersBean);
		
		if(cnt != -1) {
			pw.println("<script>alert('회원정보 수정이 완료되었습니다'); location.replace('usersDetail.ad?num="+num+"&pageNumber="+pageNumber+"');</script>");
		} else {
			pw.println("<script>alert('회원정보 수정에 실패했습니다'); history.go(-1);</script>");
		}
		
		return;
	}
}
