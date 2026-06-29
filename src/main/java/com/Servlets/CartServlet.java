package com.Servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.DAOImpl.CartDAOImpl;
import com.DAOImpl.DishDAOImpl;
import com.Model.CartItem;
import com.Model.Dish;
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

		HttpSession session = req.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

		if (loggedInUser == null) {
			resp.sendRedirect(req.getContextPath() + "/login.jsp");
			return;
		}

		CartDAOImpl cartDAO = new CartDAOImpl();
		DishDAOImpl dishDAO = new DishDAOImpl();

		List<CartItem> cartItems = cartDAO.getCartItemsByUser(loggedInUser.getUserId());
		Map<Integer, Dish> dishMap = new HashMap<>();

		int subtotal = 0;
		for (CartItem item : cartItems) {
			Dish dish = dishDAO.getDish(item.getDishId());
			if (dish != null) {
				dishMap.put(dish.getDishId(), dish);
				subtotal += dish.getPrice() * item.getQuantity();
			}
		}

		int deliveryFee = (subtotal > 0) ? 40 : 0;
		int taxes = (subtotal > 0) ? 20 : 0;
		int grandTotal = subtotal + deliveryFee + taxes;

		req.setAttribute("cartItems", cartItems);
		req.setAttribute("dishMap", dishMap);
		req.setAttribute("subtotal", subtotal);
		req.setAttribute("deliveryFee", deliveryFee);
		req.setAttribute("taxes", taxes);
		req.setAttribute("grandTotal", grandTotal);

		req.getRequestDispatcher("cart.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

		if (loggedInUser == null) {
			resp.sendRedirect(req.getContextPath() + "/login.jsp");
			return;
		}

		// Parse dish ID
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

		// Action: "add" (default), "increment", "decrement", "remove"
		String action = req.getParameter("action");
		CartDAOImpl cartDAO = new CartDAOImpl();
		DishDAOImpl dishDAO = new DishDAOImpl();
		int userId = loggedInUser.getUserId();

		if ("decrement".equals(action)) {
			cartDAO.decrement(userId, dishId);
		} else if ("remove".equals(action)) {
			cartDAO.removeItem(userId, dishId);
		} else {
			// "add" or "increment"
			// Check if existing cart belongs to a DIFFERENT restaurant
			Dish newDish = dishDAO.getDish(dishId);
			if (newDish != null) {
				List<CartItem> currentItems = cartDAO.getCartItemsByUser(userId);
				if (!currentItems.isEmpty()) {
					Dish existingDish = dishDAO.getDish(currentItems.get(0).getDishId());
					if (existingDish != null && existingDish.getRestaurantName() != null
							&& !existingDish.getRestaurantName().equalsIgnoreCase(newDish.getRestaurantName())) {
						// Restaurant changed! Reset/clear cart and start a new cart for this restaurant
						cartDAO.clearCart(userId);
					}
				}
			}
			cartDAO.addOrIncrement(userId, dishId);
		}

		// Redirect back to menuUrl if provided, else to cart page
		String menuUrl = req.getParameter("menuUrl");
		if (menuUrl != null && !menuUrl.isEmpty()) {
			resp.sendRedirect(menuUrl);
		} else {
			resp.sendRedirect(req.getContextPath() + "/cart");
		}
	}
}
