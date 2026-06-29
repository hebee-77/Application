(function() {
    var toggle = document.getElementById('togglePassword');
    var input = document.getElementById('password');

    if (!toggle || !input) { return; }

    toggle.addEventListener('click', function() {
        var isHidden = input.getAttribute('type') === 'password';
        input.setAttribute('type', isHidden ? 'text' : 'password');
        toggle.setAttribute('aria-label', isHidden ? 'Hide password' : 'Show password');
    });
})();