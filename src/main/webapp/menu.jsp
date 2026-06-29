<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Map, com.Model.Dish, com.Model.User, com.Model.Restaurant" %>
<%
  /* ── Session / user ────────────────────────────────────── */
  User loggedInUser = (User) session.getAttribute("loggedInUser");
  String firstChar = "", userName = "", userEmail = "";
  if (loggedInUser != null) {
    userName  = loggedInUser.getName();
    userEmail = loggedInUser.getEmail();
    if (userName != null && !userName.isEmpty())
      firstChar = userName.substring(0, 1).toUpperCase();
  }

  /* ── Restaurant / dishes (set by MenuServlet) ───────────── */
  Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
  List<Dish>  dishes    = (List<Dish>)  request.getAttribute("dishes");

  @SuppressWarnings("unchecked")
  Map<Integer,Integer> cartMap = (Map<Integer,Integer>) request.getAttribute("cartMap");
  if (cartMap == null) cartMap = new java.util.HashMap<>();

  int cartTotal = (request.getAttribute("cartTotal") != null)
                   ? (Integer) request.getAttribute("cartTotal") : 0;

  String restName    = (restaurant != null) ? restaurant.getName()         : "Restaurant";
  String restCuisine = (restaurant != null) ? restaurant.getCuisine()      : "";
  String restImage   = (restaurant != null) ? restaurant.getImagePath()    : "";
  double restRating  = (restaurant != null) ? restaurant.getRating()       : 0;
  String restTime    = (restaurant != null) ? restaurant.getDeliveryTime() : "";
  double restDist    = (restaurant != null) ? restaurant.getDistance()     : 0;
  boolean freeDeliv  = (restaurant != null) && restaurant.isFreeDelivery();

  /* URL to pass back to CartServlet so it can redirect here after POST */
  int restId = (restaurant != null) ? restaurant.getRestaurantId() : 0;
  String menuUrl = request.getContextPath() + "/menu?id=" + restId
                 + "&name=" + java.net.URLEncoder.encode(restName, "UTF-8");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bite House — <%= restName %></title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>

