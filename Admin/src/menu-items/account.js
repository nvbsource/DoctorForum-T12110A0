// third-party
import { FormattedMessage } from 'react-intl';

// assets
import { IconChartArcs, IconClipboardList, IconBrandGoogleAnalytics } from '@tabler/icons';

// constant
const icons = {
   IconChartArcs,
   IconClipboardList,
   IconBrandGoogleAnalytics
};

const account = {
   id: 'account',
   title: 'Account',
   icon: icons.IconChartArcs,
   type: 'group',
   children: [
      {
         id: 'account-list',
         title: 'Account List',
         type: 'item',
         url: '/account/account-list',
         icon: icons.IconChartArcs
      }
   ]
};

export default account;
