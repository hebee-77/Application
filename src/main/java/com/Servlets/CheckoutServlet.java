package com.Servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

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

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

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
		if (cartItems == null || cartItems.isEmpty()) {
			resp.sendRedirect(req.getContextPath() + "/cart");
			return;
		}

		Map<Integer, Dish> dishMap = new HashMap<>();
		int subtotal = 0;
		String restaurantName = "";

		for (CartItem item : cartItems) {
			Dish dish = dishDAO.getDish(item.getDishId());
			if (dish != null) {
				dishMap.put(dish.getDishId(), dish);
				subtotal += dish.getPrice() * item.getQuantity();
				if (restaurantName.isEmpty() && dish.getRestaurantName() != null) {
					restaurantName = dish.getRestaurantName();
				}
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
		req.setAttribute("restaurantName", restaurantName);

		req.getRequestDispatcher("checkout.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

		if (loggedInUser == null) {
			resp.sendRedirect(req.getContextPath() + "/login.jsp");
			return;
		}

		CartDAOImpl cartDAO = new CartDAOImpl();
		DishDAOImpl dishDAO = new DishDAOImpl();

		List<CartItem> cartItems = cartDAO.getCartItemsByUser(loggedInUser.getUserId());
		if (cartItems == null || cartItems.isEmpty()) {
			resp.sendRedirect(req.getContextPath() + "/cart");
			return;
		}

		Map<Integer, Dish> dishMap = new HashMap<>();
		int subtotal = 0;
		String restaurantName = "";

		for (CartItem item : cartItems) {
			Dish dish = dishDAO.getDish(item.getDishId());
			if (dish != null) {
				dishMap.put(dish.getDishId(), dish);
				subtotal += dish.getPrice() * item.getQuantity();
				if (restaurantName.isEmpty() && dish.getRestaurantName() != null) {
					restaurantName = dish.getRestaurantName();
				}
			}
		}

		int deliveryFee = (subtotal > 0) ? 40 : 0;
		int taxes = (subtotal > 0) ? 20 : 0;
		int grandTotal = subtotal + deliveryFee + taxes;

		String paymentMethod = req.getParameter("paymentMethod");
		if (paymentMethod == null || paymentMethod.isEmpty()) {
			paymentMethod = "Cash on Delivery";
		} else if ("cod".equalsIgnoreCase(paymentMethod)) {
			paymentMethod = "Cash on Delivery";
		} else if ("card".equalsIgnoreCase(paymentMethod)) {
			paymentMethod = "Credit / Debit Card";
		} else if ("upi".equalsIgnoreCase(paymentMethod)) {
			paymentMethod = "UPI";
		}

		String address = req.getParameter("address");
		if (address == null || address.trim().isEmpty()) {
			address = "221B Baker Street, Camden, London NW1 6XE";
		}

		String orderId = "BH-" + (100000 + new Random().nextInt(900000));

		// Store completed order details in session for confirmation page
		session.setAttribute("lastOrderId", orderId);
		session.setAttribute("lastOrderItems", new ArrayList<>(cartItems));
		session.setAttribute("lastDishMap", dishMap);
		session.setAttribute("lastSubtotal", subtotal);
		session.setAttribute("lastDeliveryFee", deliveryFee);
		session.setAttribute("lastTaxes", taxes);
		session.setAttribute("lastGrandTotal", grandTotal);
		session.setAttribute("lastPaymentMethod", paymentMethod);
		session.setAttribute("lastAddress", address);
		session.setAttribute("lastRestaurantName", restaurantName);

		// Clear cart in database after successfully placing order
		cartDAO.clearCart(loggedInUser.getUserId());

		resp.sendRedirect(req.getContextPath() + "/order-confirmation");
	}
}
