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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("login.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String email = req.getParameter("email");
		String password = req.getParameter("password");

		UserDAOImpl dao = new UserDAOImpl();

		User loggedInUser = dao.getUserByEmail(email);

		if (loggedInUser != null && loggedInUser.getPassword().equals(password)) {

			HttpSession session = req.getSession();

			session.setAttribute("loggedInUser", loggedInUser);

			resp.sendRedirect("restaurants");
		} else {
			resp.sendRedirect("login.jsp");
		}

	}

}
