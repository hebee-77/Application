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

  @SuppressWarnings("unchecked")
  List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
  @SuppressWarnings("unchecked")
  Map<Integer, Dish> dishMap = (Map<Integer, Dish>) request.getAttribute("dishMap");

  int subtotal    = (request.getAttribute("subtotal") != null) ? (Integer) request.getAttribute("subtotal") : 0;
  int deliveryFee = (request.getAttribute("deliveryFee") != null) ? (Integer) request.getAttribute("deliveryFee") : 0;
  int taxes       = (request.getAttribute("taxes") != null) ? (Integer) request.getAttribute("taxes") : 0;
  int grandTotal  = (request.getAttribute("grandTotal") != null) ? (Integer) request.getAttribute("grandTotal") : 0;
  String restaurantName = (request.getAttribute("restaurantName") != null) ? (String) request.getAttribute("restaurantName") : "Restaurant";
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bite House — Checkout</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkout.css?v=<%= System.currentTimeMillis() %>">
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
                <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 1 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 1 1-2.83-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 1 1 2.83-2.83l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 1 1 2.83 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"/>
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

  <a href="${pageContext.request.contextPath}/cart" class="back-link">
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
      <path d="M19 12H5M11 18l-6-6 6-6"/>
    </svg>
    Back to Cart
  </a>

  <h1 class="page-title">Checkout</h1>

  <form action="${pageContext.request.contextPath}/checkout" method="post" class="checkout-grid">

    <!-- ── Left Column: Delivery & Payment Details ── -->
    <div class="checkout-main-col">

      <!-- Address Card -->
      <section class="checkout-card">
        <div class="card-header">
          <span class="step-num">1</span>
          <h2>Delivery Address</h2>
        </div>
        <div class="input-group">
          <label for="addressInput">Street Address &amp; Landmarks</label>
          <textarea id="addressInput" name="address" rows="3" required placeholder="Enter your full delivery address">221B Baker Street, Camden, London NW1 6XE</textarea>
        </div>
      </section>

      <!-- Payment Method Card -->
      <section class="checkout-card">
        <div class="card-header">
          <span class="step-num">2</span>
          <h2>Payment Method</h2>
        </div>
        <div class="payment-options-list">
          <label class="payment-radio-card">
            <input type="radio" name="paymentMethod" value="cod" checked>
            <div class="radio-card-content">
              <span class="pay-title">Cash on Delivery</span>
              <span class="pay-desc">Pay cash when your order arrives</span>
            </div>
          </label>
          <label class="payment-radio-card">
            <input type="radio" name="paymentMethod" value="upi">
            <div class="radio-card-content">
              <span class="pay-title">UPI / QR Code</span>
              <span class="pay-desc">GPay, PhonePe, Paytm, BHIM</span>
            </div>
          </label>
          <label class="payment-radio-card">
            <input type="radio" name="paymentMethod" value="card">
            <div class="radio-card-content">
              <span class="pay-title">Credit / Debit Card</span>
              <span class="pay-desc">Visa, Mastercard, RuPay</span>
            </div>
          </label>
        </div>
      </section>

      <!-- Review Items Card -->
      <section class="checkout-card">
        <div class="card-header">
          <span class="step-num">3</span>
          <h2>Review Items (<%= restaurantName %>)</h2>
        </div>
        <div class="checkout-items-list">
          <%
            if (cartItems != null) {
              for (CartItem item : cartItems) {
                Dish dish = (dishMap != null) ? dishMap.get(item.getDishId()) : null;
                if (dish == null) continue;
                int lineTotal = dish.getPrice() * item.getQuantity();
          %>
            <div class="checkout-item-row">
              <div class="item-info">
                <span class="item-name"><%= dish.getName() %> &times; <%= item.getQuantity() %></span>
                <span class="item-unit">&#8377;<%= dish.getPrice() %> each</span>
              </div>
              <span class="item-price">&#8377;<%= lineTotal %></span>
            </div>
          <%   }
            }
          %>
        </div>
      </section>

    </div>

    <!-- ── Right Column: Summary & Place Order Button ── -->
    <aside class="checkout-side-col">
      <div class="summary-card">
        <h2>Payment Summary</h2>
        <div class="summary-row">
          <span>Items Subtotal</span>
          <span>&#8377;<%= subtotal %></span>
        </div>
        <div class="summary-row">
          <span>Delivery Fee</span>
          <span>&#8377;<%= deliveryFee %></span>
        </div>
        <div class="summary-row">
          <span>Taxes &amp; Platform Fee</span>
          <span>&#8377;<%= taxes %></span>
        </div>
        <div class="summary-row summary-total">
          <span>Amount Payable</span>
          <span>&#8377;<%= grandTotal %></span>
        </div>

        <button type="submit" class="btn-primary full">Confirm &amp; Place Order (&#8377;<%= grandTotal %>)</button>
        <p class="terms-note">By placing your order, you agree to Bite House Terms of Service.</p>
      </div>
    </aside>

  </form>

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
