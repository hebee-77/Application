(function () {
  'use strict';

  /* Profile dropdown — identical to restaurants.js */
  var profileBtn          = document.getElementById('profileAvatarBtn');
  var dropdownMenu        = document.getElementById('dropdownMenu');
  var userProfileDropdown = document.getElementById('userProfileDropdown');

  if (profileBtn && dropdownMenu) {
    profileBtn.addEventListener('click', function (event) {
      event.stopPropagation();
      var isExpanded = profileBtn.getAttribute('aria-expanded') === 'true';
      profileBtn.setAttribute('aria-expanded', !isExpanded);
      dropdownMenu.classList.toggle('show');
    });

    document.addEventListener('click', function (event) {
      if (userProfileDropdown && !userProfileDropdown.contains(event.target)) {
        profileBtn.setAttribute('aria-expanded', 'false');
        dropdownMenu.classList.remove('show');
      }
    });
  }

})();
