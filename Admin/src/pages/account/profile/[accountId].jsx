// material-ui
import {
   Avatar,
   Box,
   Button,
   Card,
   CardContent,
   Divider,
   Grid,
   IconButton,
   List,
   ListItemButton,
   ListItemIcon,
   ListItemSecondaryAction,
   ListItemText,
   Paper,
   TextField,
   Typography
} from '@mui/material';
import { useTheme } from '@mui/material/styles';

// project imports
import MainCard from 'components/ui-component/cards/MainCard';
import AnimateButton from 'components/ui-component/extended/AnimateButton';
import { useDispatch, useSelector } from 'store';
import { gridSpacing } from 'store/constant';
// assets
import { PlusOneOutlined, PostAdd } from '@mui/icons-material';
import AssignmentIndIcon from '@mui/icons-material/AssignmentInd';
import AttachmentTwoToneIcon from '@mui/icons-material/AttachmentTwoTone';
import LayersTwoToneIcon from '@mui/icons-material/LayersTwoTone';
import NavigateNextRoundedIcon from '@mui/icons-material/NavigateNextRounded';
import PeopleAltTwoToneIcon from '@mui/icons-material/PeopleAltTwoTone';
import RecentActorsTwoToneIcon from '@mui/icons-material/RecentActorsTwoTone';
import SubCard from 'components/ui-component/cards/SubCard';
import Layout from 'layout';
import { useRouter } from 'next/router';
import { useEffect } from 'react';
import { getAccountProfile, selectAccountProfile } from 'store/slices/account';

// assets
import { Chip } from '@mui/material';

// project imports

// assets
import MailTwoToneIcon from '@mui/icons-material/MailTwoTone';
import PhonelinkRingTwoToneIcon from '@mui/icons-material/PhonelinkRingTwoTone';
import PinDropTwoToneIcon from '@mui/icons-material/PinDropTwoTone';

const Avatar3 = '/assets/images/users/user-3.png';
// ==============================|| SOCIAL PROFILE - POST ||============================== //

