import { useEffect } from 'react';
import { useDispatch } from 'react-redux';
import { useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';
import { logout } from '../app/features/auth/authSlice';

function AuthenticateRoute({ children }) {
   const dispatch = useDispatch();
   const navigate = useNavigate();

   useEffect(() => {
      const access_token = localStorage.getItem('access_token');
      if (access_token) {
         toast('You need to logout to access this page', { type: 'error', autoClose: 2000 });
         navigate('/');
      } else {
         dispatch(logout());
      }
   }, [dispatch]);

   return children;
}

export default AuthenticateRoute;
