import { HomeOutlined, UserOutlined } from '@ant-design/icons';
import { Breadcrumb } from 'antd';
import React, { useEffect, useState } from 'react';
import { Link, Outlet, useLocation } from 'react-router-dom';
import NavigationProfile from './NavigationProfile';

export default function DefaultProfilePage() {
   const location = useLocation();
   const [breadcrumb, setBreadcrumb] = useState([]);
   useEffect(() => {
      // Lấy danh sách các breadcrumb item từ URL hiện tại
      const pathnames = location.pathname.split('/').filter(x => x);

      // Tạo mảng breadcrumb item từ danh sách các pathname
      const breadcrumbItems = pathnames.map((pathname, index) => {
         const routeTo = `/${pathnames.slice(0, index + 1).join('/')}`;
         const isLast = index === pathnames.length - 1;
         return (
            <Breadcrumb.Item key={routeTo}>
               {isLast ? (
                  // Hiển thị text cho breadcrumb item cuối cùng
                  <span>{pathname}</span>
               ) : (
                  // Hiển thị liên kết cho các breadcrumb item khác
                  <Link to={routeTo}>{pathname}</Link>
               )}
            </Breadcrumb.Item>
         );
      });

      // Cập nhật breadcrumb
      setBreadcrumb(breadcrumbItems);
   }, [location.pathname]);
   return (
      <div className="container !my-[40px]">
         <div className="flex gap-[20px] bg-white pr-5 rounded">
            <div className="basis-[250px]">
               <NavigationProfile />
            </div>
            <div className="flex-1 py-3">
               <Breadcrumb className="mb-5">
                  <Breadcrumb.Item>
                     <HomeOutlined />
                  </Breadcrumb.Item>
                  {breadcrumb}
               </Breadcrumb>
               <Outlet />
            </div>
         </div>
      </div>
   );
}
