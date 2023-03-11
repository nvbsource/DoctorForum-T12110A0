// third-party
import { createSlice } from '@reduxjs/toolkit';

// project imports
import { dispatch } from '../index';
import axios from 'utils/axios';

// initial state
const initialState = {
   selectedItem: ['dashboard'],
   selectedID: null,
   drawerOpen: false,
   error: null,
   menuDashboard: {}
};

// ==============================|| SLICE - MENU ||============================== //

const menu = createSlice({
   name: 'menu',
   initialState,
   reducers: {
      activeItem(state, action) {
         state.selectedItem = action.payload;
      },

      activeID(state, action) {
         state.selectedID = action.payload;
      },

      openDrawer(state, action) {
         state.drawerOpen = action.payload;
      },

      // has error
      hasError(state, action) {
         state.error = action.payload;
      }
   }
});

export default menu.reducer;

export const { activeItem, openDrawer, activeID } = menu.actions;
