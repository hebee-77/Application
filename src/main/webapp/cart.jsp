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

  boolean isEmpty = (cartItems == null || cartItems.isEmpty());
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bite House — Your Cart</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css?v=<%= System.currentTimeMillis() %>">
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

  <a href="${pageContext.request.contextPath}/restaurants" class="back-link">
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
      <path d="M19 12H5M11 18l-6-6 6-6"/>
    </svg>
    Back to restaurants
  </a>

  <h1 class="page-title">Your cart</h1>

  <% if (isEmpty) { %>
    <div class="empty-cart-container">
      <div class="empty-cart-icon">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
          <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
          <path d="M1 1h4l2.68 13.39a2 2 0 002 1.61h9.72a2 2 0 002-1.61L23 6H6"/>
        </svg>
      </div>
      <h2>Your cart is empty</h2>
      <p>Looks like you haven't added anything to your cart yet.</p>
      <a href="${pageContext.request.contextPath}/restaurants" class="btn-primary">Browse Restaurants</a>
    </div>
  <% } else { %>

    <div class="cart-grid">

      <!-- ── Left: Cart Items ── -->
      <section class="cart-items">
        <%
          for (CartItem item : cartItems) {
            Dish dish = (dishMap != null) ? dishMap.get(item.getDishId()) : null;
            if (dish == null) continue;
            int itemTotal = dish.getPrice() * item.getQuantity();
        %>
          <div class="cart-item">
            <div class="cart-item-photo" style="background-image: url('<%= dish.getImagePath() %>');"></div>

            <div class="cart-item-info">
              <h3><%= dish.getName() %></h3>
              <p class="cart-item-unit-price">&#8377;<%= dish.getPrice() %> each</p>
            </div>

            <div class="cart-item-controls">
              <!-- Stepper -->
              <div class="qty-stepper">
                <form method="post" action="${pageContext.request.contextPath}/cart" class="inline-form">
                  <input type="hidden" name="itemId" value="<%= dish.getDishId() %>">
                  <input type="hidden" name="action" value="decrement">
                  <button type="submit" class="step-btn btn-minus" aria-label="Decrease">&#8722;</button>
                </form>

                <span class="qty-display"><%= item.getQuantity() %></span>

                <form method="post" action="${pageContext.request.contextPath}/cart" class="inline-form">
                  <input type="hidden" name="itemId" value="<%= dish.getDishId() %>">
                  <input type="hidden" name="action" value="increment">
                  <button type="submit" class="step-btn btn-plus" aria-label="Increase">&#43;</button>
                </form>
              </div>

              <span class="cart-item-line-total">&#8377;<%= itemTotal %></span>

              <!-- Remove button -->
              <form method="post" action="${pageContext.request.contextPath}/cart" class="inline-form">
                <input type="hidden" name="itemId" value="<%= dish.getDishId() %>">
                <input type="hidden" name="action" value="remove">
                <button type="submit" class="remove-item-btn" aria-label="Remove item">
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M3 6h18M8 6V4a1 1 0 011-1h6a1 1 0 011 1v2m3 0l-1 14a2 2 0 01-2 2H7a2 2 0 01-2-2L4 6"/>
                  </svg>
                </button>
              </form>
            </div>
          </div>
        <% } %>
      </section>

      <!-- ── Right: Order Summary ── -->
      <aside class="cart-summary">

        <div class="summary-card">
          <h2>Order summary</h2>
          <div class="summary-row">
            <span>Subtotal</span>
            <span>&#8377;<%= subtotal %></span>
          </div>
          <div class="summary-row">
            <span>Delivery fee</span>
            <span>&#8377;<%= deliveryFee %></span>
          </div>
          <div class="summary-row">
            <span>Taxes &amp; charges</span>
            <span>&#8377;<%= taxes %></span>
          </div>
          <div class="summary-row summary-total">
            <span>Total</span>
            <span>&#8377;<%= grandTotal %></span>
          </div>
        </div>

        <form action="${pageContext.request.contextPath}/checkout" method="post">
          <div class="summary-card address-card">
            <div class="summary-card-header">
              <div class="header-title-group" style="display: flex; align-items: center; gap: 8px;">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#1B5E20" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                  <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/>
                  <circle cx="12" cy="10" r="3"/>
                </svg>
                <h2 style="margin: 0; font-size: 15px; font-weight: 800; color: #14201A;">Delivery address</h2>
              </div>
              <button type="button" class="link-text-btn" id="changeAddressBtn" style="font-size: 13px; font-weight: 700; color: #1B5E20; cursor: pointer;">Change</button>
            </div>

            <div id="addressViewSection" style="padding: 10px 14px; background: #FAFDF8; border: 1.5px dashed rgba(27,94,32,0.25); border-radius: 12px; margin-top: 10px; transition: all 0.2s ease;">
              <p class="address-text" id="addressDisplay" style="margin: 0; font-size: 13px; line-height: 1.5; color: #2D3B34; font-weight: 500;">221B Baker Street, Camden, London NW1 6XE</p>
            </div>

            <div id="addressEditSection" style="display: none; margin-top: 10px;">
              <div class="textarea-wrapper" style="position: relative;">
                <textarea name="address" id="addressInput" class="address-textarea" rows="3" placeholder="Enter full delivery address with landmark..." style="width: 100%; padding: 12px 14px; border: 1.5px solid #81C784; border-radius: 12px; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; font-size: 13px; line-height: 1.5; color: #14201A; background: #FFFFFF; outline: none; resize: vertical; transition: all 0.2s ease; box-shadow: 0 2px 8px rgba(27,94,32,0.06);">221B Baker Street, Camden, London NW1 6XE</textarea>
              </div>
              <div style="display: flex; justify-content: flex-end; gap: 8px; margin-top: 10px;">
                <button type="button" class="btn-save-address" id="saveAddressBtn" style="background: linear-gradient(135deg, #2E7D32, #1B5E20); color: #ffffff; font-size: 13px; font-weight: 700; padding: 8px 20px; border-radius: 999px; border: none; cursor: pointer; box-shadow: 0 3px 8px rgba(27,94,32,0.25); transition: all 0.15s ease;">Save Address</button>
              </div>
            </div>
          </div>

          <div class="summary-card">
            <h2>Payment method</h2>
            <label class="payment-option">
              <input type="radio" name="paymentMethod" value="cod" checked> Cash on delivery
            </label>
            <label class="payment-option">
              <input type="radio" name="paymentMethod" value="card"> Credit / debit card
            </label>
            <label class="payment-option">
              <input type="radio" name="paymentMethod" value="upi"> UPI
            </label>
          </div>

          <button type="submit" class="btn-primary full">Place Order (&#8377;<%= grandTotal %>)</button>
        </form>

      </aside>

    </div>

  <% } %>

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

  // Delivery Address inline editing
  var changeAddressBtn = document.getElementById('changeAddressBtn');
  var addressViewSection = document.getElementById('addressViewSection');
  var addressEditSection = document.getElementById('addressEditSection');
  var addressInput = document.getElementById('addressInput');
  var addressDisplay = document.getElementById('addressDisplay');
  var saveAddressBtn = document.getElementById('saveAddressBtn');

  if (changeAddressBtn && addressInput) {
    function toggleEditMode() {
      var isEditing = addressEditSection.style.display !== 'none';
      if (isEditing) {
        addressEditSection.style.display = 'none';
        addressViewSection.style.display = 'block';
        changeAddressBtn.textContent = 'Change';
        if (addressInput.value.trim() !== '') {
          addressDisplay.textContent = addressInput.value;
        } else {
          addressInput.value = addressDisplay.textContent;
        }
      } else {
        addressEditSection.style.display = 'block';
        addressViewSection.style.display = 'none';
        changeAddressBtn.textContent = 'Cancel';
        addressInput.focus();
        addressInput.select();
      }
    }

    changeAddressBtn.addEventListener('click', toggleEditMode);
    if (addressDisplay) {
      addressDisplay.addEventListener('click', toggleEditMode);
      addressDisplay.style.cursor = 'pointer';
      addressDisplay.title = 'Click to edit address';
    }
    if (saveAddressBtn) {
      saveAddressBtn.addEventListener('click', function() {
        if (addressInput.value.trim() !== '') {
          addressDisplay.textContent = addressInput.value;
        }
        toggleEditMode();
      });
    }
    addressInput.addEventListener('input', function() {
      if (addressInput.value.trim() !== '') {
        addressDisplay.textContent = addressInput.value;
      }
    });
  }
})();
</script>
</body>
</html>
