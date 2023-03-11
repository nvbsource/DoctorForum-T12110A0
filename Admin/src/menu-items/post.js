// third-party

// assets
import { IconBrandGoogleAnalytics, IconChartArcs, IconClipboardList } from '@tabler/icons';

// constant
const icons = {
   IconChartArcs,
   IconClipboardList,
   IconBrandGoogleAnalytics
};

const post = {
   id: 'post',
   title: 'Post',
   icon: icons.IconChartArcs,
   type: 'group',
   children: [
      {
         id: 'post-list',
         title: 'Post List',
         type: 'item',
         url: '/post/post-list',
         icon: icons.IconChartArcs
      }
   ]
};

export default post;
