<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Bite House — Your cart</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/cart.css">
</head>
<body>

	<header class="site-header">
		<div class="wrap">
			<nav>
				<a href="${pageContext.request.contextPath}/" class="brand"> <span
					class="brand-mark"> <svg viewBox="0 0 24 24" fill="none"
							stroke="#FFFFFF" stroke-width="2">
							<path d="M3 11l9-8 9 8M5 10v10h14V10" /></svg>
				</span> Bite House
				</a>
				<ul class="nav-links" id="navLinks">
					<li><a href="${pageContext.request.contextPath}/restaurants">Restaurants</a></li>
					<li><a href="${pageContext.request.contextPath}/#how-it-works">How
							it works</a></li>
					<li><a href="#contact">Contact</a></li>
				</ul>
				<div class="nav-right">
					<a href="${pageContext.request.contextPath}/login"
						class="btn-ghost">Sign in</a>
					<button class="nav-toggle" aria-label="Open menu" id="navToggle">
						<span></span><span></span><span></span>
					</button>
				</div>
			</nav>
		</div>
	</header>

	<main class="wrap">

		<a href="${pageContext.request.contextPath}/restaurant?id=1"
			class="back-link"> <svg viewBox="0 0 24 24" fill="none"
				stroke="currentColor" stroke-width="2">
				<path d="M19 12H5M11 18l-6-6 6-6" /></svg> Back to Burger Barn
		</a>

		<h1 class="page-title">Your cart</h1>

		<form action="${pageContext.request.contextPath}/checkout"
			method="post" class="cart-grid">

			<section class="cart-items" id="cartItems">

				<div class="cart-item" data-item-id="classic-cheeseburger"
					data-price="8.99">
					<div class="cart-item-photo"
						style="background-image: url('https://images.unsplash.com/photo-1550317138-10000687a72b?auto=format&amp;fit=crop&amp;w=200&amp;q=70');"></div>
					<div class="cart-item-info">
						<h3>Classic cheeseburger</h3>
						<p class="cart-item-unit-price">$8.99 each</p>
					</div>
					<div class="cart-item-controls">
						<div class="stepper">
							<button type="button" class="qty-decrease"
								aria-label="Decrease quantity">&minus;</button>
							<span class="qty">2</span>
							<button type="button" class="qty-increase"
								aria-label="Increase quantity">+</button>
						</div>
						<span class="cart-item-line-total">$17.98</span>
						<button type="button" class="remove-item" aria-label="Remove item">
							<svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2">
								<path
									d="M3 6h18M8 6V4a1 1 0 011-1h6a1 1 0 011 1v2m3 0l-1 14a2 2 0 01-2 2H7a2 2 0 01-2-2L4 6" /></svg>
						</button>
					</div>
				</div>

				<div class="cart-item" data-item-id="french-fries" data-price="3.49">
					<div class="cart-item-photo icon-photo">
						<svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
							stroke-width="1.6">
							<path d="M5 21V9m4.5 12V6m5 15V9m4.5 12V6M3 9h18l-1.5-5h-15z" /></svg>
					</div>
					<div class="cart-item-info">
						<h3>French fries</h3>
						<p class="cart-item-unit-price">$3.49 each</p>
					</div>
					<div class="cart-item-controls">
						<div class="stepper">
							<button type="button" class="qty-decrease"
								aria-label="Decrease quantity">&minus;</button>
							<span class="qty">1</span>
							<button type="button" class="qty-increase"
								aria-label="Increase quantity">+</button>
						</div>
						<span class="cart-item-line-total">$3.49</span>
						<button type="button" class="remove-item" aria-label="Remove item">
							<svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2">
								<path
									d="M3 6h18M8 6V4a1 1 0 011-1h6a1 1 0 011 1v2m3 0l-1 14a2 2 0 01-2 2H7a2 2 0 01-2-2L4 6" /></svg>
						</button>
					</div>
				</div>

				<div class="cart-item" data-item-id="coke" data-price="1.99">
					<div class="cart-item-photo icon-photo">
						<svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
							stroke-width="1.6">
							<path
								d="M6 8h12l-1 12.5a1.5 1.5 0 01-1.5 1.5h-7a1.5 1.5 0 01-1.5-1.5z" />
							<path d="M6 8l-1-4h14l-1 4" /></svg>
					</div>
					<div class="cart-item-info">
						<h3>Coca-Cola</h3>
						<p class="cart-item-unit-price">$1.99 each</p>
					</div>
					<div class="cart-item-controls">
						<div class="stepper">
							<button type="button" class="qty-decrease"
								aria-label="Decrease quantity">&minus;</button>
							<span class="qty">1</span>
							<button type="button" class="qty-increase"
								aria-label="Increase quantity">+</button>
						</div>
						<span class="cart-item-line-total">$1.99</span>
						<button type="button" class="remove-item" aria-label="Remove item">
							<svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2">
								<path
									d="M3 6h18M8 6V4a1 1 0 011-1h6a1 1 0 011 1v2m3 0l-1 14a2 2 0 01-2 2H7a2 2 0 01-2-2L4 6" /></svg>
						</button>
					</div>
				</div>

				<div class="empty-cart" id="emptyCart">
					<p>Your cart is empty.</p>
					<a href="${pageContext.request.contextPath}/restaurants"
						class="btn-primary">Browse restaurants</a>
				</div>

			</section>

			<aside class="cart-summary">

				<div class="summary-card">
					<h2>Order summary</h2>
					<div class="summary-row">
						<span>Subtotal</span> <span id="subtotal">$23.46</span>
					</div>
					<div class="summary-row">
						<span>Delivery fee</span> <span id="deliveryFee">$2.00</span>
					</div>
					<div class="summary-row">
						<span>Taxes &amp; fees</span> <span id="taxes">$1.17</span>
					</div>
					<div class="summary-row summary-total">
						<span>Total</span> <span id="total">$26.63</span>
					</div>
				</div>

				<div class="summary-card">
					<div class="summary-card-header">
						<h2>Delivery address</h2>
						<a href="#" class="link-text">Change</a>
					</div>
					<p class="address-text">221B Baker Street, Camden, London NW1
						6XE</p>
					<input type="hidden" name="addressId" value="1">
				</div>

				<div class="summary-card">
					<h2>Payment method</h2>
					<label class="payment-option"> <input type="radio"
						name="paymentMethod" value="cod" checked> Cash on delivery
					</label> <label class="payment-option"> <input type="radio"
						name="paymentMethod" value="card"> Credit / debit card
					</label> <label class="payment-option"> <input type="radio"
						name="paymentMethod" value="upi"> UPI
					</label>
				</div>

				<button type="submit" class="btn-primary full">Place order</button>

			</aside>

		</form>

	</main>

	<footer class="wrap">
		<span>&copy; <%=java.time.Year.now()%> Bite House
		</span> <span id="contact">contact@bitehouse.app</span>
	</footer>

	<script src="${pageContext.request.contextPath}/js/cart.js"></script>
</body>
</html>
