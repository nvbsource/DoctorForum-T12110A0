import React from 'react';
import { Outlet } from 'react-router-dom';
import Header from '../Header';

export default function DefaultOnlyHeader({ children }) {
   return (
      <div className="w-full">
         <Header />
         <div className="relative">
            <div className="_maskSearch hidden bg-[#00000080] absolute h-full w-full z-50" />
            <div className="flex justify-center  z-1">
               <div className="w-full sm:w-full ">{children}</div>
            </div>
         </div>
      </div>
   );
}
