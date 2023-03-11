// material-ui
import { Button, Card, CircularProgress, Grid, List, Paper, Typography } from '@mui/material';

// assets
import { PostAdd } from '@mui/icons-material';
import AssignmentIndIcon from '@mui/icons-material/AssignmentInd';
import { useTheme } from '@mui/material/styles';
import Avatar from 'components/ui-component/extended/Avatar';
import { useSelector } from 'store';
import { gridSpacing } from 'store/constant';
import { selectPostOfTopic } from 'store/slices/topic';
import Link from 'next/link';
// ================================|| UI LIST - SIMPLE LIST ||================================ //

export default function PostShowList() {
   const theme = useTheme();
   const posts = useSelector(selectPostOfTopic);
   console.log(posts.length);
   return (
      <List component="nav" aria-label="main mailbox folders">
         {posts.length === 0 ? (
            <Grid container spacing={gridSpacing} justifyContent="center" alignItems="center">
               <Grid item>No posts found</Grid>
               <Grid item>
                  <CircularProgress color="secondary" />
               </Grid>
            </Grid>
         ) : (
            <Paper style={{ maxHeight: '100vh', overflow: 'auto' }}>
               <Grid container spacing={gridSpacing}>
                  {posts.map(item => (
                     <Grid item xs={12}>
                        <Card
                           sx={{
                              p: 2,
                              background:
                                 theme.palette.mode === 'dark' ? theme.palette.dark.main : theme.palette.grey[50],
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
                                 <Grid container spacing={gridSpacing} alignItems="center">
                                    <Grid item>
                                       <Grid container spacing={gridSpacing}>
                                          <Grid item xs zeroMinWidth>
                                             <Avatar alt="nvb" size="lg" src={item?.user?.avatar} />
                                          </Grid>
                                       </Grid>
                                    </Grid>
                                    <Grid item>
                                       <Typography variant="h3" component="div">
                                          {item?.user?.fullName}
                                       </Typography>
                                       <Typography variant="caption">{item?.user?.role}</Typography>
                                    </Grid>
                                 </Grid>
                              </Grid>
                              <Grid item xs={12}>
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
                                       <Typography variant="h6">{item?.user?.emailAddress}</Typography>
                                    </Grid>
                                    <Grid item xs={4}>
                                       <Typography variant="caption">Phone</Typography>
                                       <Typography variant="h6">{item?.user?.phoneNumber}</Typography>
                                    </Grid>
                                    <Grid item xs={4}>
                                       <Typography variant="caption">Created At</Typography>
                                       <Typography variant="h6">{item?.created_at}</Typography>
                                    </Grid>
                                 </Grid>
                              </Grid>
                              <Grid item xs={12}>
                                 <Link href={`/account/profile/${item?.user?.id}`}>
                                    <Button variant="outlined" fullWidth startIcon={<AssignmentIndIcon />}>
                                       Profile
                                    </Button>
                                 </Link>
                              </Grid>
                           </Grid>
                        </Card>
                     </Grid>
                  ))}
               </Grid>
            </Paper>
         )}
      </List>
   );
}
