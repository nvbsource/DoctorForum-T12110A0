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

// ==============================|| WIDGET MENU ITEMS ||============================== //

const dashboard = {
   id: 'dashboard',
   title: 'Dashboard',
   icon: icons.IconChartArcs,
   type: 'group',
   children: [
      {
         id: 'default',
         title: <FormattedMessage id="default" />,
         type: 'item',
         url: '/dashboard/default',
         icon: icons.IconChartArcs
      }
   ]
};

export default dashboard;
