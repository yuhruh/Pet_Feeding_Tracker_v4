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

// --- Click handling ---
// One listener on the document, added once when this module loads, handles
// every click below. Listeners added to elements on turbo:load would pile up on
// pages that morph (Today, a viewer's page): morphing keeps the elements and
// fires turbo:load again, so after a refresh each click ran twice, and a menu
// or the dark mode switch toggled open and shut again at once.
const toggleHamburgerMenu = (hamburgerBtn, hamburgerMenu) => {
  hamburgerBtn.classList.toggle('open');
  hamburgerMenu.classList.toggle('flex');
  hamburgerMenu.classList.toggle('hidden');
};

const toggleTheme = () => {
  const themeToggleDarkIcon = document.getElementById('theme-toggle-dark-icon');
  const themeToggleLightIcon = document.getElementById('theme-toggle-light-icon');
  if (themeToggleDarkIcon) themeToggleDarkIcon.classList.toggle('hidden');
  if (themeToggleLightIcon) themeToggleLightIcon.classList.toggle('hidden');
  const dark = !document.documentElement.classList.contains('dark');
  document.documentElement.classList.toggle('dark', dark);
  localStorage.setItem('color-theme', dark ? 'dark' : 'light');
};

const showTab = (target) => {
  document.querySelectorAll('.tab').forEach(tab => {
    if (tab.children[0]) {
      tab.children[0].classList.remove('border-softRed', 'border-b-4', 'md:border-b-0');
    }
  });
  document.querySelectorAll('.panel').forEach(panel => panel.classList.add('hidden'));
  target.classList.add('border-softRed', 'border-b-4');
  const panelString = target.getAttribute('data-target');
  const panelContainer = document.getElementById('panels');
  if (panelContainer && panelString) {
    const targetPanel = panelContainer.getElementsByClassName(panelString)[0];
    if (targetPanel) targetPanel.classList.remove('hidden');
  }
};

const showReport = (organ) => {
  document.querySelectorAll('.report').forEach(report => report.classList.add('hidden'));
  const targetName = organ.dataset.target || organ.textContent.trim().toLowerCase();
  const organTarget = document.getElementById(targetName);
  if (organTarget) {
    organTarget.classList.remove('hidden');
    organTarget.classList.add('flex');
  }
};

const handleClick = (event) => {
  const dropdownMenus = document.querySelectorAll('.menu');
  const hamburgerBtn = document.getElementById('menu-btn');
  const hamburgerMenu = document.getElementById('menu');

  // A dropdown button opens its menu and closes the others.
  const dropdownButton = event.target.closest('.btn[data-target]');
  if (dropdownButton) {
    event.preventDefault();
    const targetMenuId = dropdownButton.dataset.target;
    dropdownMenus.forEach(menu => {
      if (menu.id !== targetMenuId) menu.classList.add('hidden');
    });
    const targetMenu = document.getElementById(targetMenuId);
    if (targetMenu) targetMenu.classList.toggle('hidden');
    return;
  }

  if (hamburgerBtn && hamburgerMenu && hamburgerBtn.contains(event.target)) {
    event.preventDefault();
    toggleHamburgerMenu(hamburgerBtn, hamburgerMenu);
    return;
  }

  const themeToggleBtn = document.getElementById('theme-toggle');
  if (themeToggleBtn && themeToggleBtn.contains(event.target)) {
    event.preventDefault();
    toggleTheme();
    return;
  }

  // Close the hamburger menu when one of its links is clicked.
  if (hamburgerBtn && hamburgerMenu && event.target.closest('#menu a') && !hamburgerMenu.classList.contains('hidden')) {
    toggleHamburgerMenu(hamburgerBtn, hamburgerMenu);
  }

  const tab = event.target.closest('.tab');
  if (tab) showTab(event.target.closest('[data-target]') || tab);

  const organ = event.target.closest('.organ');
  if (organ) showReport(organ);

  // A click outside every menu closes them.
  const isClickInsideDropdownMenu = Array.from(dropdownMenus).some(menu => menu.contains(event.target));
  const isClickInsideHamburgerMenu = hamburgerMenu ? hamburgerMenu.contains(event.target) : false;
  if (!isClickInsideDropdownMenu && !isClickInsideHamburgerMenu) {
    dropdownMenus.forEach(menu => menu.classList.add('hidden'));
    if (hamburgerMenu) hamburgerMenu.classList.add('hidden');
  }
};

// Remove existing global listeners to avoid duplicates (though they are only added once outside turbo:load)
window.removeEventListener('resize', handleResize);
window.addEventListener('resize', handleResize);
document.removeEventListener('click', handleClick);
document.addEventListener('click', handleClick);

// A page that morphs when someone else records care (Today, a viewer's page)
// would otherwise reset the menus to the server's classes, closing an open one
// under the reader's pointer.
document.addEventListener('turbo:before-morph-attribute', (event) => {
  const element = event.target;
  if (event.detail.attributeName === 'class' && (element.matches('.menu') || element.id === 'menu' || element.id === 'menu-btn')) {
    event.preventDefault();
  }
});

// Close the menus before Turbo caches the page, so Back doesn't show one open.
document.addEventListener('turbo:before-cache', () => {
  document.querySelectorAll('.menu').forEach(menu => menu.classList.add('hidden'));
  const hamburgerBtn = document.getElementById('menu-btn');
  const hamburgerMenu = document.getElementById('menu');
  if (hamburgerBtn) hamburgerBtn.classList.remove('open');
  if (hamburgerMenu) {
    hamburgerMenu.classList.add('hidden');
    hamburgerMenu.classList.remove('flex');
  }
});

// Runs on every turbo:load, so it only sets things up; clicks are handled above.
const initializeNavigation = () => {
  // Health checks: every report starts hidden until an organ is clicked.
  document.querySelectorAll('.report').forEach(report => report.classList.add('hidden'));

  // --- Dark/Light Mode ---
  const themeToggleDarkIcon = document.getElementById('theme-toggle-dark-icon');
  const themeToggleLightIcon = document.getElementById('theme-toggle-light-icon');
  if (localStorage.getItem('color-theme') === 'dark' || (!('color-theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
    document.documentElement.classList.add('dark');
    if (themeToggleLightIcon) themeToggleLightIcon.classList.remove('hidden');
    if (themeToggleDarkIcon) themeToggleDarkIcon.classList.add('hidden');
  } else {
    document.documentElement.classList.remove('dark');
    if (themeToggleDarkIcon) themeToggleDarkIcon.classList.remove('hidden');
    if (themeToggleLightIcon) themeToggleLightIcon.classList.add('hidden');
  }

  // make the scrolls the chart of the right side
  const container = document.getElementById('chart-container');
  if (container) {
    container.scrollLeft = container.scrollWidth;
  }
};

document.addEventListener("turbo:load", initializeNavigation);
