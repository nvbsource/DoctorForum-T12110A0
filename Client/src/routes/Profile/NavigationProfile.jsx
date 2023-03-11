import { SettingOutlined } from '@ant-design/icons';
import { Menu } from 'antd';
import React from 'react';
import { useSelector } from 'react-redux';
import { useLocation, useNavigate } from 'react-router-dom';
import { selectUserAuth } from '../../app/features/auth/authSlice';

const NavigationProfile = () => {
   const navigate = useNavigate();
   const location = useLocation();
   const userLogin = useSelector(selectUserAuth);

   const menuItems = [
      {
         key: 'settings',
         icon: React.createElement(SettingOutlined),
         label: 'Settings',
         children: [
            {
               key: 'personal-information',
               label: 'Personal Information',
               path: '/profile/settings/personal-information'
            },
            {
               key: 'security-settings',
               label: 'Security Settings',
               path: '/profile/settings/security-settings'
            }
         ]
      },
      {
         isDoctor: true,
         key: 'services',
         icon: React.createElement(SettingOutlined),
         label: 'Services',
         children: [
            {
               key: 'appointment',
               label: 'Appointment',
               path: '/profile/services/appointment'
            },
            {
               key: 'appointment-management',
               label: 'Appointment Management',
               path: '/profile/services/appointment-management'
            },
            {
               key: 'specialty-management',
               label: 'Specialty Management',
               path: '/profile/services/specialty-management'
            }
         ]
      }
   ];

   const handleNavigate = data => {
      const childrens = menuItems.find(parent => parent.key === data.keyPath[1])?.children;
      const path = childrens.find(child => child.key === data.key)?.path;
      if (path) navigate(path);
   };

   const defaultSelectKeys = menuItems.reduce((acc, curr) => {
      const isOpen = curr.children?.find(child => location.pathname === child.path);
      if (isOpen) {
         acc.push(isOpen.key);
      }
      return acc;
   }, []);

   const defaultOpenKeys = menuItems.reduce((acc, curr) => {
      const isOpen = location.pathname.includes(curr.key);
      if (isOpen) {
         acc.push(curr.key);
      }
      return acc;
   }, []);

   return (
      <Menu
         selectedKeys={defaultSelectKeys}
         defaultOpenKeys={defaultOpenKeys}
         mode="inline"
         items={userLogin?.isDoctor ? menuItems : menuItems.filter(item => !item.isDoctor)}
         onClick={handleNavigate}
         className="h-full bg-[#009962] text-white menu-customize"
      ></Menu>
   );
};

export default NavigationProfile;
