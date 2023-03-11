// third-party
import { createSlice } from '@reduxjs/toolkit';
import { dispatch } from 'store';
import axiosServices from 'utils/axios';

// ----------------------------------------------------------------------

const initialState = {
   error: null,
   topics: [],
   posts: []
};

const slice = createSlice({
   name: 'auth',
   initialState,
   reducers: {
      hasError(state, action) {
         state.error = action.payload;
      },
      getTopicSuccess(state, action) {
         state.topics = action.payload;
      },
      getPostOfTopicSuccess(state, action) {
         state.posts = action.payload;
      }
   }
});

export const { getTopicSuccess, hasError, getPostOfTopicSuccess } = slice.actions;
export const selectTopics = state => state.topic.topics;
export const selectPostOfTopic = state => state.topic.posts;
// Reducer
export default slice.reducer;

// ----------------------------------------------------------------------

export function getTopicList() {
   return async () => {
      try {
         const response = await axiosServices.get('/Topic');
         dispatch(getTopicSuccess(response.data.result));
      } catch (error) {
         dispatch(hasError(error));
      }
   };
}

export function getPostOfTopic(topicId) {
   return async () => {
      try {
         const response = await axiosServices.get(`/admin/Post/postOfTopic/${topicId}`);
         dispatch(getPostOfTopicSuccess(response.data.result));
      } catch (error) {
         dispatch(hasError(error));
      }
   };
}
