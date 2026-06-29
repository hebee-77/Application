(function(){

  /* Mobile nav toggle */
  var navToggle = document.getElementById('navToggle');
  var navLinks = document.getElementById('navLinks');
  if(navToggle && navLinks){
    navToggle.addEventListener('click', function(){
      navLinks.classList.toggle('open');
    });
    document.addEventListener('click', function(event){
      if(!navLinks.contains(event.target) && !navToggle.contains(event.target)){
        navLinks.classList.remove('open');
      }
    });
  }

  /* User profile dropdown */
  var profileBtn = document.getElementById('profileAvatarBtn');
  var dropdownMenu = document.getElementById('dropdownMenu');
  var userProfileDropdown = document.getElementById('userProfileDropdown');

  if(profileBtn && dropdownMenu){
    profileBtn.addEventListener('click', function(event){
      event.stopPropagation();
      var isExpanded = profileBtn.getAttribute('aria-expanded') === 'true';
      profileBtn.setAttribute('aria-expanded', !isExpanded);
      dropdownMenu.classList.toggle('show');
    });

    document.addEventListener('click', function(event){
      if(userProfileDropdown && !userProfileDropdown.contains(event.target)){
        dropdownMenu.classList.remove('show');
        profileBtn.setAttribute('aria-expanded', 'false');
      }
    });

    document.addEventListener('keydown', function(event){
      if(event.key === 'Escape'){
        dropdownMenu.classList.remove('show');
        profileBtn.setAttribute('aria-expanded', 'false');
      }
    });
  }

})();