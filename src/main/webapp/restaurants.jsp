<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page
	import="java.util.List, com.Model.User, com.DAOImpl.RestaurantDAOImpl, com.Model.Restaurant"%>
<%
User loggedInUser = (User) session.getAttribute("loggedInUser");
String firstChar = "";
String userName = "";
String userEmail = "";
if (loggedInUser != null) {
	userName = loggedInUser.getName();
	userEmail = loggedInUser.getEmail();
	if (userName != null && !userName.isEmpty()) {
		firstChar = userName.substring(0, 1).toUpperCase();
	}
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Bite House — Restaurants</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/restaurants.css">
</head>
<body>

	<div class="page listing-page">

		<header>
			<nav>
				<a href="${pageContext.request.contextPath}/" class="brand"> <span
					class="brand-mark"> <svg viewBox="0 0 24 24" fill="none"
							stroke="#FFFFFF" stroke-width="2">
							<path d="M3 11l9-8 9 8M5 10v10h14V10" /></svg>
				</span> Bite House
				</a>

				<div class="nav-search-container">
					<div class="search-bar">
						<svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
							stroke-width="2">
							<circle cx="11" cy="11" r="7" />
							<path d="M21 21l-4.3-4.3" /></svg>
						<input type="text" id="searchInput"
							placeholder="Search restaurants or cuisines">
					</div>
				</div>

				<div class="nav-right">
					<%
					if (loggedInUser != null) {
					%>
					<div class="user-profile-dropdown" id="userProfileDropdown">
						<button class="profile-avatar-btn" id="profileAvatarBtn"
							aria-haspopup="true" aria-expanded="false">
							<div class="avatar-initials"><%=firstChar%></div>
						</button>
						<div class="dropdown-menu" id="dropdownMenu">
							<div class="dropdown-header">
								<span class="user-name"><%=userName%></span> <span
									class="user-email"><%=userEmail%></span>
							</div>
							<div class="dropdown-divider"></div>
							<a href="about-user" class="dropdown-item"> <svg
									viewBox="0 0 24 24" fill="none" stroke="currentColor"
									stroke-width="2">
									<path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />
									<circle cx="12" cy="7" r="4" /></svg> About User
							</a> <a href="settings" class="dropdown-item"> <svg
									viewBox="0 0 24 24" fill="none" stroke="currentColor"
									stroke-width="2">
									<circle cx="12" cy="12" r="3" />
									<path
										d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 1 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 1 1-2.83-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 1 1 2.83-2.83l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 1 1 2.83 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z" /></svg>
								Settings
							</a>
							<div class="dropdown-divider"></div>
							<a href="${pageContext.request.contextPath}/logout"
								class="dropdown-item logout-link"> <svg viewBox="0 0 24 24"
									fill="none" stroke="currentColor" stroke-width="2">
									<path
										d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4M16 17l5-5-5-5M21 12H9" /></svg>
								Logout
							</a>
						</div>
					</div>
					<%
					} else {
					%>
					<a href="${pageContext.request.contextPath}/login"
						class="btn-ghost">Sign in</a>
					<%
					}
					%>
				</div>
			</nav>
		</header>

		<section class="listing-hero">
			<h1>
				Restaurants near <span class="accent">you</span>
			</h1>
			<p>Browse places nearby, sorted by what you're craving, and order
				in a couple of taps.</p>
		</section>

		<div class="filter-row">
			<span class="filter-chip active" data-filter="all">All</span> <span
				class="filter-chip" data-filter="burgers">Burgers</span> <span
				class="filter-chip" data-filter="japanese">Japanese</span> <span
				class="filter-chip" data-filter="healthy">Healthy</span> <span
				class="filter-chip" data-filter="italian">Italian</span> <span
				class="filter-chip" data-filter="fast delivery">Fast delivery</span>
		</div>

		<section class="restaurant-grid">

			<%
			List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");

			for (Restaurant restaurant : restaurants) {
			%>

			<a
				href="${pageContext.request.contextPath}/menu?id=<%=restaurant.getRestaurantId()%>&name=<%=restaurant.getName()%>"
				class="r-card" data-category="<%=restaurant.getCuisine()%>">

				<div class="r-card-photo"
					style="background-image: url('<%=restaurant.getImagePath()%>') ">
					<span class="r-card-badge"> <svg viewBox="0 0 24 24"
							fill="none" stroke="currentColor" stroke-width="2.5">
							<path d="M13 2L4 14h6l-1 8 9-12h-6l1-8z" /></svg> <%=restaurant.getDeliveryTime()%>
					</span> <span class="r-card-fav"> <svg viewBox="0 0 24 24"
							fill="none" stroke="currentColor" stroke-width="2">
							<path d="M12 21s-7-6.5-7-11a7 7 0 1114 0c0 4.5-7 11-7 11z" /></svg>
					</span>
				</div>
				<div class="r-card-body">
					<div class="r-card-top">
						<h3><%=restaurant.getName()%></h3>
						<span class="r-card-rating"> <svg viewBox="0 0 24 24"
								fill="currentColor">
								<path
									d="M12 2l3.1 6.3 6.9 1-5 4.9 1.2 6.8L12 17.8 5.8 21l1.2-6.8-5-4.9 6.9-1z" /></svg>
							<%=restaurant.getRating()%>
						</span>
					</div>
					<p class="r-card-cuisine">
						<%=restaurant.getCuisine()%>
					</p>
					<div class="r-card-meta">
						<span> <svg viewBox="0 0 24 24" fill="none"
								stroke="currentColor" stroke-width="2">
								<path d="M12 21s-7-6.5-7-11a7 7 0 1114 0c0 4.5-7 11-7 11z" />
								<circle cx="12" cy="10" r="2.5" /></svg> <%=restaurant.getDistance()%>
						</span> <span> <svg viewBox="0 0 24 24" fill="none"
								stroke="currentColor" stroke-width="2">
								<path d="M13 2L4 14h6l-1 8 9-12h-6l1-8z" /></svg> <%
 if (restaurant.isFreeDelivery()) {
 %> Free delivery <%
 } else {
 %> Delivery Charges <%
 }
 %>
						</span>
					</div>
				</div>
			</a>
			<%
			}
			%>
		</section>

		<p class="empty-state" id="emptyState">No restaurants match your
			search. Try a different filter or keyword.</p>

		<footer>
			<span>&copy; <%=java.time.Year.now()%> Bite House
			</span> <span id="contact">contact@bitehouse.app</span>
		</footer>

	</div>

	<script src="${pageContext.request.contextPath}/js/restaurants.js"></script>
</body>
</html>
