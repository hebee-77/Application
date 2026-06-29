<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Bite House — Food delivery</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="page">

  <header>
    <nav>
      <a href="${pageContext.request.contextPath}/" class="brand">
        <span class="brand-mark">
          <svg viewBox="0 0 24 24" fill="none" stroke="#04342C" stroke-width="2"><path d="M3 11l9-8 9 8M5 10v10h14V10"/></svg>
        </span>
        Bite House
      </a>
      <ul class="nav-links" id="navLinks">
        <li><a href="restaurants">Restaurants</a></li>
        <li><a href="#how-it-works">How it works</a></li>
        <li><a href="#contact">Contact</a></li>
      </ul>
      <div class="nav-right">
        <a href="login.jsp" class="btn-ghost">Sign in</a>
        <button class="nav-toggle" aria-label="Open menu" id="navToggle">
          <span></span><span></span><span></span>
        </button>
      </div>
    </nav>
  </header>

  <main class="hero">
    <div>
      <span class="eyebrow">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><path d="M12 6v6l4 2"/></svg>
        Delivering across your city
      </span>
      <h1>Fast food<span class="accent">delivered fresh</span></h1>
      <p class="lede">Order from your favourite restaurants and watch your food make its way to you, live, on the map.</p>
      <div class="hero-cta">
        <a href="${pageContext.request.contextPath}/restaurants" class="btn-primary">
          Order now
          <svg viewBox="0 0 24 24" fill="none" stroke="#04342C" stroke-width="2.5"><path d="M5 12h14M13 6l6 6-6 6"/></svg>
        </a>
        <a href="#how-it-works" class="link-text">How it works</a>
      </div>
    </div>

    <div class="hero-visual">
      <img class="hero-photo" src="https://images.unsplash.com/photo-1572195577046-2f25894c06fc?auto=format&fit=crop&w=900&q=75" alt="Delivery rider on a scooter carrying an order through the city">
      <span class="float-pill eta">12 min away</span>
      <span class="float-pill live"><span class="dot"></span>Live</span>
    </div>
  </main>

  <section class="features" id="how-it-works">
    <div class="card restaurants">
      <div class="card-photo"></div>
      <h3>Browse restaurants</h3>
      <p>Discover places near you, sorted by what you're craving.</p>
    </div>
    <div class="card plain">
      <div class="card-icon">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M13 2L4 14h6l-1 8 9-12h-6l1-8z"/></svg>
      </div>
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
