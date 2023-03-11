import { createSlice } from '@reduxjs/toolkit';

const initialState = {
   loading: false,
   postDetail: [],
   posts: [],
   postsOfTopic: [],
   postNews: [],
   comments: []
};

const postSlice = createSlice({
   name: 'post',
   initialState,
   reducers: {
      createPostStart: state => {
         state.loading = true;
      },
      createPostSuccess: (state, action) => {
         state.posts = action.payload;
         state.loading = false;
      },
      createPostFailed: state => {
         state.loading = false;
      },
      editPostStart: () => {},
      editPostSuccess: (state, action) => {
         state.posts = action.payload;
         state.loading = false;
      },
      getDetailPostStart: () => {},
      getDetailPostSuccess: (state, action) => {
         state.postDetail = action.payload;
         state.comments = action.payload?.comments;
         state.loading = false;
      },
      getPostsStart: () => {},
      getPostsSuccess: (state, action) => {
         state.posts = action.payload;
         state.loading = false;
      },
      getPostsOfTopicStart: () => {},
      getPostsOfTopicSuccess: (state, action) => {
         state.postsOfTopic = action.payload;
         state.loading = false;
      },
      getNewPostsStart: () => {},
      getNewPostsSuccess: (state, action) => {
         state.postNews = action.payload;
         state.loading = false;
      }
   }
});

export const {
   getDetailPostStart,
   getDetailPostSuccess,
   createPostStart,
   createPostSuccess,
   editPostStart,
   editPostSuccess,
   getPostsOfTopicStart,
   getPostsOfTopicSuccess,
   getPostsStart,
   getPostsSuccess,
   getNewPostsStart,
   getNewPostsSuccess,
   createPostFailed
} = postSlice.actions;
export const selectPostNews = state => state.post.postNews;
export const selectPostOfTopic = state => state.post.postsOfTopic;
export const selectPostDetail = state => state.post.postDetail;
export const selectPostDetailComments = state => state.post.comments;
export const selectPostLoading = state => state.post.loading;
export default postSlice.reducer;
