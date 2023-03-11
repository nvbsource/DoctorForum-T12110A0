import { HeartFilled, SketchCircleFilled, UserOutlined } from '@ant-design/icons';
import React from 'react';

export default function Avatar({ url, role, className }) {
   return (
      <div className="relative">
         <img src={url} alt="" className={`${className ? className : 'w-[40px] h-[40px]'} rounded-full`} />
         {role === 'Admin' && <SketchCircleFilled className="absolute left-[-5px] bottom-0 text-[#0184ff]" />}
         {role === 'Doctor' && <HeartFilled className="absolute left-[-5px] bottom-0 text-[#c11b05]" />}
      </div>
   );
}
