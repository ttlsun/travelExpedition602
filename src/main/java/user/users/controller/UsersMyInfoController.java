package user.users.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.WebUtil;

import user.pay.model.PayBean;
import user.pay.model.PayDao;
import user.users.model.UsersBean;
import user.users.model.UsersDao;

@Controller
public class UsersMyInfoController {
	private final String COMMAND = "/usersMyInfo.do";
	private final String COMMANDBYE = "/usersBye.do";
	private final String COMMANDUPDATE = "/usersUpdateMyInfo.do"; 
	private final String COMMANDUPDATEPW = "/usersUpdateMyPw.do";
	
	private final String GETPAGE = "user/users/usersMyInfo";
	private final String GOTOBYEPWCHK = "user/users/ByePwCheck";
	private final String GOTOUPDATEFORM = "user/users/usersMyInfoUpdateForm";
	private final String GOTOUPDATEPWFORM = "user/users/usersPwUpdateForm";
	
	@Autowired
	private UsersDao usersDao;
	
	@Autowired
	private PayDao payDao;
	
	//내정보 화면 이동
	@RequestMapping(value=COMMAND, method=RequestMethod.GET)
	public ModelAndView doGet(ModelAndView mav, HttpServletRequest request){
		System.out.println(this.getClass()+" "+request.getMethod());
		mav.setViewName(GETPAGE);
		return mav;
	}
	
	//회원탈퇴 -> 비밀번호 입력 뷰 (회원탈퇴확인)
	@RequestMapping(value=COMMANDBYE, method=RequestMethod.GET)
	public ModelAndView byeGET(ModelAndView mav, HttpServletRequest request) {
		System.out.println(this.getClass()+" "+request.getMethod());
		mav.setViewName(GOTOBYEPWCHK);
		return mav;
	}
	
	//회원탈퇴진행
	@RequestMapping(value=COMMANDBYE, method=RequestMethod.POST)
	public void byePOST(@Valid @ModelAttribute("users") UsersBean users, BindingResult result,
			PrintWriter pw, HttpServletResponse response, ModelAndView mav, HttpServletRequest request, HttpSession session) throws IOException {
		System.out.println(this.getClass()+" "+request.getMethod());
		
		pw = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		//pw
		if(result.hasErrors() && !WebUtil.isResultErrorIgnore(result, new String[]{"id", "name", "email", "contact"})) {
			pw.println("<script>alert('회원 탈퇴에 실패했습니다'); history.go(-1);</script>");
		} else {
			UsersBean temp = (UsersBean) session.getAttribute("loginInfo");
			users.setId(temp.getId());
			
			int cnt = -1;
			cnt = usersDao.byeUsers(users); //status 탈퇴보류중으로 변경 -> 관리자 확인시 회원탈퇴로 변경
			session.invalidate();
			
			if(cnt != -1) {
				pw.println("<script>alert('회원 탈퇴가 완료되었습니다'); location.replace('main.do');</script>");
			} else {
				pw.println("<script>alert('잘못된 비밀번호입니다.'); history.go(-1);</script>");
			}
		}
		pw.flush();
		
		return;
	}
	
	//정보변경 -> 변경사항 입력 뷰
	@RequestMapping(value=COMMANDUPDATE, method=RequestMethod.GET)
	public ModelAndView updateMyInfo(ModelAndView mav, HttpServletRequest request) {
		System.out.println(this.getClass()+" "+request.getMethod());
		mav.setViewName(GOTOUPDATEFORM);
		return mav;
	}
	
