import { createSlice } from '@reduxjs/toolkit';

const initialState = {
   loading: false,
   topics: [],
   topicsGroup: []
};

const topicSlice = createSlice({
   name: 'topic',
   initialState,
   reducers: {
      getTopicStart: state => {
         state.loading = true;
      },
      getTopicSuccess: (state, action) => {
         state.topics = action.payload;
         state.loading = false;
      },
      getTopicFailed: state => {
         state.loading = false;
      },
      getTopicsOfParentStart: () => {},
      getTopicsOfParentSuccess: (state, action) => {
         state.topicsGroup = action.payload;
      }
   }
});

export const {
   getTopicStart,
   getTopicSuccess,
   getTopicFailed,
   getTopicGroup,
   getTopicsOfParentStart,
   getTopicsOfParentSuccess
} = topicSlice.actions;
export const selectAllTopics = state => state.topic.topics;
export const selectAllTopicsOfParent = state => state.topic.topicsGroup;
export default topicSlice.reducer;
