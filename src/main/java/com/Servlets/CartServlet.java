package com.Servlets;

import java.io.IOException;

import com.DAOImpl.CartDAOImpl;
import com.Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("cart.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

		if (loggedInUser == null) {
			// Not logged in — redirect to login
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		String itemIdParam = req.getParameter("itemId");
		if (itemIdParam == null || itemIdParam.trim().isEmpty()) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing itemId");
			return;
		}

		int dishId;
		try {
			dishId = Integer.parseInt(itemIdParam.trim());
		} catch (NumberFormatException e) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid itemId");
			return;
		}

		CartDAOImpl cartDAO = new CartDAOImpl();
		cartDAO.addOrIncrement(loggedInUser.getUserId(), dishId);

		// Check if AJAX request
		String requestedWith = req.getHeader("X-Requested-With");
		if ("XMLHttpRequest".equals(requestedWith)) {
			resp.setContentType("application/json");
			resp.setCharacterEncoding("UTF-8");
			int count = cartDAO.getCartItemCount(loggedInUser.getUserId());
			resp.getWriter().write("{\"success\":true,\"count\":" + count + "}");
		} else {
			// Normal form submit — redirect back to menu
			String referer = req.getHeader("Referer");
			resp.sendRedirect(referer != null ? referer : req.getContextPath() + "/restaurants");
		}
	}
}
