(function(){

  /* Mobile nav toggle */
  var navToggle = document.getElementById('navToggle');
  var navLinks  = document.getElementById('navLinks');
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
  var profileBtn         = document.getElementById('profileAvatarBtn');
  var dropdownMenu       = document.getElementById('dropdownMenu');
  var userProfileDropdown = document.getElementById('userProfileDropdown');

  if(profileBtn && dropdownMenu){
    profileBtn.addEventListener('click', function(event){
      event.stopPropagation();
      var isExpanded = profileBtn.getAttribute('aria-expanded') === 'true';
      profileBtn.setAttribute('aria-expanded', String(!isExpanded));
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
  document.querySelectorAll('.btn-minus').forEach(function(btn){
    btn.addEventListener('click', function(){
      var input = btn.closest('.qty-stepper').querySelector('.qty-input');
      if(input){
        var val = parseInt(input.value, 10) || 1;
        if(val > 1) input.value = val - 1;
      }
    });
  });

  document.querySelectorAll('.btn-plus').forEach(function(btn){
    btn.addEventListener('click', function(){
      var input = btn.closest('.qty-stepper').querySelector('.qty-input');
      if(input){
        var val = parseInt(input.value, 10) || 1;
        input.value = val + 1;
      }
    });
  });

  /* Cart bar */
  var cartBar = document.getElementById('cartBar');

  function showCartBar(){
    sessionStorage.setItem('bitehouse_cart_active', 'true');
    if(cartBar) cartBar.classList.add('show');
  }

  // Persist cart bar if user already added something this session
  if(cartBar && sessionStorage.getItem('bitehouse_cart_active') === 'true'){
    cartBar.classList.add('show');
  }

  /* Add-to-cart via AJAX — keeps user on page, updates DB, shows cart bar */
  document.querySelectorAll('.menu-item-control').forEach(function(form){
    form.addEventListener('submit', function(e){
      e.preventDefault();

      var formData = new FormData(form);
      var btn = form.querySelector('.btn-add');

      // Visual feedback
      if(btn){ btn.textContent = 'Adding…'; btn.disabled = true; }

      fetch(form.action, {
        method : 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' },
        body   : formData
      })
      .then(function(res){
        if(res.ok) return res.json();
        throw new Error('Server error ' + res.status);
      })
      .then(function(data){
        if(data && data.success){
          showCartBar();
          if(btn){ btn.textContent = 'Added ✓'; }
          setTimeout(function(){ if(btn){ btn.textContent = 'Add'; btn.disabled = false; } }, 1500);
        } else {
          throw new Error('Unexpected response');
        }
      })
      .catch(function(err){
        console.error('Add to cart error:', err);
        // Fallback: if not logged in, server may redirect — handle gracefully
        if(btn){ btn.textContent = 'Sign in to add'; btn.disabled = false; }
        setTimeout(function(){ if(btn){ btn.textContent = 'Add'; } }, 2000);
      });
    });
  });

})();