package com.gudi.util;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class loginCheck  extends HandlerInterceptorAdapter{
	
	@Override
	    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
	            throws Exception {
	        // session 객체를 가져옴
	        HttpSession session = request.getSession();
	        // login처리를 담당하는 사용자 정보를 담고 있는 객체를 가져옴
	        response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	         
	        if ( session.getAttribute("loginId") == null || session.getAttribute("loginId")=="" ){
	          
	           
	            out.println("<script>alert('로그인이 필요한 서비스 입니다.'); location.href='/go/loginForm';</script>");
	            return false; // 더이상 컨트롤러 요청으로 가지 않도록false로 반환함
	        }else {	         
	        
	        return true;
	    }
	 }
	 

		// 컨트롤러가 수행되고 화면이 보여지기 직전에 수행되는 메서드
	    @Override
	    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
	            ModelAndView modelAndView) throws Exception {
	      
	        super.postHandle(request, response, handler, modelAndView);
	    }
	     
	}