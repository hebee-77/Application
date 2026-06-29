package com.Servlets;

import java.io.IOException;
import java.util.List;

import com.DAOImpl.RestaurantDAOImpl;
import com.Model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/restaurants")
public class RestaurantsServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("loggedInUser") == null) {

			resp.sendRedirect("login.jsp");

			return;
		}

		RestaurantDAOImpl dao = new RestaurantDAOImpl();

		List<Restaurant> restaurants = dao.getAllRestaurants();

		req.setAttribute("restaurants", restaurants);

		req.getRequestDispatcher("restaurants.jsp").forward(req, resp);

	}

}
