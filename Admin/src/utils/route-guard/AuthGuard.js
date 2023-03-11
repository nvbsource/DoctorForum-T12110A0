import PropTypes from 'prop-types';
import { useEffect } from 'react';
import { useRouter } from 'next/router';

// project imports
import useAuth from 'hooks/useAuth';
import Loader from 'components/ui-component/Loader';

// ==============================|| AUTH GUARD ||============================== //

/**
 * Authentication guard for routes
 * @param {PropTypes.node} children children element/node
 */
const AuthGuard = ({ children }) => {
   const { isLoggedIn } = useAuth();
   const serviceToken = window.localStorage.getItem('serviceToken');
   const router = useRouter();
   useEffect(() => {
      if (!isLoggedIn && !serviceToken) {
         router.push('/login');
      }
      // eslint-disable-next-line
   }, [isLoggedIn, serviceToken]);

   if (!isLoggedIn) return <Loader />;

   return children;
};

AuthGuard.propTypes = {
   children: PropTypes.node
};

export default AuthGuard;
