// Encapsulate all setup logic in a function to be called on page loads
function setupPage() {
  // 1. Setup tab switching functionality
  const tabs = document.querySelectorAll('.tab');
  const panels = document.querySelectorAll('.panel');

  if (tabs.length > 0 && panels.length > 0) {
    const onTabClick = (e) => {
      // Deactivate all tabs
      tabs.forEach((tab) => {
        if (tab.children[0]) {
          tab.children[0].classList.remove(
            'border-softRed',
            'border-b-4',
            'md:border-b-0'
          );
        }
      });

      // Hide all panels
      panels.forEach((panel) => panel.classList.add('hidden'));

      // Activate the clicked tab and corresponding panel
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

    tabs.forEach((tab) => tab.addEventListener('click', onTabClick));
  }

  // 2. Setup theme toggling functionality
  const themeToggleBtn = document.getElementById('theme-toggle');
  if (themeToggleBtn) {
    const themeToggleDarkIcon = document.getElementById('theme-toggle-dark-icon');
    const themeToggleLightIcon = document.getElementById('theme-toggle-light-icon');

    // Function to apply the correct theme and icon state
    const applyTheme = () => {
      if (
        localStorage.getItem('color-theme') === 'dark' ||
        (!('color-theme' in localStorage) &&
          window.matchMedia('(prefers-color-scheme: dark)').matches)
      ) {
        document.documentElement.classList.add('dark');
        if (themeToggleLightIcon) themeToggleLightIcon.classList.remove('hidden');
        if (themeToggleDarkIcon) themeToggleDarkIcon.classList.add('hidden');
      } else {
        document.documentElement.classList.remove('dark');
        if (themeToggleDarkIcon) themeToggleDarkIcon.classList.remove('hidden');
        if (themeToggleLightIcon) themeToggleLightIcon.classList.add('hidden');
      }
    };

    // Function to handle the button click
    const toggleMode = () => {
      // Toggle icon visibility
      if (themeToggleDarkIcon) themeToggleDarkIcon.classList.toggle('hidden');
      if (themeToggleLightIcon) themeToggleLightIcon.classList.toggle('hidden');

      // Check localStorage and toggle the theme
      if (localStorage.getItem('color-theme')) {
        if (localStorage.getItem('color-theme') === 'light') {
          document.documentElement.classList.add('dark');
          localStorage.setItem('color-theme', 'dark');
        } else {
          document.documentElement.classList.remove('dark');
          localStorage.setItem('color-theme', 'light');
        }
      } else {
        // If theme is not explicitly set in localStorage
        if (document.documentElement.classList.contains('dark')) {
          document.documentElement.classList.remove('dark');
          localStorage.setItem('color-theme', 'light');
        } else {
          document.documentElement.classList.add('dark');
          localStorage.setItem('color-theme', 'dark');
        }
      }
    };

    // Apply the theme as soon as the page loads
    applyTheme();

    // Add the click listener to the toggle button
    themeToggleBtn.addEventListener('click', toggleMode);
  }
}

// Key change: Execute the setup function on 'turbo:load', which fires
// on the initial page load and after every Turbo-driven navigation.
document.addEventListener('turbo:load', setupPage);
