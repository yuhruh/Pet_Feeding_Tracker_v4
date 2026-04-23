// Global function to handle window resize
const handleResize = () => {
  const hamburgerBtn = document.getElementById('menu-btn');
  const hamburgerMenu = document.getElementById('menu');
  if (window.innerWidth >= 1024) { // Tailwind's lg breakpoint
    if (hamburgerMenu && !hamburgerMenu.classList.contains('hidden')) {
      if (hamburgerBtn) hamburgerBtn.classList.remove('open');
      hamburgerMenu.classList.add('hidden');
      hamburgerMenu.classList.remove('flex');
    }
  }
};

// Global function to handle clicks outside menus
const handleGlobalClick = (event) => {
  const dropdownButtons = document.querySelectorAll('.btn[data-target]');
  const dropdownMenus = document.querySelectorAll('.menu');
  const hamburgerBtn = document.getElementById('menu-btn');
  const hamburgerMenu = document.getElementById('menu');

  const isClickInsideDropdownButton = Array.from(dropdownButtons).some(btn => btn.contains(event.target));
  const isClickInsideDropdownMenu = Array.from(dropdownMenus).some(menu => menu.contains(event.target));
  const isClickOnHamburgerBtn = hamburgerBtn ? hamburgerBtn.contains(event.target) : false;
  const isClickInsideHamburgerMenu = hamburgerMenu ? hamburgerMenu.contains(event.target) : false;

  if (!isClickInsideDropdownButton && !isClickInsideDropdownMenu && !isClickOnHamburgerBtn && !isClickInsideHamburgerMenu) {
    dropdownMenus.forEach(menu => menu.classList.add('hidden'));
    if (hamburgerMenu) {
      hamburgerMenu.classList.add('hidden');
    }
  }
};

// Remove existing global listeners to avoid duplicates (though they are only added once outside turbo:load)
window.removeEventListener('resize', handleResize);
window.addEventListener('resize', handleResize);
document.removeEventListener('click', handleGlobalClick);
document.addEventListener('click', handleGlobalClick);

