// material-ui
import { Grid } from '@mui/material';
import PostShowList from 'components/Post/PostShowList';
import TopicShowList from 'components/Topic/TopicShowList';

// project imports
import SecondaryAction from 'components/ui-component/cards/CardSecondaryAction';
import MainCard from 'components/ui-component/cards/MainCard';
import SubCard from 'components/ui-component/cards/SubCard';
import Page from 'components/ui-component/Page';
import Layout from 'layout';
import { useState } from 'react';
import { useEffect } from 'react';
import { useDispatch, useSelector } from 'store';
import { gridSpacing } from 'store/constant';
import { getTopicList, selectTopics } from 'store/slices/topic';
function TopicList() {
   const dispatch = useDispatch();
   const topics = useSelector(selectTopics);
   const [selectedTopic, setSelectedTopic] = useState({});

   useEffect(() => {
      dispatch(getTopicList());
   }, [dispatch]);
   return (
      <Page title="List Topic">
         <MainCard title="List" secondary={<SecondaryAction link="https://next.material-ui.com/components/lists/" />}>
            <Grid container spacing={gridSpacing}>
               <Grid item xs={12} sm={6}>
                  <Grid container spacing={gridSpacing}>
                     {topics.map(item => (
                        <Grid item key={item.id} xs={12}>
                           <SubCard title={item.title}>
                              <TopicShowList list={item.subTopics} setSelectedTopic={setSelectedTopic} />
                           </SubCard>
                        </Grid>
                     ))}
                  </Grid>
               </Grid>
               <Grid item xs={12} sm={6}>
                  <SubCard title={`Post Of Topic Selected - ${selectedTopic.title || 'No topic selected yet'}`}>
                     <PostShowList />
                  </SubCard>
               </Grid>
            </Grid>
         </MainCard>
      </Page>
   );
}
TopicList.getLayout = function getLayout(page) {
   return <Layout>{page}</Layout>;
};
export default TopicList;
