import { LogoutOutlined, MessageOutlined, UserOutlined } from '@ant-design/icons';
import { Avatar, Badge, Space } from 'antd';
import React, { useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useNavigate } from 'react-router';
import { Link } from 'react-router-dom';
import { toast } from 'react-toastify';
import { logout, selectUserAuth } from '../app/features/auth/authSlice';
import connection from '../app/HubConnection/hubConnection';
import Notifications from './Notifications';

export default function HeaderIsAuthenticated() {
   const user = useSelector(selectUserAuth) || {};
   const [visible, setVisible] = useState(false);

   const handleVisibleChange = visible => {
      setVisible(visible);
   };
   const dispatch = useDispatch();
   const navigate = useNavigate();
   const handleLogout = () => {
      localStorage.clear('access_token');
      connection.stop();
      dispatch(logout());
      navigate('/signin');
      toast('Logout successfully', { type: 'success', autoClose: 2000 });
   };
   return (
      <div className="flex items-center flex-1 justify-center">
         <Space size={24}>
            <Avatar
               shape="circle"
               icon={<LogoutOutlined />}
               onClick={handleLogout}
               className="cursor-pointer bg-[#009962] h-[40px] w-[40px] flex items-center justify-center"
            />
            {/* <Notifications handleVisibleChange={handleVisibleChange} visible={visible} /> */}
            <Link to="/messages">
               <Avatar
                  shape="circle"
                  icon={<MessageOutlined />}
                  className="cursor-pointer bg-[#009962] h-[40px] w-[40px] flex items-center justify-center"
               />
            </Link>
            <Link to="/profile">
               <Avatar
                  shape="circle"
                  icon={<UserOutlined />}
                  className="cursor-pointer bg-[#009962] h-[40px] w-[40px] flex items-center justify-center"
               />
            </Link>
         </Space>
      </div>
   );
}
