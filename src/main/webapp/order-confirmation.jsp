<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Map, com.Model.CartItem, com.Model.Dish, com.Model.User" %>
<%
  User loggedInUser = (User) session.getAttribute("loggedInUser");
  String firstChar = "", userName = "", userEmail = "";
  if (loggedInUser != null) {
    userName  = loggedInUser.getName();
    userEmail = loggedInUser.getEmail();
    if (userName != null && !userName.isEmpty())
      firstChar = userName.substring(0, 1).toUpperCase();
  }

  String orderId         = (String) session.getAttribute("lastOrderId");
  String restaurantName  = (String) session.getAttribute("lastRestaurantName");
  String paymentMethod   = (String) session.getAttribute("lastPaymentMethod");
  String address         = (String) session.getAttribute("lastAddress");
  Integer grandTotal     = (Integer) session.getAttribute("lastGrandTotal");
  Integer subtotal       = (Integer) session.getAttribute("lastSubtotal");
  Integer deliveryFee    = (Integer) session.getAttribute("lastDeliveryFee");
  Integer taxes          = (Integer) session.getAttribute("lastTaxes");

  @SuppressWarnings("unchecked")
  List<CartItem> orderItems = (List<CartItem>) session.getAttribute("lastOrderItems");
  @SuppressWarnings("unchecked")
  Map<Integer, Dish> dishMap = (Map<Integer, Dish>) session.getAttribute("lastDishMap");

  if (orderId == null) orderId = "BH-102948";
  if (restaurantName == null) restaurantName = "Bite House Partner";
  if (grandTotal == null) grandTotal = 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bite House — Order Confirmed</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/order-confirmation.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>

<!-- ── HEADER ──────────────────────────────────────────────── -->
<header class="site-header">
  <nav class="wrap">
    <a href="${pageContext.request.contextPath}/" class="brand">
      <span class="brand-mark">
        <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2">
          <path d="M3 11l9-8 9 8M5 10v10h14V10"/>
        </svg>
      </span>
      Bite House
    </a>

    <ul class="nav-links" id="navLinks">
      <li><a href="${pageContext.request.contextPath}/restaurants">Restaurants</a></li>
      <li><a href="${pageContext.request.contextPath}/#how-it-works">How it works</a></li>
      <li><a href="#contact">Contact</a></li>
    </ul>

    <div class="nav-right">
      <% if (loggedInUser != null) { %>
        <div class="user-profile-dropdown" id="userProfileDropdown">
          <button class="profile-avatar-btn" id="profileAvatarBtn" aria-haspopup="true" aria-expanded="false">
            <div class="avatar-initials"><%= firstChar %></div>
          </button>
          <div class="dropdown-menu" id="dropdownMenu">
            <div class="dropdown-header">
              <span class="user-name"><%= userName %></span>
              <span class="user-email"><%= userEmail %></span>
            </div>
            <div class="dropdown-divider"></div>
            <a href="about-user" class="dropdown-item">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                <circle cx="12" cy="7" r="4"/>
              </svg>About User
            </a>
            <a href="settings" class="dropdown-item">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="12" cy="12" r="3"/>
                <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 1 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 1 1-2.83-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 1 1 2.83 2.83l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 1 1 2.83 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"/>
              </svg>Settings
            </a>
            <div class="dropdown-divider"></div>
            <a href="${pageContext.request.contextPath}/logout" class="dropdown-item logout-link">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4M16 17l5-5-5-5M21 12H9"/>
              </svg>Logout
            </a>
          </div>
        </div>
      <% } else { %>
        <a href="${pageContext.request.contextPath}/login.jsp" class="btn-ghost">Sign in</a>
      <% } %>
    </div>
  </nav>
</header>

<!-- ── MAIN ────────────────────────────────────────────────── -->
<main class="wrap">

  <div class="confirmation-card">
    <div class="success-icon">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
        <path d="M20 6L9 17l-5-5"/>
      </svg>
    </div>

    <h1>Order Placed Successfully!</h1>
    <p class="order-subtitle">Thank you for ordering with Bite House. Your food is being prepared by <strong><%= restaurantName %></strong>.</p>

    <div class="order-meta-grid">
      <div class="meta-box">
        <span class="meta-label">Order Reference</span>
        <span class="meta-val highlight"><%= orderId %></span>
      </div>
      <div class="meta-box">
        <span class="meta-label">Estimated Delivery</span>
        <span class="meta-val">25–35 Mins</span>
      </div>
      <div class="meta-box">
        <span class="meta-label">Payment Method</span>
        <span class="meta-val"><%= paymentMethod %></span>
      </div>
      <div class="meta-box">
        <span class="meta-label">Amount Paid</span>
        <span class="meta-val">&#8377;<%= grandTotal %></span>
      </div>
    </div>

    <div class="details-section">
      <h3>Delivery Address</h3>
      <p class="address-text"><%= address %></p>
    </div>

    <% if (orderItems != null && !orderItems.isEmpty()) { %>
      <div class="details-section">
        <h3>Items Ordered</h3>
        <div class="ordered-items-list">
          <%
            for (CartItem item : orderItems) {
              Dish dish = (dishMap != null) ? dishMap.get(item.getDishId()) : null;
              if (dish == null) continue;
              int itemTotal = dish.getPrice() * item.getQuantity();
          %>
            <div class="ordered-item-row">
              <span><%= dish.getName() %> &times; <%= item.getQuantity() %></span>
              <span>&#8377;<%= itemTotal %></span>
            </div>
          <% } %>
        </div>
      </div>
    <% } %>

    <div class="action-row">
      <a href="${pageContext.request.contextPath}/restaurants" class="btn-primary">Explore More Restaurants</a>
    </div>

  </div>

</main>

<!-- ── FOOTER ───────────────────────────────────────────────── -->
<footer class="site-footer wrap" id="contact">
  <span>&copy; <%= java.time.Year.now() %> Bite House</span>
  <span>contact@bitehouse.app</span>
</footer>

<script>
(function() {
  'use strict';
  var profileBtn = document.getElementById('profileAvatarBtn');
  var dropdownMenu = document.getElementById('dropdownMenu');
  var userProfileDropdown = document.getElementById('userProfileDropdown');
  if (profileBtn && dropdownMenu) {
    profileBtn.addEventListener('click', function(e) {
      e.stopPropagation();
      var isExpanded = profileBtn.getAttribute('aria-expanded') === 'true';
      profileBtn.setAttribute('aria-expanded', !isExpanded);
      dropdownMenu.classList.toggle('show');
    });
    document.addEventListener('click', function(e) {
      if (userProfileDropdown && !userProfileDropdown.contains(e.target)) {
        profileBtn.setAttribute('aria-expanded', 'false');
        dropdownMenu.classList.remove('show');
      }
    });
  }
})();
</script>
</body>
</html>
