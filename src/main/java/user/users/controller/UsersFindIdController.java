package user.users.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.WebUtil;

import user.users.model.UsersBean;
import user.users.model.UsersDao;

@Controller
public class UsersFindIdController {
	private final String COMMAND = "/usersFindId.do";
	private final String GETPAGE = "common/findIdForm"; //views/common/findIdForm.jsp
	
	@Autowired
	UsersDao usersDao;
	
	@RequestMapping(value = COMMAND, method = RequestMethod.GET)
	public ModelAndView doGet(ModelAndView mav, HttpServletRequest request) {
		System.out.println(this.getClass()+" "+request.getMethod()); //추후 삭제 가능
		mav.setViewName(GETPAGE);
		return mav;
	}
	
	@RequestMapping(value = COMMAND, method = RequestMethod.POST)
	public void doPost(@Valid @ModelAttribute("users") UsersBean users, BindingResult result,
							   PrintWriter pw, HttpServletResponse response, HttpServletRequest request) throws IOException {
		System.out.println(this.getClass()+" "+request.getMethod()); //추후 삭제 가능
		
		pw = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		//name, email
		if(result.hasErrors() && !WebUtil.isResultErrorIgnore(result, new String[]{"id","pw","contact"})) {
			pw.println("<script>alert('아이디 찾기에 실패했습니다'); history.go(-1);</script>");
		} else {
			UsersBean usersBean = usersDao.findId(users);
			
			if(usersBean != null) {
				String name = users.getName();
				String id = usersBean.getId();
				
				pw.println("<script>alert('아이디 찾기에 성공했습니다');</script>");
				pw.println("<script>alert('"+name+" 님의 아이디는 "+id+" 입니다.'); location.replace('login.do');</script>");
			} else {
				pw.println("<script>alert('아이디 찾기에 실패했습니다'); history.go(-1);</script>");
			}
		}
		pw.flush();
		
		return;
	}
}
