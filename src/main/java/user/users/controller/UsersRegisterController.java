package user.users.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import user.users.model.UsersBean;
import user.users.model.UsersDao;

@Controller
public class UsersRegisterController {
	private final String COMMAND = "/usersReigster.do";
	private final String GETPAGE = "user/users/usersRegisterForm"; //views/user/users/usersRegisterForm.jsp
	private final String GOTOPAGE = "redirect:/login.do"; //로그인 화면
	
	@Autowired
	UsersDao usersDao;
	
	//회원가입 버튼을 누르면 usersRegister.do(GET) 요청
	@RequestMapping(value=COMMAND, method=RequestMethod.GET)
	public ModelAndView doGET(ModelAndView mav, HttpServletRequest request) {
		System.out.println(this.getClass()+" "+request.getMethod()); //추후 삭제 가능
		mav.setViewName(GETPAGE);
		return mav;
	}
	
	//userRegisterForm.jsp 에서 유효성 검사 성공하면 action usersRegister.do(POST) 요청
	@RequestMapping(value=COMMAND, method=RequestMethod.POST)
	public ModelAndView doPost(@Valid @ModelAttribute("users") UsersBean users, BindingResult result, HttpServletRequest request, ModelAndView mav) throws IOException {
		System.out.println(this.getClass()+" "+request.getMethod()); //추후 삭제 가능
		
		if(result.hasErrors()) {
			List<ObjectError> errors = result.getAllErrors();
			for(ObjectError error : errors){ System.out.println(error.getDefaultMessage()); }
			System.out.println("회원가입 실패 - result");
			mav.setViewName(GETPAGE);
		} else {
			if(users.getAddress1() != "") {
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
				
				users.setGender("");
			} else {
				users.setAddress1("");
				users.setAddress2("");
				users.setAddress3("");
				users.setAddress4("");
			}
			
			users.setStatus("가입완료");
			
			//usersDao에서 registerUsers(), return int(cnt)
			int cnt = -1;
			cnt = usersDao.registerUsers(users); //여기서 오류 발생중
			
			//성공(-1아님)이면 gotoPage, 실패(-1)면 getPage
			if(cnt != -1) {
				System.out.println("회원가입 성공");
				mav.setViewName(GOTOPAGE);
			} else {
				System.out.println("회원가입 실패 - dao");
				mav.setViewName(GETPAGE);
			}
		}
		
		return mav;
	}
}
