<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Bite House — Sign in</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>

	<div class="auth-page">
		<div class="auth-card">

			<a href="${pageContext.request.contextPath}/" class="auth-brand">
				<span class="brand-mark"> <svg viewBox="0 0 24 24"
						fill="none" stroke="#FFFFFF" stroke-width="2">
						<path d="M3 11l9-8 9 8M5 10v10h14V10" /></svg>
			</span> Bite House
			</a>

			<h1>Welcome back</h1>
			<p class="auth-sub">Sign in to order from your favourite
				restaurants.</p>

			<form action="login" method="post"
				class="auth-form">

				<label for="email">Email</label> <input type="email" id="email"
					name="email" placeholder="you@example.com" required
					autocomplete="email"> <label for="password">Password</label>
				<div class="password-field">
					<input type="password" id="password" name="password"
						placeholder="Enter your password" required
						autocomplete="current-password">
					<button type="button" class="toggle-password" id="togglePassword"
						aria-label="Show password">
						<svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
							stroke-width="2">
							<path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7-11-7-11-7z" />
							<circle cx="12" cy="12" r="3" /></svg>
					</button>
				</div>

				<div class="auth-row">
					<label class="checkbox"> <input type="checkbox"
						name="remember"> Remember me
					</label> <a href="${pageContext.request.contextPath}/forgot-password"
						class="link-text">Forgot password?</a>
				</div>

				<button type="submit" class="btn-primary full">Sign in</button>
			</form>

			<p class="auth-switch">
				Don't have an account? <a
					href="signup.jsp">Sign up</a>
			</p>

		</div>
	</div>

	<script src="${pageContext.request.contextPath}/js/login.js"></script>
</body>
</html>
