import { createSlice } from '@reduxjs/toolkit';

const initialState = {
   loading: false,
   isAuthenticated: false,
   user: null,
   profile: null,
   usersOnline: [],
   usersFound: [],
   error: null
};

const authSlice = createSlice({
   name: 'auth',
   initialState,
   reducers: {
      clearError: state => {
         state.error = null;
      },
      setUserFoundSuccess: (state, action) => {
         state.usersFound = action.payload;
      },
      setUserOnline: (state, action) => {
         state.usersOnline = action.payload;
      },
      pushUserOnline: (state, action) => {
         state.usersOnline.push(action.payload);
      },
      deleteUserOnline: (state, action) => {
         const userIndex = state.usersOnline.findIndex(item => item.id === action.payload.id);
         state.usersOnline.splice(userIndex, 1);
      },
      saveProfileStart: () => {},
      saveProfileSuccess: (state, action) => {
         state.user = action.payload;
         state.error = null;
      },
      getProfileStart: () => {},
      getProfileSuccess: (state, action) => {
         state.profile = action.payload;
         state.error = null;
      },
      saveProfileFailed: (state, action) => {
         state.error = action.payload;
      },
      changePasswordStart: () => {},
      changePasswordSuccess: (state, action) => {
         state.error = null;
      },
      changePasswordFailed: (state, action) => {
         state.error = action.payload;
      },
      loginStart: state => {
         state.loading = true;
         state.error = null;
      },
      loginSuccess: (state, action) => {
         state.loading = false;
         state.isAuthenticated = true;
         state.user = action.payload;
         state.error = null;
      },
      loginFail: (state, action) => {
         state.loading = false;
         state.error = action.payload;
      },
      logout: state => {
         state.loading = false;
         state.isAuthenticated = false;
         state.user = null;
         state.error = null;
      },
      forgotPasswordStart: state => {
         state.loading = true;
         state.error = null;
      },
      forgotPasswordSuccess: state => {
         state.loading = false;
      },
      forgotPasswordFail: (state, action) => {
         state.loading = false;
         state.error = action.payload;
      },
      createUserStart: state => {
         state.loading = true;
         state.error = null;
      },
      createUserSuccess: (state, action) => {
         state.loading = false;
         state.user = action.payload;
      },
      createUserFail: (state, action) => {
         state.loading = false;
         state.error = action.payload;
      }
   }
});

export const {
   clearError,
   setUserFoundSuccess,
   setUserOnline,
   pushUserOnline,
   deleteUserOnline,
   tokenCheck,
   tokenCheckExists,
   tokenCheckNotExists,
   saveProfileStart,
   saveProfileSuccess,
   saveProfileFailed,
   getProfileStart,
   getProfileSuccess,
   loginStart,
   loginSuccess,
   loginFail,
   logout,
   forgotPasswordStart,
   forgotPasswordSuccess,
   forgotPasswordFail,
   createUserStart,
   createUserSuccess,
   createUserFail,
   changePasswordStart,
   changePasswordSuccess,
   changePasswordFailed
} = authSlice.actions;

export const selectErrorsAuth = state => state.auth.error;
export const selectIsAuthenticatedAuth = state => state.auth.isAuthenticated;
export const selectUserAuth = state => state.auth.user;
export const selectUsersOnlineAuth = state => state.auth.usersOnline;
export const selectProfile = state => state.auth.profile;
export const selectUsersFound = state => state.auth.usersFound;
export const selectLoadingAuth = state => state.auth.loading;

export default authSlice.reducer;
