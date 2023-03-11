import { CheckOutlined, DownloadOutlined } from '@ant-design/icons';
import { Button, Col, Form, Input, Row, Switch } from 'antd';
import React, { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { toast } from 'react-toastify';
import {
   changePasswordStart,
   clearError,
   selectErrorsAuth,
   selectUserAuth
} from '../../../app/features/auth/authSlice';
import appointmentResonService from '../../../services/appointmentService';

export default function SecuritySettings() {
   const errors = useSelector(selectErrorsAuth);
   const dispatch = useDispatch();
   const [showonline, setShowOnline] = useState(false);
   const [isAnonymouse, setIsAnonymouse] = useState(false);
   const userLogin = useSelector(selectUserAuth);
   useEffect(() => {
      dispatch(clearError());
   }, [dispatch]);

   useEffect(() => {
      setShowOnline(userLogin?.isViewOnline);
      setIsAnonymouse(userLogin?.isAnonymouse);
   }, [userLogin]);

   const handleSubmit = values => {
      dispatch(changePasswordStart(values));
   };
   const handleChangeShowOnline = async value => {
      try {
         const { data } = await appointmentResonService.updateStateAppointment({
            isViewOnline: value
         });
         if (data?.code === 200) {
            setShowOnline(value);
            toast(data.message, { type: 'success', autoClose: 2000 });
         } else {
            setShowOnline(!value);
            toast(data?.message, { type: 'error', autoClose: 2000 });
         }
      } catch (error) {
         setShowOnline(!value);
         toast('Can not update the state', { type: 'error', autoClose: 2000 });
      }
   };
   const handleChangeIsAnonymouse = async value => {
      value = !value;
      try {
         const { data } = await appointmentResonService.updateStateAppointment({
            isAnonymouse: value
         });
         if (data?.code === 200) {
            setIsAnonymouse(value);
            toast(data.message, { type: 'success', autoClose: 2000 });
         } else {
            setIsAnonymouse(!value);
            toast(data?.message, { type: 'error', autoClose: 2000 });
         }
      } catch (error) {
         setIsAnonymouse(!value);
         toast('Can not update the state', { type: 'error', autoClose: 2000 });
      }
   };
   return (
      <div>
         <div className="flex gap-5">
            <div className="flex gap-3 mb-5">
               <span>Allow others to see you online</span>
               <Switch
                  checkedChildren="on"
                  unCheckedChildren="off"
                  checked={showonline}
                  onChange={handleChangeShowOnline}
               />
            </div>
            <div className="flex gap-3 mb-5">
               <span>Allow others to see your personal information</span>
               <Switch
                  checkedChildren="on"
                  unCheckedChildren="off"
                  checked={!isAnonymouse}
                  onChange={handleChangeIsAnonymouse}
               />
            </div>
         </div>

         <Form onFinish={handleSubmit} style={{ maxWidth: 600 }} layout="vertical" className="!max-w-full">
            <Form.Item
               name="passwordOld"
               label="Password Old"
               validateStatus={errors?.PasswordOld ? 'error' : ''}
               help={errors?.PasswordOld}
            >
               <Input.Password className="w-full py-2" placeholder="Password old" type="password" />
            </Form.Item>
            <Form.Item
               name="passwordNew"
               label="Password New"
               validateStatus={errors?.PasswordNew ? 'error' : ''}
               help={errors?.PasswordNew}
            >
               <Input.Password className="w-full py-2" placeholder="Password New" type="password" />
            </Form.Item>
            <Form.Item
               name="confirmPasswordNew"
               label="Confirm Password New"
               validateStatus={errors?.ConfirmPasswordNew ? 'error' : ''}
               help={errors?.ConfirmPasswordNew}
            >
               <Input.Password className="w-full py-2" placeholder="Confirm Password New" type="password" />
            </Form.Item>
            <Button type="primary" shape="round" icon={<CheckOutlined />} htmlType="submit">
               Update
            </Button>
         </Form>
      </div>
   );
}
