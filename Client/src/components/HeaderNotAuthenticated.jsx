import React from 'react';
import { Link } from 'react-router-dom';

export default function HeaderNotAuthenticated() {
   return (
      <div className="flex items-center">
         <span className="mr-[30px]">
            <Link to="/signin">SIGN IN</Link>
         </span>
      </div>
   );
}
