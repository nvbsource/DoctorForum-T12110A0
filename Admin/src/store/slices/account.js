// third-party
import { createSlice } from '@reduxjs/toolkit';
import { dispatch } from 'store';
import axiosServices from 'utils/axios';

// ----------------------------------------------------------------------

const initialState = {
   users: [],
   userProfile: {}
};

const slice = createSlice({
   name: 'auth',
   initialState,
   reducers: {
      hasError(state, action) {
         state.error = action.payload;
      },
      getAccountSuccess(state, action) {
         state.users = action.payload;
      },
      getAccountProfileSuccess(state, action) {
         state.userProfile = action.payload;
      }
   }
});

export const { getAccountSuccess, getAccountProfileSuccess, hasError } = slice.actions;
export const selectAccounts = state => state.account.users;
export const selectAccountProfile = state => state.account.userProfile;
// Reducer
export default slice.reducer;

// ----------------------------------------------------------------------

export function getAccountList() {
   return async () => {
      try {
         const response = await axiosServices.get('/admin/User');
         dispatch(getAccountSuccess(response.data.result));
      } catch (error) {
         dispatch(hasError(error));
      }
   };
}
export function getAccountProfile(userId) {
   return async () => {
      try {
         const response = await axiosServices.get(`/admin/User/profile/${userId}`);
         dispatch(getAccountProfileSuccess(response.data.result));
      } catch (error) {
         dispatch(hasError(error));
      }
   };
}
