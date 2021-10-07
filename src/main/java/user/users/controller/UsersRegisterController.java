package user.users.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import user.users.model.UsersBean;
import user.users.model.UsersDao;

@Controller
public class UsersRegisterController {
	private final String COMMAND = "/usersReigster.do";
	private final String GETPAGE = "user/users/usersRegisterForm"; //views/user/users/usersRegisterForm.jsp
	private final String GOTOPAGE = "login.do"; //로그인 화면
	
	@Autowired
	UsersDao usersDao;
	
	//회원가입 버튼을 누르면 usersRegister.do(GET) 요청
	@RequestMapping(value=COMMAND, method=RequestMethod.GET)
	public ModelAndView doGET(ModelAndView mav) {
		System.out.println(this.getClass()); //추후 삭제 가능
		mav.setViewName(GETPAGE);
		return mav;
	}
	
	//userRegisterForm.jsp 에서 유효성 검사 성공하면 action usersRegister.do(POST) 요청
	//@Valid UsersBean users, BindingResult result
	@RequestMapping(value=COMMAND, method=RequestMethod.POST)
	public ModelAndView doPost(@Valid UsersBean users, BindingResult result,
							   ModelAndView mav, PrintWriter pw, HttpServletResponse response) throws IOException {
		System.out.println(this.getClass()); //추후 삭제 가능
		
		pw = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		if(result.hasErrors()) {
			mav.setViewName(GETPAGE);
			pw.println("<script>alert('회원가입에 실패했습니다');</script>");
		} else {
			//result에 오류가 없다면, 값 변형 및 추가(getter->split(or something else)->setter || setter)
			//그대로 들어가는 값 ucode, name, gender, id, pw, postcode, email
			//변형해야 하는 값 address1, address2, contact(-가 들어있을 경우)
			//추가해야 하는 값 status="가입완료"
			String[] address_tmp = users.getAddress1().split(" ");
			String address1 = address_tmp[0];
			String address2 = address_tmp[1];
			String address3 = address_tmp[2];
			String address4 = "";
			for(int i=3; i<address_tmp.length; i++) {
				address4 += address_tmp[i]+" ";
			}
			address4 += users.getAddress2();
			users.setAddress1(address1);
			users.setAddress2(address2);
			users.setAddress3(address3);
			users.setAddress4(address4);
			
			if(users.getContact().contains("-")) {
				String[] contact_tmp = users.getContact().split("-");
				String contact_tmp2 = "";
				for(int i=0; i<contact_tmp.length; i++) {
					contact_tmp2 += contact_tmp[i];
				}
				users.setContact(contact_tmp2);
			}
			
			users.setStatus("가입완료");
			
			//usersDao에서 registerUsers(), return int(cnt)
			int cnt = -1;
			cnt = usersDao.registerUsers(users);
			
			//성공(-1아님)이면 gotoPage, 실패(-1)면 getPage
			if(cnt != -1) {
				mav.setViewName(GOTOPAGE);
				pw.println("<script>alert('회원가입에 성공했습니다');</script>");
			} else {
				mav.setViewName(GETPAGE);
				pw.println("<script>alert('회원가입에 실패했습니다');</script>");
			}
		}
		pw.flush();
		
		return mav;
	}
}
