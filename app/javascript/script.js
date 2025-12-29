const tabs = document.querySelectorAll('.tab');
const panels = document.querySelectorAll('.panel');
const themeToggleBtn = document.getElementById('theme-toggle');
const themeToggleDarkIcon = document.getElementById('theme-toggle-dark-icon');
const themeToggleLightIcon = document.getElementById('theme-toggle-light-icon');

tabs.forEach((tab) => tab.addEventListener('click', onTabClick));

if (
      localStorage.getItem('color-theme') === 'dark' ||
      (!('color-theme' in localStorage) &&
        window.matchMedia('(prefers-color-scheme: dark)').matches)
    ) {
      // show light icon
      themeToggleLightIcon.classList.remove('hidden');
    } else {
      themeToggleDarkIcon.classList.remove('hidden');
    }

function onTabClick(e) {
  // Deactive all tabs
  tabs.forEach((tab) => {
    tab.children[0].classList.remove(
      'border-softRed',
      'border-b-4',
      'md:border-b-0'
    );
  })

  // Hide all panels
  panels.forEach((panel) => panel.classList.add('hidden'));

  e.target.classList.add('border-softRed', 'border-b-4');
  const panelString = e.target.getAttribute('data-target');
  document.getElementById('panels')
  .getElementsByClassName(panelString)[0]
  .classList.remove('hidden');
}