const initializeNavigation = () => {
  // --- Tab Switching Logic ---
  const tabs = document.querySelectorAll('.tab');
  const panels = document.querySelectorAll('.panel');

  if (tabs.length > 0 && panels.length > 0) {
    const onTabClick = (e) => {
      tabs.forEach(tab => {
        if (tab.children[0]) {
          tab.children[0].classList.remove('border-softRed', 'border-b-4', 'md:border-b-0');
        }
      });
      panels.forEach(panel => panel.classList.add('hidden'));
      if (e.target) {
        e.target.classList.add('border-softRed', 'border-b-4');
        const panelString = e.target.getAttribute('data-target');
        const panelContainer = document.getElementById('panels');
        if (panelContainer && panelString) {
          const targetPanel = panelContainer.getElementsByClassName(panelString)[0];
          if (targetPanel) {
            targetPanel.classList.remove('hidden');
          }
        }
      }
    };
    tabs.forEach(tab => tab.addEventListener('click', onTabClick));
  }

  // --- Report Switching Logic ---
  const organs = document.querySelectorAll('.organ');
  const reports = document.querySelectorAll('.report');

  if (organs.length > 0 && reports.length > 0) {
    reports.forEach(report => report.classList.add('hidden'));
    
    const organClick = (e) => {
      reports.forEach(report => report.classList.add('hidden'));
      let targetName = e.currentTarget.dataset.target || e.currentTarget.textContent.trim().toLowerCase();
      const organTarget = document.getElementById(targetName);
      if (organTarget) {
        organTarget.classList.remove('hidden');
        organTarget.classList.add('flex');
      }
    }
    organs.forEach(organ => organ.addEventListener('click', organClick));
  }


  // --- Dark/Light Mode Toggle ---
  const themeToggleBtn = document.getElementById('theme-toggle');
  if (themeToggleBtn) {
    const themeToggleDarkIcon = document.getElementById('theme-toggle-dark-icon');
    const themeToggleLightIcon = document.getElementById('theme-toggle-light-icon');

    const applyTheme = () => {
      if (localStorage.getItem('color-theme') === 'dark' || (!('color-theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark');
        if (themeToggleLightIcon) themeToggleLightIcon.classList.remove('hidden');
        if (themeToggleDarkIcon) themeToggleDarkIcon.classList.add('hidden');
      } else {
        document.documentElement.classList.remove('dark');
        if (themeToggleDarkIcon) themeToggleDarkIcon.classList.remove('hidden');
        if (themeToggleLightIcon) themeToggleLightIcon.classList.add('hidden');
      }
    };

    const toggleMode = (e) => {
      e.preventDefault();
      e.stopPropagation();
      if (themeToggleDarkIcon) themeToggleDarkIcon.classList.toggle('hidden');
      if (themeToggleLightIcon) themeToggleLightIcon.classList.toggle('hidden');
      if (localStorage.getItem('color-theme')) {
        if (localStorage.getItem('color-theme') === 'light') {
          document.documentElement.classList.add('dark');
          localStorage.setItem('color-theme', 'dark');
        } else {
          document.documentElement.classList.remove('dark');
          localStorage.setItem('color-theme', 'light');
        }
      } else {
        if (document.documentElement.classList.contains('dark')) {
          document.documentElement.classList.remove('dark');
          localStorage.setItem('color-theme', 'light');
        } else {
          document.documentElement.classList.add('dark');
          localStorage.setItem('color-theme', 'dark');
        }
      }
    };
    applyTheme();
    themeToggleBtn.addEventListener('click', toggleMode);
  }

  // --- Dropdown and Hamburger Menu Logic ---
  const dropdownButtons = document.querySelectorAll('.btn[data-target]');
  const dropdownMenus = document.querySelectorAll('.menu');
  const hamburgerBtn = document.getElementById('menu-btn');
  const hamburgerMenu = document.getElementById('menu');

  // Handle dropdown menus
  dropdownButtons.forEach(button => {
    button.addEventListener('click', (event) => {
      const targetMenuId = button.dataset.target;
      
      // If this button doesn't have a data-target for a menu, don't intercept it
      if (!targetMenuId) return;

      event.preventDefault();
      event.stopPropagation();
      
      const targetMenu = document.getElementById(targetMenuId);
      dropdownMenus.forEach(menu => {
        if (menu.id !== targetMenuId) {
          menu.classList.add('hidden');
        }
      });
      if (targetMenu) {
        targetMenu.classList.toggle('hidden');
      }
    });
  });

  // Handle hamburger menu
  if (hamburgerBtn && hamburgerMenu) {
    const toggleHamburgerMenu = () => {
      hamburgerBtn.classList.toggle('open');
      hamburgerMenu.classList.toggle('flex');
      hamburgerMenu.classList.toggle('hidden');
    };

    hamburgerBtn.addEventListener('click', (event) => {
      event.preventDefault();
      event.stopPropagation();
      toggleHamburgerMenu();
    });

    // Close menu when a link is clicked
    hamburgerMenu.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', () => {
        if (!hamburgerMenu.classList.contains('hidden')) {
          toggleHamburgerMenu();
        }
      });
    });
  }

  // --- Alert Dismissal ---
  const closeAlertBtn = document.getElementById('close-alert');
  if (closeAlertBtn) {
    closeAlertBtn.addEventListener('click', () => {
      const alertMessage = document.getElementById('alert-message');
      if (alertMessage) {
        alertMessage.classList.add('opacity-0');
        setTimeout(() => {
          alertMessage.remove();
        }, 300);
      }
    });
  }

  // make the scrolls the chart of the right side
  const container = document.getElementById('chart-container');
  if (container) {
    container.scrollLeft = container.scrollWidth;
  }
};

document.addEventListener("turbo:load", initializeNavigation);