const Profile = () => {
   const theme = useTheme();
   const dispatch = useDispatch();
   const router = useRouter();
   const { accountId } = router.query;
   const accountProfile = useSelector(selectAccountProfile);

   useEffect(() => {
      console.log(accountId);
      dispatch(getAccountProfile(accountId));
   }, [dispatch, accountId]);

   const sideAvatarSX = {
      borderRadius: '8px',
      width: 48,
      height: 48,
      fontSize: '1.5rem',
      display: 'inline-flex',
      alignItems: 'center',
      justifyContent: 'center',
      border: theme.palette.mode === 'dark' ? '1px solid' : 'none',
      '&>svg': {
         width: 24,
         height: 24
      }
   };

   return (
      <Grid container spacing={gridSpacing}>
         <Grid item xs={12} sm={12} md={4}>
            <Grid container spacing={gridSpacing}>
               <Grid item xs={12}>
                  <MainCard>
                     <Grid container alignItems="center" spacing={gridSpacing}>
                        <Grid item>
                           <Box
                              sx={{
                                 ...sideAvatarSX,
                                 bgcolor:
                                    theme.palette.mode === 'dark' ? theme.palette.primary.main + 20 : 'primary.light',
                                 border: theme.palette.mode === 'dark' ? '1px solid' : 'none',
                                 borderColor: 'primary.main',
                                 color: 'primary.dark'
                              }}
                           >
                              <PeopleAltTwoToneIcon />
                           </Box>
                        </Grid>
                        <Grid item xs zeroMinWidth>
                           <Typography variant="h3" color="primary" component="div" sx={{ mb: 0.625 }}>
                              {accountProfile?.posts?.length}
                           </Typography>
                           <Typography variant="body2">Posts</Typography>
                        </Grid>
                        <Grid item>
                           <IconButton size="large">
                              <NavigateNextRoundedIcon />
                           </IconButton>
                        </Grid>
                     </Grid>
                  </MainCard>
               </Grid>
               <Grid item xs={12}>
                  <SubCard
                     title={
                        <Grid container spacing={2} alignItems="center">
                           <Grid item>
                              <Avatar alt="User 1" src={accountProfile?.avatar} />
                           </Grid>
                           <Grid item xs zeroMinWidth>
                              <Typography align="left" variant="subtitle1">
                                 {accountProfile?.fullName}
                              </Typography>
                              <Typography align="left" variant="subtitle2">
                                 {accountProfile?.role === "Admin" ? "Admin" : accountProfile?.isDoctor ? "Doctor" : "Member"}
                              </Typography>
                           </Grid>
                           <Grid item>
                              <Chip size="small" label={`Is ${accountProfile?.role === "Admin" ? "Admin" : accountProfile?.isDoctor ? "Doctor" : "Member"}`} color="primary" />
                           </Grid>
                        </Grid>
                     }
                  >
                     <List component="nav" aria-label="main mailbox folders">
                        <ListItemButton>
                           <ListItemIcon>
                              <MailTwoToneIcon sx={{ fontSize: '1.3rem' }} />
                           </ListItemIcon>
                           <ListItemText primary={<Typography variant="subtitle1">Email</Typography>} />
                           <ListItemSecondaryAction>
                              <Typography variant="subtitle2" align="right">
                                 {accountProfile?.emailAddress}
                              </Typography>
                           </ListItemSecondaryAction>
                        </ListItemButton>
                        <Divider />
                        <ListItemButton>
                           <ListItemIcon>
                              <PhonelinkRingTwoToneIcon sx={{ fontSize: '1.3rem' }} />
                           </ListItemIcon>
                           <ListItemText primary={<Typography variant="subtitle1">Phone</Typography>} />
                           <ListItemSecondaryAction>
                              <Typography variant="subtitle2" align="right">
                                 {accountProfile?.phoneNumber}
                              </Typography>
                           </ListItemSecondaryAction>
                        </ListItemButton>
                        <Divider />
                        <ListItemButton>
                           <ListItemIcon>
                              <PinDropTwoToneIcon sx={{ fontSize: '1.3rem' }} />
                           </ListItemIcon>
                           <ListItemText primary={<Typography variant="subtitle1">Location</Typography>} />
                           <ListItemSecondaryAction>
                              <Typography variant="subtitle2" align="right">
                                 {accountProfile?.location?.streetAddress}
                              </Typography>
                              <Typography variant="subtitle2" align="right">
                                 {accountProfile?.location?.streetAddress2}
                              </Typography>
                              <Typography variant="subtitle2" align="right">
                                 {accountProfile?.location?.zipCode}
                              </Typography>
                           </ListItemSecondaryAction>
                        </ListItemButton>
                        <Divider />
                        <ListItemButton>
                           <ListItemIcon>
                              <PlusOneOutlined sx={{ fontSize: '1.3rem' }} />
                           </ListItemIcon>
                           <ListItemText primary={<Typography variant="subtitle1">Specialties</Typography>} />
                        </ListItemButton>
                        <ListItemButton>
                           {accountProfile?.specialtyDoctors?.map((item, index) => <ListItemText primary={<Typography variant="subtitle2">Spectialty {index + 1} - {item.specialty?.name}</Typography>} />)}
                        </ListItemButton>
                     </List>
                  </SubCard>
               </Grid>
               <Grid item xs={12}>
                  <MainCard>
                     <Grid container spacing={2}>
                        <Grid item xs={12}>
                           <Typography variant="h4">About Me</Typography>
                        </Grid>
                        <Grid item xs={12}>
                           <Typography variant="body2">
                              {accountProfile?.description ? accountProfile?.description : `Account No About Me`}
                           </Typography>
                        </Grid>
                     </Grid>
                     <Grid
                        container
                        spacing={2}
                        sx={{
                           '& >div': {
                              overflow: 'hidden',
                              textOverflow: 'ellipsis',
                              whiteSpace: 'nowrap',
                              display: 'block',
                              width: '100%'
                           },
                           '& a': {
                              color: theme.palette.grey[700],

                              '& svg': {
                                 mr: 1,
                                 verticalAlign: 'bottom'
                              },
                              '&:hover': {
                                 color: theme.palette.primary.main,
                                 textDecoration: 'none'
                              }
                           }
                        }}
                     ></Grid>
                  </MainCard>
               </Grid>
            </Grid>
         </Grid>
         <Grid item xs={12} sm={12} md={8}>
            <Paper style={{ maxHeight: `calc(100vh - 150px)`, overflow: 'auto' }}>
               <Grid container spacing={gridSpacing}>
                  <Grid item xs={12}>
                     <MainCard>
                        {accountProfile?.posts?.length === 0 ? (
                           <Typography variant="h3" align="center">
                              Account No Post
                           </Typography>
                        ) : (
                           <Grid container spacing={gridSpacing}>
                              {accountProfile?.posts?.map(item => (
                                 <Grid item xs={12}>
                                    <Card
                                       sx={{
                                          p: 2,
                                          background:
                                             theme.palette.mode === 'dark'
                                                ? theme.palette.dark.main
                                                : theme.palette.grey[50],
                                          border:
                                             theme.palette.mode === 'dark'
                                                ? '1px solid transparent'
                                                : `1px solid${theme.palette.grey[100]}`,
                                          '&:hover': {
                                             borderColor: theme.palette.primary.main
                                          }
                                       }}
                                    >
                                       <Grid container spacing={gridSpacing}>
                                          <Grid item xs={12}>
                                             <Typography variant="h3" component="div" mb={2}>
                                                {item?.title}
                                             </Typography>
                                             <Paper style={{ maxHeight: 200, overflow: 'auto' }}>
                                                <Typography
                                                   variant="subtitle2"
                                                   sx={{ color: theme.palette.grey[700], px: 2 }}
                                                   dangerouslySetInnerHTML={{ __html: item?.content }}
                                                />
                                             </Paper>
                                          </Grid>
                                          <Grid item xs={12}>
                                             <Grid container spacing={gridSpacing}>
                                                <Grid item xs={4}>
                                                   <Typography variant="caption">Email</Typography>
                                                   <Typography variant="h6">{accountProfile?.emailAddress}</Typography>
                                                </Grid>
                                                <Grid item xs={4}>
                                                   <Typography variant="caption">Phone</Typography>
                                                   <Typography variant="h6">{accountProfile?.phoneNumber}</Typography>
                                                </Grid>
                                                <Grid item xs={4}>
                                                   <Typography variant="caption">Created At</Typography>
                                                   <Typography variant="h6">{item?.created_at}</Typography>
                                                </Grid>
                                             </Grid>
                                          </Grid>
                                       </Grid>
                                    </Card>
                                 </Grid>
                              ))}
                           </Grid>
                        )}
                     </MainCard>
                  </Grid>
               </Grid>
            </Paper>
         </Grid>
      </Grid>
   );
};

Profile.getLayout = function getLayout(page) {
   return <Layout>{page}</Layout>;
};

export default Profile;