<!-- ── HEADER ──────────────────────────────────────────────── -->
<header class="site-header">
  <nav>
    <a href="${pageContext.request.contextPath}/" class="brand">
      <span class="brand-mark">
        <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2">
          <path d="M3 11l9-8 9 8M5 10v10h14V10"/>
        </svg>
      </span>
      Bite House
    </a>

    <ul class="nav-links" id="navLinks">
      <li><a href="${pageContext.request.contextPath}/restaurants" class="active">Restaurants</a></li>
      <li><a href="${pageContext.request.contextPath}/#how-it-works">How it works</a></li>
      <li><a href="#contact">Contact</a></li>
    </ul>

    <div class="nav-right">
      <a href="${pageContext.request.contextPath}/cart" class="cart-icon-btn" aria-label="View cart">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
          <path d="M1 1h4l2.68 13.39a2 2 0 002 1.61h9.72a2 2 0 002-1.61L23 6H6"/>
        </svg>
      </a>

      <% if (loggedInUser != null) { %>
        <div class="user-profile-dropdown" id="userProfileDropdown">
          <button class="profile-avatar-btn" id="profileAvatarBtn"
                  aria-haspopup="true" aria-expanded="false">
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
                <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 1 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 1 1-2.83-2.83l-.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 1 1 2.83-2.83l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 1 1 2.83 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"/>
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
        <a href="${pageContext.request.contextPath}/login" class="btn-ghost">Sign in</a>
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

  <!-- Banner -->
  <div class="restaurant-banner" style="background-image:url('<%= restImage %>');">
  </div>

  <!-- Info card -->
  <div class="restaurant-info-card">
    <div class="restaurant-info-top">
      <div>
        <h1><%= restName %></h1>
        <p class="restaurant-cuisine"><%= restCuisine %></p>
      </div>
      <span class="r-card-rating">
        <svg viewBox="0 0 24 24" fill="currentColor">
          <path d="M12 2l3.1 6.3 6.9 1-5 4.9 1.2 6.8L12 17.8 5.8 21l1.2-6.8-5-4.9 6.9-1z"/>
        </svg>
        <%= restRating %>
        <span class="rating-count">(320)</span>
      </span>
    </div>
    <div class="restaurant-meta">
      <span>
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path d="M13 2L4 14h6l-1 8 9-12h-6l1-8z"/>
        </svg>
        <%= restTime %>
      </span>
      <span>
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path d="M12 21s-7-6.5-7-11a7 7 0 1114 0c0 4.5-7 11-7 11z"/>
          <circle cx="12" cy="10" r="2.5"/>
        </svg>
        <%= restDist %> km away
      </span>
      <span>
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path d="M3 6h18M3 12h18M3 18h18"/>
        </svg>
        <%= freeDeliv ? "Free delivery" : "Delivery charges apply" %>
      </span>
    </div>
  </div>

  <!-- Menu list -->
  <section class="menu-section">
    <h2 class="menu-section-title">Popular</h2>

    <% if (dishes != null && !dishes.isEmpty()) {
         for (Dish dish : dishes) {
           String desc = dish.getDescription();
           if (desc == null || desc.equals("null")) desc = "";

           Integer qty = cartMap.get(dish.getDishId());
           boolean inCart = (qty != null && qty > 0);
    %>
    <div class="menu-item">

      <!-- Photo -->
      <div class="menu-item-photo"
           style="background-image:url('<%= dish.getImagePath() %>');">
      </div>

      <!-- Info -->
      <div class="menu-item-info">
        <h3><%= dish.getName() %></h3>
        <% if (!desc.isEmpty()) { %><p><%= desc %></p><% } %>
        <span class="menu-item-price">&#8377;<%= dish.getPrice() %></span>
      </div>

      <!-- Control: Add button OR Stepper (server-rendered) -->
      <div class="item-ctrl">
        <% if (inCart) { %>
          <!-- ── STEPPER (item is in cart) ── -->
          <div class="qty-stepper">

            <!-- Minus: decrement in DB, reload page -->
            <form method="post" action="${pageContext.request.contextPath}/cart" class="stepper-form">
              <input type="hidden" name="itemId"  value="<%= dish.getDishId() %>">
              <input type="hidden" name="action"  value="decrement">
              <input type="hidden" name="menuUrl" value="<%= menuUrl %>">
              <button type="submit" class="step-btn btn-minus" aria-label="Decrease">&#8722;</button>
            </form>

            <span class="qty-display"><%= qty %></span>

            <!-- Plus: increment in DB, reload page -->
            <form method="post" action="${pageContext.request.contextPath}/cart" class="stepper-form">
              <input type="hidden" name="itemId"  value="<%= dish.getDishId() %>">
              <input type="hidden" name="action"  value="increment">
              <input type="hidden" name="menuUrl" value="<%= menuUrl %>">
              <button type="submit" class="step-btn btn-plus" aria-label="Increase">&#43;</button>
            </form>

          </div>
        <% } else { %>
          <!-- ── ADD BUTTON (item not in cart) ── -->
          <form method="post" action="${pageContext.request.contextPath}/cart">
            <input type="hidden" name="itemId"  value="<%= dish.getDishId() %>">
            <input type="hidden" name="action"  value="add">
            <input type="hidden" name="menuUrl" value="<%= menuUrl %>">
            <button type="submit" class="btn-add-item">Add</button>
          </form>
        <% } %>
      </div>

    </div>
    <%   }
       } else { %>
      <p style="padding:24px 0;color:rgba(20,32,26,.6);font-size:14px;">
        No items available for this restaurant.
      </p>
    <% } %>
  </section>

</main>

<!-- ── STICKY CART BAR (shown if cart has items) ────────────── -->
<div class="cart-bar <%= cartTotal > 0 ? "show" : "" %>" id="cartBar">
  <div class="cart-bar-left">
    <span class="cart-bar-label">Your order</span>
    <span class="cart-bar-count"><%= cartTotal %> <%= cartTotal == 1 ? "item" : "items" %> added</span>
  </div>
  <a href="${pageContext.request.contextPath}/cart" class="cart-bar-btn">
    View Cart
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
      <path d="M5 12h14M13 6l6 6-6 6"/>
    </svg>
  </a>
</div>

<!-- ── FOOTER ───────────────────────────────────────────────── -->
<footer class="site-footer wrap" id="contact">
  <span>&copy; <%= java.time.Year.now() %> Bite House</span>
  <span>contact@bitehouse.app</span>
</footer>

<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>
