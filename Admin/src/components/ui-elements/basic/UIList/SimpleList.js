// material-ui
import { Badge, Grid, List, ListItemAvatar, ListItemButton, ListItemText } from '@mui/material';

// assets
import Avatar from 'components/ui-component/extended/Avatar';
// ================================|| UI LIST - SIMPLE LIST ||================================ //

export default function SimpleList({ list }) {
   return (
      <div>
         <List component="nav" aria-label="main mailbox folders">
            {list?.map(item => (
               <ListItemButton key={item.id}>
                  <ListItemAvatar>
                     <Avatar size="xs" color="primary" outline src={item.icon} />
                  </ListItemAvatar>
                  <Grid container alignItems="center" justifyContent="space-between">
                     <ListItemText primary={item.title} />
                     <Badge color="secondary" badgeContent={item.numberPost}></Badge>
                  </Grid>
               </ListItemButton>
            ))}
         </List>
      </div>
   );
}
