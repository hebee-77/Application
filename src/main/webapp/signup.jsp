<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Bite House — Sign up</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/signup.css">
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

			<h1>Create your account</h1>
			<p class="auth-sub">Sign up to start ordering from restaurants
				near you.</p>

			<form action="signup"
				method="post" class="auth-form">

				<label for="name">Full name</label> <input type="text" id="name"
					name="name" placeholder="Your name" required autocomplete="name">

				<label for="email">Email</label> <input type="email" id="email"
					name="email" placeholder="you@example.com" required
					autocomplete="email"> <label for="password">Password</label>
				<div class="password-field">
					<input type="password" id="password" name="password"
						placeholder="Create a password" required
						autocomplete="new-password">
					<button type="button" class="toggle-password"
						data-target="password" aria-label="Show password">
						<svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
							stroke-width="2">
							<path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7-11-7-11-7z" />
							<circle cx="12" cy="12" r="3" /></svg>
					</button>
				</div>

				<label for="confirmPassword">Confirm password</label>
				<div class="password-field">
					<input type="password" id="confirmPassword" name="confirmPassword"
						placeholder="Re-enter your password" required
						autocomplete="new-password">
					<button type="button" class="toggle-password"
						data-target="confirmPassword" aria-label="Show password">
						<svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
							stroke-width="2">
							<path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7-11-7-11-7z" />
							<circle cx="12" cy="12" r="3" /></svg>
					</button>
				</div>

				<button type="submit" class="btn-primary full">Create
					account</button>
			</form>

			<p class="auth-switch">
				Already have an account? <a
					href="login.jsp">Sign in</a>
			</p>

		</div>
	</div>

	<script src="${pageContext.request.contextPath}/js/signup.js"></script>
</body>
</html>
