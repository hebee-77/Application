package com.Servlets;

import java.io.IOException;

import com.Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/order-confirmation")
public class OrderConfirmationServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

		if (loggedInUser == null) {
			resp.sendRedirect(req.getContextPath() + "/login.jsp");
			return;
		}

		String orderId = (session != null) ? (String) session.getAttribute("lastOrderId") : null;
		if (orderId == null) {
			resp.sendRedirect(req.getContextPath() + "/restaurants");
			return;
		}

		req.getRequestDispatcher("order-confirmation.jsp").forward(req, resp);
	}
}
