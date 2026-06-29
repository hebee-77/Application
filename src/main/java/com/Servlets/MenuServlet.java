package com.Servlets;

import java.io.IOException;
import java.util.List;

import com.DAOImpl.DishDAOImpl;
import com.DAOImpl.RestaurantDAOImpl;
import com.Model.Dish;
import com.Model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String name = req.getParameter("name");
		 
		int id = Integer.parseInt(req.getParameter("id"));
		
		DishDAOImpl dishDAOImpl = new DishDAOImpl();
		
		List<Dish> dishes = dishDAOImpl.getDishesByRestaurantName(name);
		
		RestaurantDAOImpl restaurantDAOImpl = new RestaurantDAOImpl();
		
		Restaurant restaurant = restaurantDAOImpl.getRestaurant(id);
		
		req.setAttribute("dishes", dishes);
		req.setAttribute("restaurant", restaurant);
		
		req.getRequestDispatcher("menu.jsp").forward(req, resp);
	}
	
}
