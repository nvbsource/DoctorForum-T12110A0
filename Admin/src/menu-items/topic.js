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

const topic = {
   id: 'topic',
   title: 'Topic',
   icon: icons.IconChartArcs,
   type: 'group',
   children: [
      {
         id: 'topic-list',
         title: 'Topic List',
         type: 'item',
         url: '/topic/topic-list',
         icon: icons.IconChartArcs
      }
   ]
};

export default topic;
