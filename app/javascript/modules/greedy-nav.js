import greedyNav from '@citizensadvice/design-system/lib/greedy-nav';

export default function initGreedyNav() {
  greedyNav.init({
    mainNavWrapper: '.cads-navigation',
    initClass: 'cads-greedy-nav-init',
  });
}
