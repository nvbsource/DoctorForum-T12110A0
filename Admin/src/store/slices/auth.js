// third-party
import { createSlice } from '@reduxjs/toolkit';

// ----------------------------------------------------------------------

const initialState = {
   isLoggedIn: false,
   isInitialized: false,
   user: null
};

const slice = createSlice({
   name: 'auth',
   initialState,
   reducers: {
      login(state, action) {
         state.isLoggedIn = true;
         state.isInitialized = true;
         state.user = action.payload;
      },
      logout(state, action) {
         state.isLoggedIn = false;
         state.isInitialized = true;
         state.error = action.payload;
      }
   }
});
export const { login: loginSlice, logout: logoutSlice } = slice.actions;
export const selectAuth = state => state.auth;
// Reducer
export default slice.reducer;

// ----------------------------------------------------------------------
