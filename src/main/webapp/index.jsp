<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.Model.User" %>
<%
  User loggedInUser = (User) session.getAttribute("loggedInUser");
  String firstChar = "";
  String userName = "";
  if (loggedInUser != null) {
    userName = loggedInUser.getName();
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
  <title>Bite House — Fast food delivered fresh</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>

<div class="page">

  <header>
    <nav>
      <a href="${pageContext.request.contextPath}/" class="brand">
        <span class="brand-mark">
          <svg viewBox="0 0 24 24" fill="none" stroke="#FFFFFF" stroke-width="2"><path d="M3 11l9-8 9 8M5 10v10h14V10"/></svg>
        </span>
        Bite House
      </a>
      <ul class="nav-links" id="navLinks">
        <li><a href="${pageContext.request.contextPath}/restaurants">Restaurants</a></li>
        <li><a href="#how-it-works">How it works</a></li>
        <li><a href="#contact">Contact</a></li>
      </ul>
      <div class="nav-right">
        <% if (loggedInUser != null) { %>
          <a href="${pageContext.request.contextPath}/restaurants" class="btn-ghost">Welcome, <%= userName %></a>
        <% } else { %>
          <a href="${pageContext.request.contextPath}/login" class="btn-ghost">Sign in</a>
        <% } %>
        <button class="nav-toggle" aria-label="Open menu" id="navToggle">
          <span></span><span></span><span></span>
        </button>
      </div>
    </nav>
  </header>

  <main class="hero">
    <div class="hero-content">
      <div class="eyebrow">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="14" height="14"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/></svg>
        Delivering across your city
      </div>
      <h1>Fast food<span class="accent">delivered fresh</span></h1>
      <p class="lede">Order from your favourite restaurants and watch your food make its way to you, live, on the map.</p>
      <div class="hero-cta">
        <a href="${pageContext.request.contextPath}/restaurants" class="btn-primary">
          Order now
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M13 6l6 6-6 6"/></svg>
        </a>
        <a href="#how-it-works" class="link-text">How it works</a>
      </div>
    </div>
    <div class="hero-visual">
      <img src="${pageContext.request.contextPath}/images/hero/rider.png" alt="Food delivery agent on time" class="hero-photo">
      <div class="float-pill eta">12 min away</div>
      <div class="float-pill live"><span class="dot"></span>Live</div>
    </div>
  </main>

  <section class="features" id="how-it-works">
    <div class="card restaurants">
      <div class="card-photo"></div>
      <h3>Browse restaurants</h3>
      <p>Discover places near you, sorted by what you're craving.</p>
    </div>
    <div class="card delivery">
      <div class="card-photo"></div>
      <h3>Fast delivery</h3>
      <p>Hot food, on time, every time.</p>
    </div>
    <div class="card tracking">
      <div class="card-photo"></div>
      <h3>Live tracking</h3>
      <p>Know exactly where your order is, in real time.</p>
    </div>
  </section>

  <footer>
    <span>&copy; <%= java.time.Year.now() %> Bite House</span>
    <span id="contact">contact@bitehouse.app</span>
  </footer>

</div>

<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>
