// material-ui
import { PostAdd } from '@mui/icons-material';
import { Avatar, Button, Card, CircularProgress, Grid, Paper, Typography } from '@mui/material';

// project imports
import AssignmentIndIcon from '@mui/icons-material/AssignmentInd';
import { useTheme } from '@mui/material/styles';
import SecondaryAction from 'components/ui-component/cards/CardSecondaryAction';
import MainCard from 'components/ui-component/cards/MainCard';
import Page from 'components/ui-component/Page';
import Layout from 'layout';
import { useEffect } from 'react';
import { useDispatch, useSelector } from 'store';
import { gridSpacing } from 'store/constant';
import Link from 'next/link';
import { getPosts, selectPosts } from 'store/slices/post';
function TopicList() {
   const theme = useTheme();
   const dispatch = useDispatch();
   const posts = useSelector(selectPosts);

   useEffect(() => {
      dispatch(getPosts());
   }, [dispatch]);
   return (
      <Page title="List Topic">
         <MainCard title="List" secondary={<SecondaryAction link="https://next.material-ui.com/components/lists/" />}>
            {posts.length === 0 ? (
               <Grid container spacing={gridSpacing} justifyContent="center" alignItems="center">
                  <Grid item>No posts found</Grid>
                  <Grid item>
                     <CircularProgress color="secondary" />
                  </Grid>
               </Grid>
            ) : (
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
                                 <Typography variant="h3" component="div">
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
            )}
         </MainCard>
      </Page>
   );
}
TopicList.getLayout = function getLayout(page) {
   return <Layout>{page}</Layout>;
};
export default TopicList;
