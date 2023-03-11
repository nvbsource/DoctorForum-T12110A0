import React from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Link } from 'react-router-dom';
import { selectIsAuthenticatedAuth } from '../app/features/auth/authSlice';
import { images } from '../assets';
import HeaderIsAuthenticated from './HeaderIsAuthenticated';
import HeaderNotAuthenticated from './HeaderNotAuthenticated';

const Header = () => {
   const dispatch = useDispatch();
   const isAuthenticated = useSelector(selectIsAuthenticatedAuth);
   const Authentication = !isAuthenticated ? HeaderNotAuthenticated : HeaderIsAuthenticated;
   return (
      <>
         <div className="w-full text-center py-3 bg-[#009962] text-[#FFFFFF]">
            READ THE PRESS RELEASE: Press Ganey Has Acquired
         </div>
         <div className="bg-white py-3">
            <div className="container">
               <div className="w-full justify-between items-center flex">
                  <div className="flex-1">
                     <div className="w-[177px]">
                        <Link to="/">
                           <img src={images.logo} className="w-full h-full object-cover" />
                        </Link>
                     </div>
                  </div>
                  <Authentication />
                  <div className="flex-1"></div>
               </div>
            </div>
         </div>
      </>
   );
};

export default Header;
