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
public class PayUpdateController {
	private static final String COMMAND = "/payUpdate.do";
	private static final String GETPAGE = "user/pay/payUpdateForm";
	
	@Autowired
	private PayDao payDao;
	
	@RequestMapping(value=COMMAND, method=RequestMethod.GET)
	public ModelAndView doGet(ModelAndView mav, HttpServletRequest request) {
		System.out.println(this.getClass()+" "+request.getMethod()); //추후 삭제 가능
		
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		
		PayBean payBean = payDao.getData(num);
		
		mav.addObject("num", num);
		mav.addObject("pay", payBean);
		mav.addObject("pageNumber", pageNumber);
		mav.setViewName(GETPAGE);
		return mav;
	}
	
	@RequestMapping(value=COMMAND, method=RequestMethod.POST)
	public void doPost(PrintWriter pw, HttpServletResponse response, HttpServletRequest request, HttpSession session) throws IOException {
		System.out.println(this.getClass()+" "+request.getMethod()); //추후 삭제 가능
		
		pw = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		int num = Integer.parseInt(request.getParameter("num"));
		String paycode = request.getParameter("paycode");
		String paydetail1 = request.getParameter("paydetail1");
		String paydetail2 = request.getParameter("paydetail2");
		int cvc = Integer.parseInt(request.getParameter("cvc"));
		
		PayBean payBean = new PayBean();
		payBean.setNum(num);
		payBean.setPaydetail1(paydetail1);
		if(!paycode.equals("휴대폰결제")) {
			payBean.setPaydetail2(paydetail2);
		}
		payBean.setCvc(cvc);
		
		UsersBean temp = (UsersBean) session.getAttribute("loginInfo");
		payBean.setModid(temp.getId());
		
		int cnt = -1;
		cnt = payDao.updatePay(payBean);
		
		if(cnt != -1) {
			pw.println("<script>alert('변경 완료했습니다'); location.replace('payList.do?pageNumber="+pageNumber+"');</script>");
		} else {
			pw.println("<script>alert('변경하지 못했습니다'); history.go(-1);</script>");
		}
		pw.flush();
		
		return;
	}
}
