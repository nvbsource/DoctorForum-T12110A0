// third-party
import { createSlice } from '@reduxjs/toolkit';
import { dispatch } from 'store';
import axiosServices from 'utils/axios';

// ----------------------------------------------------------------------

const initialState = {
   error: null,
   posts: []
};

const slice = createSlice({
   name: 'post',
   initialState,
   reducers: {
      hasError(state, action) {
         state.error = action.payload;
      },
      getPostSuccess(state, action) {
         state.posts = action.payload;
      }
   }
});

export const { hasError, getPostSuccess } = slice.actions;
export const selectPosts = state => state.post.posts;
// Reducer
export default slice.reducer;

// ----------------------------------------------------------------------

export function getPosts() {
   return async () => {
      try {
         const response = await axiosServices.get('/admin/Post');
         dispatch(getPostSuccess(response.data.result));
      } catch (error) {
         dispatch(hasError(error));
      }
   };
}
