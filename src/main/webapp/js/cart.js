(function() {

    /* Mobile nav toggle */
    var navToggle = document.getElementById('navToggle');
    var navLinks = document.getElementById('navLinks');
    if (navToggle && navLinks) {
        navToggle.addEventListener('click', function() {
            navLinks.classList.toggle('open');
        });
        document.addEventListener('click', function(event) {
            if (!navLinks.contains(event.target) && !navToggle.contains(event.target)) {
                navLinks.classList.remove('open');
            }
        });
    }

    /* Cart totals — display only. The real cart state, pricing, and
       order total will be calculated and persisted by the backend. */
    var DELIVERY_FEE = 2.00;
    var TAX_RATE = 0.05;

    var cartItems = document.getElementById('cartItems');
    var emptyCart = document.getElementById('emptyCart');
    var subtotalEl = document.getElementById('subtotal');
    var deliveryFeeEl = document.getElementById('deliveryFee');
    var taxesEl = document.getElementById('taxes');
    var totalEl = document.getElementById('total');

    function formatCurrency(value) {
        return '$' + value.toFixed(2);
    }

    function recalculate() {
        var subtotal = 0;
        var visibleItems = cartItems.querySelectorAll('.cart-item');

        visibleItems.forEach(function(item) {
            var price = parseFloat(item.getAttribute('data-price'));
            var qty = parseInt(item.querySelector('.qty').textContent, 10);
            var lineTotal = price * qty;
            item.querySelector('.cart-item-line-total').textContent = formatCurrency(lineTotal);
            subtotal += lineTotal;
        });

        var deliveryFee = visibleItems.length > 0 ? DELIVERY_FEE : 0;
        var taxes = subtotal * TAX_RATE;
        var total = subtotal + deliveryFee + taxes;

        subtotalEl.textContent = formatCurrency(subtotal);
        deliveryFeeEl.textContent = formatCurrency(deliveryFee);
        taxesEl.textContent = formatCurrency(taxes);
        totalEl.textContent = formatCurrency(total);

        if (emptyCart) {
            emptyCart.classList.toggle('is-visible', visibleItems.length === 0);
        }
    }

    function bindItem(item) {
        var qtyEl = item.querySelector('.qty');
        var increaseBtn = item.querySelector('.qty-increase');
        var decreaseBtn = item.querySelector('.qty-decrease');
        var removeBtn = item.querySelector('.remove-item');

        increaseBtn.addEventListener('click', function() {
            qtyEl.textContent = parseInt(qtyEl.textContent, 10) + 1;
            recalculate();
        });

        decreaseBtn.addEventListener('click', function() {
            var current = parseInt(qtyEl.textContent, 10);
            if (current <= 1) {
                item.remove();
            } else {
                qtyEl.textContent = current - 1;
            }
            recalculate();
        });

        removeBtn.addEventListener('click', function() {
            item.remove();
            recalculate();
        });
    }

    cartItems.querySelectorAll('.cart-item').forEach(bindItem);
    recalculate();

})();