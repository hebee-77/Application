package com.Servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.DAOImpl.CartDAOImpl;
import com.DAOImpl.DishDAOImpl;
import com.DAOImpl.RestaurantDAOImpl;
import com.Model.CartItem;
import com.Model.Dish;
import com.Model.Restaurant;
import com.Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String name = req.getParameter("name");
		int id = Integer.parseInt(req.getParameter("id"));

		// Load restaurant and dishes
		DishDAOImpl dishDAO = new DishDAOImpl();
		RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();

		List<Dish> dishes = dishDAO.getDishesByRestaurantName(name);
		Restaurant restaurant = restaurantDAO.getRestaurant(id);

		req.setAttribute("dishes", dishes);
		req.setAttribute("restaurant", restaurant);

		// Build cart map: dishId -> quantity (for logged-in user)
		Map<Integer, Integer> cartMap = new HashMap<>();
		HttpSession session = req.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

		if (loggedInUser != null) {
			CartDAOImpl cartDAO = new CartDAOImpl();
			List<CartItem> cartItems = cartDAO.getCartItemsByUser(loggedInUser.getUserId());
			for (CartItem item : cartItems) {
				cartMap.put(item.getDishId(), item.getQuantity());
			}
		}

		// Total items count for cart bar
		int cartTotal = 0;
		for (int qty : cartMap.values())
			cartTotal += qty;

		req.setAttribute("cartMap", cartMap);
		req.setAttribute("cartTotal", cartTotal);

		req.getRequestDispatcher("menu.jsp").forward(req, resp);
	}
}
