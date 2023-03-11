import { useEffect, useState } from 'react';

// material-ui
import { Grid } from '@mui/material';

// project imports
import Layout from 'layout';
import Page from 'components/ui-component/Page';
import EarningCard from '../../components/dashboard/Default/EarningCard';
import PopularCard from '../../components/dashboard/Default/PopularCard';
import TotalOrderLineChartCard from '../../components/dashboard/Default/TotalOrderLineChartCard';
import TotalIncomeDarkCard from '../../components/dashboard/Default/TotalIncomeDarkCard';
import TotalIncomeLightCard from '../../components/dashboard/Default/TotalIncomeLightCard';
import TotalGrowthBarChart from '../../components/dashboard/Default/TotalGrowthBarChart';
import { gridSpacing } from '../../store/constant';
import axiosServices from 'utils/axios';

// ==============================|| DEFAULT DASHBOARD ||============================== //

const Dashboard = () => {
   const [isLoading, setLoading] = useState(true);
   const [statistics, setStatistics] = useState({});
   useEffect(() => {
      setLoading(false);
      handleGetStatistics();
   }, []);
   const handleGetStatistics = async () => {
      try {
         const { data } = await axiosServices.get("/admin/User/statistics");
         if(data.code === 200){
            setStatistics(data.result)
         }
      } catch (error) {

      }
   }

   return (
      <Page title="Default Dashboard">
         <Grid container spacing={gridSpacing}>
            <Grid item xs={12}>
               <Grid container spacing={gridSpacing}>
                  <Grid item lg={4} md={6} sm={6} xs={12}>
                     <EarningCard isLoading={isLoading} total={statistics.posts || 0} name="Posts" />
                  </Grid>
                  <Grid item lg={4} md={6} sm={6} xs={12}>
                     <EarningCard isLoading={isLoading} total={statistics.appointments || 0} name="Appointments" />
                  </Grid>
                  <Grid item lg={4} md={12} sm={12} xs={12}>
                     <Grid container spacing={gridSpacing}>
                        <Grid item sm={6} xs={12} md={6} lg={12}>
                           <TotalIncomeDarkCard isLoading={isLoading} total={statistics.topics || 0} name="Topics"/>
                        </Grid>
                        <Grid item sm={6} xs={12} md={6} lg={12}>
                           <TotalIncomeLightCard isLoading={isLoading} total={statistics.users || 0} name="Users"/>
                        </Grid>
                     </Grid>
                  </Grid>
               </Grid>
            </Grid>
            <Grid item xs={12}>
               <Grid container spacing={gridSpacing}>
                  <Grid item lg={4} md={6} sm={6} xs={12}>
                     <EarningCard isLoading={isLoading} total={statistics.postsToday || 0} name="Posts Today" />
                  </Grid>
                  <Grid item lg={4} md={6} sm={6} xs={12}>
                     <EarningCard isLoading={isLoading} total={statistics.appointmentsToday || 0} name="Appointments Today" />
                  </Grid>
                  <Grid item lg={4} md={12} sm={12} xs={12}>
                     <Grid container spacing={gridSpacing}>
                        <Grid item sm={6} xs={12} md={6} lg={12}>
                           <TotalIncomeDarkCard isLoading={isLoading} total={statistics.topicsToday || 0} name="Topics Today"/>
                        </Grid>
                        <Grid item sm={6} xs={12} md={6} lg={12}>
                           <TotalIncomeLightCard isLoading={isLoading} total={statistics.usersToday || 0} name="Users Today"/>
                        </Grid>
                     </Grid>
                  </Grid>
               </Grid>
            </Grid>
         </Grid>
      </Page>
   );
};

Dashboard.getLayout = function getLayout(page) {
   return <Layout>{page}</Layout>;
};

export default Dashboard;
