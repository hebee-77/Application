<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ page import="java.util.List, com.Model.Dish, com.Model.User" %>
    <% User loggedInUser=(User) session.getAttribute("loggedInUser"); String firstChar="" ; String userName="" ; String
      userEmail="" ; if (loggedInUser !=null) { userName=loggedInUser.getName(); userEmail=loggedInUser.getEmail(); if
      (userName !=null && !userName.isEmpty()) { firstChar=userName.substring(0, 1).toUpperCase(); } } %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Bite House — Burger Barn</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css?v=<%=System.currentTimeMillis()%>">
      </head>

      <body>

        <header class="site-header">
          <div class="wrap">
            <nav>
              <a href="${pageContext.request.contextPath}/" class="brand">
                <span class="brand-mark">
                  <svg viewBox="0 0 24 24" fill="none" stroke="#FFFFFF" stroke-width="2">
                    <path d="M3 11l9-8 9 8M5 10v10h14V10" />
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
                    <circle cx="9" cy="21" r="1" />
                    <circle cx="20" cy="21" r="1" />
                    <path d="M1 1h4l2.68 13.39a2 2 0 002 1.61h9.72a2 2 0 002-1.61L23 6H6" />
                  </svg>
                </a>
                <% if (loggedInUser !=null) { %>
                  <div class="user-profile-dropdown" id="userProfileDropdown">
                    <button class="profile-avatar-btn" id="profileAvatarBtn" aria-haspopup="true" aria-expanded="false">
                      <div class="avatar-initials">
                        <%=firstChar%>
                      </div>
                    </button>
                    <div class="dropdown-menu" id="dropdownMenu">
                      <div class="dropdown-header">
                        <span class="user-name">
                          <%=userName%>
                        </span> <span class="user-email">
                          <%=userEmail%>
                        </span>
                      </div>
                      <div class="dropdown-divider"></div>
                      <a href="about-user" class="dropdown-item"> <svg width="16" height="16" viewBox="0 0 24 24"
                          fill="none" stroke="currentColor" stroke-width="2">
                          <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />
                          <circle cx="12" cy="7" r="4" />
                        </svg> About User
                      </a> <a href="settings" class="dropdown-item"> <svg width="16" height="16" viewBox="0 0 24 24"
                          fill="none" stroke="currentColor" stroke-width="2">
                          <circle cx="12" cy="12" r="3" />
                          <path
                            d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 1 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 1 1-2.83-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 1 1 2.83-2.83l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 1 1 2.83 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z" />
                        </svg>
                        Settings
                      </a>
                      <div class="dropdown-divider"></div>
                      <a href="${pageContext.request.contextPath}/logout" class="dropdown-item logout-link"> <svg
                          width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                          <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4M16 17l5-5-5-5M21 12H9" />
                        </svg>
                        Logout
                      </a>
                    </div>
                  </div>
                  <% } else { %>
                    <a href="${pageContext.request.contextPath}/login" class="btn-ghost">Sign in</a>
                    <% } %>
              </div>
            </nav>
          </div>
        </header>

        <main class="wrap">

          <a href="${pageContext.request.contextPath}/restaurants" class="back-link">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M19 12H5M11 18l-6-6 6-6" />
            </svg>
            Back to restaurants
          </a>

          <section class="restaurant-banner"
            style="background-image:url('https://images.unsplash.com/photo-1550317138-10000687a72b?auto=format&fit=crop&w=1200&q=70');">
          </section>

          <section class="restaurant-info-card">
            <div class="restaurant-info-top">
              <div>
                <h1>Burger Barn</h1>
                <p class="restaurant-cuisine">American · Burgers · Fries</p>
              </div>
              <span class="r-card-rating">
                <svg viewBox="0 0 24 24" fill="currentColor">
                  <path d="M12 2l3.1 6.3 6.9 1-5 4.9 1.2 6.8L12 17.8 5.8 21l1.2-6.8-5-4.9 6.9-1z" />
                </svg>
                4.5
                <span class="rating-count">(320)</span>
              </span>
            </div>
            <div class="restaurant-meta">
              <span>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M13 2L4 14h6l-1 8 9-12h-6l1-8z" />
                </svg>
                20–25 min
              </span>
              <span>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M12 21s-7-6.5-7-11a7 7 0 1114 0c0 4.5-7 11-7 11z" />
                  <circle cx="12" cy="10" r="2.5" />
                </svg>
                1.2 km away
              </span>
              <span>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M3 6h18M3 12h18M3 18h18" />
                </svg>
                Free delivery
              </span>
            </div>
          </section>

          <section class="menu-section" id="popular">
            <h2>Popular</h2>

            <% List<Dish> dishes = (List<Dish>) request.getAttribute("dishes");
                for (Dish dish : dishes) {
                %>

                <div class="menu-item" data-item-id="classic-cheeseburger">
                  <div class="menu-item-photo" style="background-image:url('<%=dish.getImagePath()%>');"></div>
                  <div class="menu-item-info">
                    <h3>
                      <%=dish.getName()%>
                    </h3>
                    <p>
                      <%=dish.getDescription()%>
                    </p>
                    <span class="menu-item-price">
                      <%=dish.getPrice()%>
                    </span>
                  </div>
                  <form action="${pageContext.request.contextPath}/cart" method="post" class="menu-item-control">
                    <input type="hidden" name="itemId" value="<%=dish.getDishId()%>">
                    <input type="number" name="quantity" value="1" min="1" class="qty-input">
                    <button type="submit" class="btn-add">Add</button>
                  </form>
                </div>
                <% } %>
          </section>






        </main>

        <div class="cart-bar">
          <a href="${pageContext.request.contextPath}/cart" class="cart-bar-link">
            View cart
            <svg viewBox="0 0 24 24" fill="none" stroke="#FFFFFF" stroke-width="2.5">
              <path d="M5 12h14M13 6l6 6-6 6" />
            </svg>
          </a>
        </div>

        <footer class="wrap">
          <span>&copy; <%= java.time.Year.now() %> Bite House</span>
          <span id="contact">contact@bitehouse.app</span>
        </footer>

        <script src="${pageContext.request.contextPath}/js/menu.js"></script>
      </body>

      </html>