	//정보변경진행
	@RequestMapping(value=COMMANDUPDATE, method=RequestMethod.POST)
	public void updateMyInfoPost(@Valid @ModelAttribute("users") UsersBean users, BindingResult result,
			PrintWriter pw, HttpServletResponse response, HttpServletRequest request, HttpSession session) throws IOException {
		System.out.println(this.getClass()+" "+request.getMethod());
		
		pw = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		//name, email, contact
		if(result.hasErrors() && !WebUtil.isResultErrorIgnore(result, new String[]{"id", "pw"})){
			pw.println("<script>alert('정보를 수정하지 못했습니다'); history.go(-1);</script>");
		} else {
			if(users.getAddress1().trim().length() != 0) {
				System.out.println("*"+users.getAddress1()+"*");
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
			
			users.setModid(users.getId());
			UsersBean temp = (UsersBean) session.getAttribute("loginInfo");
			
			int cnt = -1;
			cnt = usersDao.updateMyInfo(users);
			
			//사용자의 pay 테이블 paycode에 휴대폰결제가 있으면 paydetail2도 변경할 것
			if(!users.getContact().equals(temp.getContact())) {
				Map<String, String> map = new HashMap<String, String>();
				map.put("whatColumn", "paycode");
				map.put("keyword", "%휴대폰결제%");
				map.put("id", temp.getId());
				int paycount = -1;
				paycount = payDao.getTotalCount(map);
				if(paycount > 0) {
					String paydetail2 = users.getContact().replace("-", "");
					PayBean payBean = new PayBean();
					payBean.setId(users.getId());
					payBean.setPaycode("휴대폰결제");
					payBean.setPaydetail2(paydetail2);
					payBean.setModid(temp.getId());
					payDao.updatePaydetail(payBean);
				}
			}
			
			if(cnt != -1) {
				//session.invalidate();
				UsersBean usersBean = usersDao.login(temp);
				
				session.setAttribute("loginInfo", usersBean); //유저정보 session 생성 (로그아웃 시 삭제)
				session.setMaxInactiveInterval(-1); //세션 시간 무한대로 설정
				
				pw.println("<script>alert('정보 수정이 완료되었습니다'); location.replace('usersMyInfo.do');</script>");
			} else {
				pw.println("<script>alert('정보 수정에 실패했습니다'); history.go(-1);</script>");
			}
		}
		pw.flush();
		
		return;
	}
	
	//비밀번호변경 -> 비밀번호 변경 뷰
	@RequestMapping(value=COMMANDUPDATEPW, method=RequestMethod.GET)
	public ModelAndView updateMyPw(ModelAndView mav, HttpServletRequest request) {
		System.out.println(this.getClass()+" "+request.getMethod());
		mav.setViewName(GOTOUPDATEPWFORM);
		return mav;
	}
	
	//비밀번호변경진행
	@RequestMapping(value=COMMANDUPDATEPW, method=RequestMethod.POST)
	public void updateMyPwPost(PrintWriter pw, HttpServletResponse response, HttpServletRequest request, HttpSession session) throws IOException {
		System.out.println(this.getClass()+" "+request.getMethod());
		
		pw = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		UsersBean temp = (UsersBean) session.getAttribute("loginInfo");
		String[] currentPw_arr = request.getParameterValues("currentPw");
		String currentPw = "";
		for(int i=0; i<currentPw_arr.length; i++) {
			currentPw += currentPw_arr[i];
		}
		String[] newPw_arr = request.getParameterValues("pw");
		String newPw = "";
		for(int i=0; i<newPw_arr.length; i++) {
			newPw += newPw_arr[i];
		}
		
		if(!currentPw.equals(temp.getPw())) {
			pw.println("<script>alert('현재 비밀번호를 잘못 입력하셨습니다'); history.go(-1);</script>");
		} else {
			temp.setPw(newPw);
			
			int cnt = -1;
			cnt = usersDao.updatePw(temp);
			
			if(cnt != -1) {
				UsersBean usersBean = usersDao.login(temp);
				
				session.setAttribute("loginInfo", usersBean); //유저정보 session 생성 (로그아웃 시 삭제)
				session.setMaxInactiveInterval(-1); //세션 시간 무한대로 설정
				
				pw.println("<script>alert('비밀번호 수정이 완료되었습니다'); location.replace('usersMyInfo.do');</script>");
			} else {
				pw.println("<script>alert('비밀번호 수정에 실패했습니다'); history.go(-1);</script>");
			}
		}
		pw.flush();
		
		return;
	}
}
