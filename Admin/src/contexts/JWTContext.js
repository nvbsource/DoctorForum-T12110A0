import PropTypes from 'prop-types';
import { createContext, useEffect } from 'react';

// third-party
import jwtDecode from 'jwt-decode';

// project imports
import { useDispatch } from 'store';
import { loginSlice, logoutSlice, selectAuth } from 'store/slices/auth';
import { default as axios } from 'utils/axios';
import { useSelector } from 'store';
import { openSnackbar } from 'store/slices/snackbar';

const verifyToken = serviceToken => {
   if (!serviceToken) {
      return false;
   }
   const decoded = jwtDecode(serviceToken);

   return decoded.exp > Date.now() / 1000;
};

const setSession = serviceToken => {
   if (serviceToken) {
      localStorage.setItem('serviceToken', serviceToken);
      axios.defaults.headers.common.Authorization = `Bearer ${serviceToken}`;
   } else {
      localStorage.removeItem('serviceToken');
      delete axios.defaults.headers.common.Authorization;
   }
};

// ==============================|| JWT CONTEXT & PROVIDER ||============================== //
const JWTContext = createContext(null);

export const JWTProvider = ({ children }) => {
   const dispatch = useDispatch();
   const user = useSelector(selectAuth);
   useEffect(() => {
      const init = async () => {
         try {
            const serviceToken = window.localStorage.getItem('serviceToken');
            if (serviceToken && verifyToken(serviceToken)) {
               setSession(serviceToken);

               const { data } = await axios.get('/User/profile');

               if (data.code !== 200) {
                  return;
               }

               dispatch(loginSlice(data.result));
            } else {
               dispatch(logoutSlice());
            }
         } catch (err) {
            console.error(err);
            setSession();
            dispatch(logoutSlice());
         }
      };

      init();
   }, []);

   const login = async (username, password) => {
      try {
         const { data } = await axios.post('/admin/User/login', { username, password });
         if (data.code === 200) {
            setSession(data.result.token);
            dispatch(loginSlice(data.user));
            dispatch(
               openSnackbar({
                  open: true,
                  message: data?.message,
                  variant: 'alert',
                  alert: {
                     color: 'success'
                  },
                  close: false
               })
            );
         }else{
            dispatch(
               openSnackbar({
                  open: true,
                  message: data?.message,
                  variant: 'alert',
                  alert: {
                     color: 'error'
                  },
                  close: false
               })
            );
         }
      } catch (error) {
         dispatch(
            openSnackbar({
               open: true,
               message: error?.message,
               variant: 'alert',
               alert: {
                  color: 'error'
               },
               close: false
            })
         );
      }
   };

   const logout = () => {
      setSession(null);
      dispatch(logoutSlice());
   };

   return <JWTContext.Provider value={{ ...user, login, logout }}>{children}</JWTContext.Provider>;
};

JWTProvider.propTypes = {
   children: PropTypes.node
};

export default JWTContext;
