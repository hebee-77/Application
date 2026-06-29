document.addEventListener("DOMContentLoaded", () => {

    /* ================= PASSWORD TOGGLE ================= */

    const toggleBtn = document.getElementById("togglePassword");

    const password = document.getElementById("password");

    if (toggleBtn && password) {

        toggleBtn.addEventListener("click", () => {

            if (password.type === "password") {

                password.type = "text";

                toggleBtn.innerHTML = "🙈";

            } else {

                password.type = "password";

                toggleBtn.innerHTML = "👁";

            }

        });

    }


    /* ================= INPUT ANIMATION ================= */

    const inputs = document.querySelectorAll("input");

    inputs.forEach(input => {

        input.addEventListener("focus", () => {

            input.parentElement.classList.add("active");

        });

        input.addEventListener("blur", () => {

            if (input.value.trim() === "") {

                input.parentElement.classList.remove("active");

            }

        });

    });


    /* ================= BUTTON LOADING ================= */

    const form = document.querySelector("form");

    const submitBtn = document.querySelector(".primary-btn");

    if (form && submitBtn) {

        form.addEventListener("submit", () => {

            submitBtn.disabled = true;

            submitBtn.innerHTML = "Signing in...";

        });

    }


    /* ================= FADE IN ANIMATION ================= */

    const hero = document.querySelector(".hero");

    const authBox = document.querySelector(".auth-box");

    if (hero) {

        hero.classList.add("show");

    }

    if (authBox) {

        authBox.classList.add("show");

    }

});