// material-ui
import { Badge, Grid, List, ListItemAvatar, ListItemButton, ListItemText, Switch, useTheme } from '@mui/material';

// assets
import Avatar from 'components/ui-component/extended/Avatar';
import { useState } from 'react';
import { useDispatch } from 'store';
import { gridSpacing } from 'store/constant';
import { openSnackbar } from 'store/slices/snackbar';
import { getPostOfTopic } from 'store/slices/topic';
import axiosServices from 'utils/axios';
// ================================|| UI LIST - SIMPLE LIST ||================================ //

const TopicShowList = ({ list, setSelectedTopic }) => {
   const theme = useTheme();
   const dispatch = useDispatch();

   const handleSelectedTopic = topic => {
      setSelectedTopic(topic);
      dispatch(getPostOfTopic(topic.id));
   };
   const handleChangeChecked = async (checked, id) => {
      try {
         const { data } = await axiosServices.put(`/admin/Topic/update/${id}`, { isAdmin: checked });
         if (data.code === 200) {
            dispatch(
               openSnackbar({
                  open: true,
                  message: data.message,
                  variant: 'alert',
                  alert: {
                     color: 'success'
                  },
                  close: true
               })
            );
         } else {
            dispatch(
               openSnackbar({
                  open: true,
                  message: data.message,
                  variant: 'alert',
                  alert: {
                     color: 'error'
                  },
                  close: false
               })
            );
         }
      } catch (error) {
         dispatch(
            openSnackbar({
               open: true,
               message: error.response?.data.message,
               variant: 'alert',
               alert: {
                  color: 'error'
               },
               close: false
            })
         );
      }
   }
   return (
      <List component="nav" aria-label="main mailbox folders">
         {list?.map(item => (
            <ListItemButton key={item.id} className="cursor-default" onClick={() => handleSelectedTopic(item)}>
               <Grid container alignItems="center" justifyContent="space-between">
                  <Grid item>
                     <Grid container alignItems="center" justifyContent="flex-end">
                        <Grid item>
                           <ListItemAvatar>
                              <Avatar size="xs" color="primary" outline src={item.icon} />
                           </ListItemAvatar>
                        </Grid>
                        <Grid item>
                           <ListItemText primary={item.title} />
                        </Grid>
                     </Grid>
                  </Grid>
                  <Grid item>
                     <Grid container alignItems="center" justifyContent="flex-end" spacing={gridSpacing}>
                        <Grid item onClick={e => e.stopPropagation()}>
                           <Switch
                              defaultChecked={!item.isAdmin}
                              onChange={(e) => {
                                 handleChangeChecked(!e.target.checked, item.id)
                              }}
                              sx={{
                                 color: theme.palette.success.dark,
                                 '& .Mui-checked': { color: `${theme.palette.success.dark} !important` },
                                 '& .Mui-checked+.MuiSwitch-track': {
                                    bgcolor: `${theme.palette.success.light} !important`
                                 }
                              }} />
                        </Grid>
                        <Grid item>
                           <Badge color="secondary" badgeContent={item.numberPost}></Badge>
                        </Grid>
                     </Grid>
                  </Grid>
               </Grid>
            </ListItemButton>
         ))}
      </List>
   );
};

export default TopicShowList;
