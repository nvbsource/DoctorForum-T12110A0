import { useEffect } from 'react';
import { useDispatch } from 'react-redux';
import { useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';
import { logout } from '../app/features/auth/authSlice';

function PrivateRoute({ children }) {
   const access_token = localStorage.getItem('access_token');
   const dispatch = useDispatch();
   const navigate = useNavigate();

   useEffect(() => {
      if (!access_token) {
         toast('You need to log in', { type: 'error', autoClose: 2000 });
         dispatch(logout());
         navigate('/signin');
      }
   }, [dispatch]);

   return access_token ? children : null;
}

export default PrivateRoute;
