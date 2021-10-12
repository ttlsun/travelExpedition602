package user.users.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.WebUtil;

import user.users.model.UsersBean;
import user.users.model.UsersDao;

@Controller
public class UsersLoginController {
	private final String COMMAND = "/login.do";
	private final String GETPAGE = "common/loginForm"; //views/common/loginForm.jsp
	/*
	 * private final String GOTOPAGE = "redirect:/main"; //메인 화면
	 */	
	@Autowired
	UsersDao usersDao;
	
	@RequestMapping(value=COMMAND, method=RequestMethod.GET)
	public ModelAndView doGet(ModelAndView mav) {
		System.out.println(this.getClass()); //추후 삭제 가능
		mav.setViewName(GETPAGE);
		return mav;
	}
	
	@RequestMapping(value=COMMAND, method=RequestMethod.POST)
	public void doPost(@Valid @ModelAttribute("users") UsersBean users, BindingResult result,
							   PrintWriter pw, HttpServletResponse response, HttpSession session) throws IOException {
		System.out.println(this.getClass()); //추후 삭제 가능
		
		pw = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		//id, pw(userpw, dbpw)
		if(result.hasErrors() && !WebUtil.isResultErrorIgnore(result, new String[]{"name","email","contact"})) {
			List<ObjectError> errors = result.getAllErrors();
			for(ObjectError error : errors){ System.out.println(error.getDefaultMessage()); }
			pw.println("<script>alert('로그인에 실패했습니다'); history.go(-1);</script>");
		} else {
			UsersBean usersBean = usersDao.login(users);
			
			if(usersBean != null) {	//아이디, 비번 모두 만족
				System.out.println("로그인 성공");
				
				session.setAttribute("loginInfo", usersBean); //유저정보 session 생성 (로그아웃 시 삭제)
				session.setMaxInactiveInterval(-1); //세션 시간 무한대로 설정
				//session.removeAttribute("loginInfo"); //위에서 생성한 session 값 삭제
				//session.invalidate(); //세션 전체 제거
				
				pw.println("<script>location.replace('main')</script>");
				//mav.setViewName(GOTOPAGE);
			} else {
				usersBean = usersDao.idCheck(users.getId()); //아이디 중복체크 했을 때
				
				if(usersBean != null) { //값이 있으면 아이디는 맞음
					pw.println("<script>alert('비밀번호를 잘못 입력하셨습니다'); history.go(-1);</script>");
				} else { //없으면 아이디 또는 둘 다 잘못 입력
					pw.println("<script>alert('아이디 또는 비밀번호를 잘못 입력하셨습니다'); history.go(-1);</script>");
				}
			}
		}
		pw.flush();
		
		return;
	}
}
