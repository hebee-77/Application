(function(){

  /* User profile dropdown toggle */
  var profileBtn = document.getElementById('profileAvatarBtn');
  var dropdownMenu = document.getElementById('dropdownMenu');
  var userProfileDropdown = document.getElementById('userProfileDropdown');
  if (profileBtn && dropdownMenu) {
    profileBtn.addEventListener('click', function(event) {
      event.stopPropagation();
      var isExpanded = profileBtn.getAttribute('aria-expanded') === 'true';
      profileBtn.setAttribute('aria-expanded', !isExpanded);
      dropdownMenu.classList.toggle('show');
    });

    document.addEventListener('click', function(event) {
      if (userProfileDropdown && !userProfileDropdown.contains(event.target)) {
        profileBtn.setAttribute('aria-expanded', 'false');
        dropdownMenu.classList.remove('show');
      }
    });
  }

  /* Favorite (heart) toggle on each restaurant card */
  var favButtons = document.querySelectorAll('.r-card-fav');
  favButtons.forEach(function(btn){
    btn.addEventListener('click', function(event){
      event.preventDefault();
      event.stopPropagation();
      btn.classList.toggle('is-active');
    });
  });

  /* Real-time search and category filtering */
  var searchInput = document.getElementById('searchInput');
  var filterChips = document.querySelectorAll('.filter-chip');
  var restaurantCards = document.querySelectorAll('.r-card');
  var emptyState = document.getElementById('emptyState');

  function filterRestaurants() {
    var query = searchInput ? searchInput.value.toLowerCase().trim() : '';
    
    // Find active chip
    var activeChip = document.querySelector('.filter-chip.active');
    var activeFilter = activeChip ? activeChip.getAttribute('data-filter') : 'all';

    var visibleCount = 0;

    restaurantCards.forEach(function(card) {
      var categories = card.getAttribute('data-category') || '';
      var name = card.querySelector('h3').textContent.toLowerCase();
      var cuisine = card.querySelector('.r-card-cuisine').textContent.toLowerCase();

      // Check if matches category filter
      var matchesCategory = (activeFilter === 'all') || categories.toLowerCase().indexOf(activeFilter.toLowerCase()) !== -1;
      
      // Check if matches search query
      var matchesQuery = !query || name.indexOf(query) !== -1 || cuisine.indexOf(query) !== -1;

      if (matchesCategory && matchesQuery) {
        card.classList.remove('is-hidden');
        visibleCount++;
      } else {
        card.classList.add('is-hidden');
      }
    });

    // Show/hide empty state
    if (emptyState) {
      if (visibleCount === 0) {
        emptyState.classList.add('is-visible');
      } else {
        emptyState.classList.remove('is-visible');
      }
    }
  }

  // Bind search input typing event
  if (searchInput) {
    searchInput.addEventListener('input', filterRestaurants);
  }

  // Bind category chip click events
  filterChips.forEach(function(chip) {
    chip.addEventListener('click', function() {
      filterChips.forEach(function(c) { c.classList.remove('active'); });
      chip.classList.add('active');
      filterRestaurants();
    });
  });

})();