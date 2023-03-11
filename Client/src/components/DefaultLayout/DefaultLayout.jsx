import { Alert } from 'antd';
import React from 'react';
import { useSelector } from 'react-redux';
import { Outlet } from 'react-router-dom';
import { selectUserAuth } from '../../app/features/auth/authSlice';
import Footer from '../Footer';
import Header from '../Header';

export default function DefaultLayout({ children }) {
   const userLogin = useSelector(selectUserAuth);
   return (
      <div className="w-full">
         <Header />
         <div className="container">
            {userLogin?.isDoctor && !userLogin?.location?.streetAddress && (
               <Alert
                  message="Warning"
                  description="You need to configure the address information so that the patient can find you"
                  type="warning"
                  showIcon
                  closable
                  className="mt-3"
               />
            )}
         </div>
         <div className="relative">
            <div className="_maskSearch hidden bg-[#00000080] absolute h-full w-full z-50" />
            <div className="flex justify-center  z-1">
               <div className="w-full sm:w-full ">{children}</div>
            </div>
            <Footer></Footer>
         </div>
      </div>
   );
}
