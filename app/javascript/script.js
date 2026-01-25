document.addEventListener('turbo:load', () => {
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

    const toggleMode = () => {
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
  const dropdownButtons = document.querySelectorAll('.btn');
  const dropdownMenus = document.querySelectorAll('.menu');
  const hamburgerBtn = document.getElementById('menu-btn');
  const hamburgerMenu = document.getElementById('menu');

  // Handle dropdown menus
  dropdownButtons.forEach(button => {
    button.addEventListener('click', (event) => {
      event.stopPropagation();
      const targetMenuId = button.dataset.target;
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
    hamburgerBtn.addEventListener('click', (event) => {
      event.stopPropagation();
      hamburgerBtn.classList.toggle('open');
      hamburgerMenu.classList.toggle('flex');
      hamburgerMenu.classList.toggle('hidden');
    });
  }

  // Global click listener to close all menus
  document.addEventListener('click', (event) => {
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
  });

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
});