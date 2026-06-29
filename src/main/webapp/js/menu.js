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

  /* Stepper controls (- and + buttons) */
  var minusBtns = document.querySelectorAll('.btn-minus');
  var plusBtns = document.querySelectorAll('.btn-plus');

  minusBtns.forEach(function(btn){
    btn.addEventListener('click', function(){
      var input = btn.parentElement.querySelector('.qty-input');
      if(input){
        var val = parseInt(input.value) || 1;
        if(val > 1){
          input.value = val - 1;
        }
      }
    });
  });

  plusBtns.forEach(function(btn){
    btn.addEventListener('click', function(){
      var input = btn.parentElement.querySelector('.qty-input');
      if(input){
        var val = parseInt(input.value) || 1;
        input.value = val + 1;
      }
    });
  });

  /* Dynamic cart bar display logic */
  var cartBar = document.getElementById('cartBar');
  
  // Show cart bar if item was previously added in session
  if(cartBar && sessionStorage.getItem('bitehouse_has_added_item') === 'true'){
    cartBar.classList.add('show');
  }

  var itemForms = document.querySelectorAll('.menu-item-control');
  itemForms.forEach(function(form){
    form.addEventListener('submit', function(){
      sessionStorage.setItem('bitehouse_has_added_item', 'true');
      if(cartBar){
        cartBar.classList.add('show');
      }
    });
  });

})();