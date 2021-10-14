package user.pay.controller;

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

import user.pay.model.PayBean;
import user.pay.model.PayDao;
import user.users.model.UsersBean;

@Controller
public class payRegisterController {
	private static final String COMMAND = "/payRegister.do";
	private static final String GETPAGE = "user/pay/payRegisterForm";
	
	@Autowired
	private PayDao payDao;
	
	@RequestMapping(value=COMMAND, method=RequestMethod.GET)
	public ModelAndView doGET(ModelAndView mav, HttpServletRequest request) {
		System.out.println(this.getClass()+" "+request.getMethod()); //추후 삭제 가능
		mav.setViewName(GETPAGE);
		return mav;
		
	}
	
	@RequestMapping(value=COMMAND, method=RequestMethod.POST)
	public void doPost(PrintWriter pw, HttpServletResponse response, HttpServletRequest request, HttpSession session) throws IOException {
		System.out.println(this.getClass()+" "+request.getMethod());
		
		pw = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		UsersBean temp = (UsersBean) session.getAttribute("loginInfo");
		
		String id = temp.getId();

		String paycode = request.getParameter("paycode");
		String paydetail1 = request.getParameter("paydetail1");
		String paydetail2 = request.getParameter("paydetail2");
		if(paycode.equals("휴대폰결제")) {
			paydetail2 = temp.getContact().replace("-", "");
		}
		int cvc = Integer.parseInt(request.getParameter("cvc"));
		
		PayBean payBean = new PayBean();
		payBean.setId(id);
		payBean.setPaycode(paycode);
		payBean.setPaydetail1(paydetail1);
		payBean.setPaydetail2(paydetail2);
		payBean.setCvc(cvc);
		
		int cnt = -1;
		cnt = payDao.registerPay(payBean);
		
		if(cnt != -1) {
			pw.println("<script>alert('결제수단을 등록했습니다'); location.replace('payList.do');</script>");
		} else {
			pw.println("<script>alert('결제수단을 등록하지 못했습니다'); history.go(-1);</script>");
		}
		pw.flush();
		
		return;
	}
}

