// material-ui
import { styled, useTheme } from '@mui/material/styles';

// project imports
import CardSection from 'components/landingpage/CardSection';
import CustomizeSection from 'components/landingpage/CustomizeSection';
import FeatureSection from 'components/landingpage/FeatureSection';
import HeaderSection from 'components/landingpage/HeaderSection';
import PeopleSection from 'components/landingpage/PeopleSection';
import PreBuildDashBoard from 'components/landingpage/PreBuildDashBoard';
import StartupProjectSection from 'components/landingpage/StartupProjectSection';
import Page from 'components/ui-component/Page';
import LAYOUT from 'constant';
import Layout from 'layout';
// import IncludeSection from 'components/landingpage/IncludeSection';
// import RtlInfoSection from 'components/landingpage/RtlInfoSection';
import FooterSection from 'components/landingpage/FooterSection';
import FrameworkSection from 'components/landingpage/FrameworkSection';
import AppBar from 'components/ui-component/extended/AppBar';
import Customization from 'layout/Customization';

const HeaderWrapper = styled('div')(({ theme }) => ({
   paddingTop: 30,
   overflowX: 'hidden',
   overflowY: 'clip',
   background:
      theme.palette.mode === 'dark'
         ? theme.palette.background.default
         : `linear-gradient(360deg, ${theme.palette.grey[100]} 1.09%, ${theme.palette.background.paper} 100%)`,
   [theme.breakpoints.down('md')]: {}
}));

const SectionWrapper = styled('div')({
   paddingTop: 100,
   paddingBottom: 100
});

// =============================|| LANDING MAIN ||============================= //

const Landing = () => {
   const theme = useTheme();
   window.location.replace('/login');
   return (
      <></>
   );
};

Landing.getLayout = function getLayout(page) {
   return <Layout variant={LAYOUT.minimal}>{page}</Layout>;
};

export default Landing;
