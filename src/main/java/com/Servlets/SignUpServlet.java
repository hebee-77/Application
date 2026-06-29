package com.Servlets;

import java.io.IOException;

import com.DAOImpl.UserDAOImpl;
import com.Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@WebServlet("/signup")
public class SignUpServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String name = req.getParameter("name");
		
		String email = req.getParameter("email");
		
		String password = req.getParameter("password");
		
		UserDAOImpl dao = new UserDAOImpl();
		
		User user = new User(name, email, password);
		
		int result = dao.addUser(user);
		
		if(result > 0) {
			User loggedInUser = dao.getUserByEmail(email);
			if(loggedInUser != null) {
				HttpSession session = req.getSession(true);
				session.setAttribute("loggedInUser", loggedInUser);
				
			}
			
			resp.sendRedirect("restaurants");
			
		}
		
		
		
	}
	
}
