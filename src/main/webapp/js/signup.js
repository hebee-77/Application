(function() {
    var toggles = document.querySelectorAll('.toggle-password');

    toggles.forEach(function(toggle) {
        var targetId = toggle.getAttribute('data-target');
        var input = document.getElementById(targetId);
        if (!input) { return; }

        toggle.addEventListener('click', function() {
            var isHidden = input.getAttribute('type') === 'password';
            input.setAttribute('type', isHidden ? 'text' : 'password');
            toggle.setAttribute('aria-label', isHidden ? 'Hide password' : 'Show password');
        });
    });
})();