import Icon, { LoadingOutlined, LockOutlined, MailOutlined, UserOutlined } from '@ant-design/icons';

import { Button, Form, Input, Modal, Radio, Spin } from 'antd';
import { useForm } from 'antd/lib/form/Form';
import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Link, useNavigate } from 'react-router-dom';
import { clearError, createUserStart, selectErrorsAuth, selectLoadingAuth } from '../app/features/auth/authSlice';
import { images } from '../assets';

export default function SignUpPage() {
   const dispatch = useDispatch();
   const errors = useSelector(selectErrorsAuth);
   const loading = useSelector(selectLoadingAuth);
   const [open, setOpen] = useState(false);
   const [form] = useForm();

   useEffect(() => {
      dispatch(clearError());
   }, [dispatch]);

   const PhoneSvg = () => (
      <svg width="15" height="20" viewBox="0 0 15 20" fill="none" xmlns="http://www.w3.org/2000/svg">
         <path
            fill-rule="evenodd"
            clip-rule="evenodd"
            d="M3.14449 1H11.8494C13.0421 1 13.9939 1.95042 13.9939 3.12342V17.0766C13.9939 18.2502 13.0204 19.2 11.8494 19.2H3.14449C1.95177 19.2 1 18.2496 1 17.0766V3.12342C1 1.94975 1.97352 1 3.14449 1ZM11.8494 18.3677C12.576 18.3677 13.1616 17.7992 13.1616 17.0766V3.12342C13.1616 2.42084 12.575 1.83232 11.8494 1.83232H3.14449C2.41789 1.83232 1.83232 2.40074 1.83232 3.12342V17.0766C1.83232 17.7791 2.41888 18.3677 3.14449 18.3677H11.8494ZM3.14449 1.1H11.8494C12.9876 1.1 13.8939 2.00632 13.8939 3.12342V17.0766C13.8939 18.1937 12.9665 19.1 11.8494 19.1H3.14449C2.00632 19.1 1.1 18.1937 1.1 17.0766V3.12342C1.1 2.00632 2.0274 1.1 3.14449 1.1ZM11.8494 18.4677C12.6293 18.4677 13.2616 17.8564 13.2616 17.0766V3.12342C13.2616 2.36464 12.6293 1.73232 11.8494 1.73232H3.14449C2.36464 1.73232 1.73232 2.34356 1.73232 3.12342V17.0766C1.73232 17.8353 2.36464 18.4677 3.14449 18.4677H11.8494Z"
            fill="black"
            stroke="black"
            stroke-width="0.2"
         />
         <path
            fill-rule="evenodd"
            clip-rule="evenodd"
            d="M4.87319 3.00195H10.0793C10.3031 3.00195 10.4954 3.19427 10.4954 3.41811C10.4954 3.64196 10.3031 3.83427 10.0793 3.83427H4.87319C4.64934 3.83427 4.45703 3.64196 4.45703 3.41811C4.45703 3.19427 4.64934 3.00195 4.87319 3.00195ZM4.87319 3.10195H10.0793C10.2479 3.10195 10.3954 3.24949 10.3954 3.41811C10.3954 3.58673 10.2479 3.73427 10.0793 3.73427H4.87319C4.70457 3.73427 4.55703 3.58673 4.55703 3.41811C4.55703 3.24949 4.70457 3.10195 4.87319 3.10195Z"
            fill="black"
            stroke="black"
            stroke-width="0.2"
         />
         <path
            fill-rule="evenodd"
            clip-rule="evenodd"
            d="M6.33203 16.233C6.33203 15.61 6.83921 15.0791 7.48589 15.0791C8.12996 15.0791 8.63976 15.5863 8.63976 16.2119C8.63976 16.8349 8.13258 17.3658 7.48589 17.3658C7.18857 17.3658 6.88928 17.2521 6.67934 17.0432C6.44626 16.8324 6.33203 16.5309 6.33203 16.233ZM6.74819 16.9707C6.53742 16.781 6.43203 16.507 6.43203 16.233C6.43203 15.6639 6.89573 15.1791 7.48589 15.1791C8.07606 15.1791 8.53976 15.6428 8.53976 16.2119C8.53976 16.781 8.07606 17.2658 7.48589 17.2658C7.21189 17.2658 6.93789 17.1604 6.74819 16.9707ZM7.2826 16.4573C7.34875 16.5235 7.42894 16.5545 7.50697 16.5545C7.68359 16.5545 7.82852 16.4096 7.82852 16.233C7.82852 16.0563 7.68359 15.9114 7.50697 15.9114C7.33035 15.9114 7.18543 16.0563 7.18543 16.233C7.18543 16.311 7.21645 16.3912 7.2826 16.4573ZM7.21189 16.528C7.2962 16.6124 7.40159 16.6545 7.50697 16.6545C7.73882 16.6545 7.92852 16.4648 7.92852 16.233C7.92852 16.0011 7.73882 15.8114 7.50697 15.8114C7.27512 15.8114 7.08543 16.0011 7.08543 16.233C7.08543 16.3384 7.12758 16.4437 7.21189 16.528Z"
            fill="black"
            stroke="black"
            stroke-width="0.2"
         />
      </svg>
   );
   const handleSubmitRegister = isDoctor => {
      const { firstName, lastName, password, username, gender, phoneNumber, emailAddress } = form.getFieldsValue();
      dispatch(
         createUserStart({
            firstName,
            lastName,
            password,
            username,
            gender,
            phoneNumber,
            emailAddress,
            isDoctor
         })
      );
      setOpen(false);
   };
   const PhoneIcon = props => <Icon component={PhoneSvg} {...props} />;
   return (
      <div className="container !my-[40px]">
         <div className="flex flex-row gap-[30px] bg-white p-[30px] rounded-xl">
            <div className="flex flex-col items-center justify-center">
               <div>
                  <h2 className="text-xl font-black text-[#373737] not-italic text-center">SIGN UP</h2>
                  <div className="flex flex-col gap-y-[12px]">
                     <Form
                        name="basic"
                        labelCol={{ span: 8 }}
                        wrapperCol={{ span: 24 }}
                        onFinish={() => setOpen(true)}
                        autoComplete="off"
                        form={form}
                     >
                        <div className="flex w-[495px] bg-[#fff] border-[0.5px] border-solid border-[#B8B8B8] mt-4 ">
                           <div className="flex items-center justify-center border-r-[0.5px] border-[#B8B8B8] px-5">
                              <UserOutlined style={{ width: '16px', height: '12px', color: '#222222' }} />
                           </div>
                           <div className="flex flex-col w-full">
                              <div className="pl-3 flex items-center py-1 border-b-[0.5px] border-[#B8B8B8]">
                                 <label className="text-[#119AE2]" htmlFor="">
                                    FirstName
                                 </label>
                                 <span className="ml-1 text-sm font-normal text-red-500">*</span>
                              </div>
                              <div className="flex px-3">
                                 <Form.Item
                                    className="w-full m-0"
                                    name="firstName"
                                    rules={[{ required: true, message: 'Please input FirstName' }]}
                                    validateStatus={errors?.FirstName ? 'error' : ''}
                                    help={errors?.FirstName}
                                 >
                                    <Input
                                       bordered={false}
                                       placeholder="Input FirstName"
                                       className="text-sm font-semibold placeholder:italic px-0"
                                    />
                                 </Form.Item>
                              </div>
                           </div>
                        </div>
                        <div className="flex w-[495px] bg-[#fff] border-[0.5px] border-solid border-[#B8B8B8] mt-4 ">
                           <div className="flex items-center justify-center border-r-[0.5px] border-[#B8B8B8] px-5">
                              <UserOutlined style={{ width: '16px', height: '12px', color: '#222222' }} />
                           </div>
                           <div className="flex flex-col w-full">
                              <div className="pl-3 flex items-center py-1 border-b-[0.5px] border-[#B8B8B8]">
                                 <label className="text-[#119AE2]" htmlFor="">
                                    LastName
                                 </label>
                                 <span className="ml-1 text-sm font-normal text-red-500">*</span>
                              </div>
                              <div className="flex px-3">
                                 <Form.Item
                                    className="w-full m-0"
                                    name="lastName"
                                    rules={[{ required: true, message: 'Please input LastName' }]}
                                    validateStatus={errors?.LastName ? 'error' : ''}
                                    help={errors?.LastName}
                                 >
                                    <Input
                                       bordered={false}
                                       placeholder="Input LastName"
                                       className="text-sm font-semibold font-weight placeholder:italic px-0"
                                    />
                                 </Form.Item>
                              </div>
                           </div>
                        </div>
                        <div className="flex w-[495px] bg-[#fff] border-[0.5px] border-solid border-[#B8B8B8] mt-4 ">
                           <div className="flex items-center justify-center border-r-[0.5px] border-[#B8B8B8] px-5">
                              <PhoneIcon
                                 style={{
                                    width: '16px',
                                    height: '12px',
                                    color: '#222222',
                                    position: 'relative'
                                 }}
                              />
                              {/* <FontAwesomeIcon icon="fa-regular fa-mobile-notch" className="w-4 h-3 color-[222222]" /> */}
                           </div>
                           <div className="flex flex-col w-full">
                              <div className="pl-3 flex items-center py-1 border-b-[0.5px] border-[#B8B8B8]">
                                 <label className="text-[#119AE2]" htmlFor="">
                                    PhoneNumber
                                 </label>
                                 <span className="ml-1 text-sm font-normal text-red-500">*</span>
                              </div>
                              <div className="flex px-3">
                                 <Form.Item
                                    className="w-full m-0"
                                    name="phoneNumber"
                                    rules={[
                                       {
                                          required: true,
                                          message: 'Please enter the correct format',
                                          pattern: new RegExp(/(84|0[3|5|7|8|9])+([0-9]{8})\b/g)
                                       }
                                    ]}
                                    validateStatus={errors?.PhoneNumber ? 'error' : ''}
                                    help={errors?.PhoneNumber}
                                 >
                                    <Input
                                       bordered={false}
                                       placeholder="Input PhoneNumber"
                                       className="text-sm font-semibold font-weight placeholder:italic px-0"
                                    />
                                 </Form.Item>
                              </div>
                           </div>
                        </div>
                        <div className="flex w-[495px] bg-[#fff] border-[0.5px] border-solid border-[#B8B8B8] mt-4 ">
                           <div className="flex items-center justify-center border-r-[0.5px] border-[#B8B8B8] px-5">
                              <MailOutlined style={{ width: '16px', height: '12px', color: '#222222' }} />
                           </div>
                           <div className="flex flex-col w-full">
                              <div className="pl-3 flex items-center py-1 border-b-[0.5px] border-[#B8B8B8]">
                                 <label className="text-[#119AE2]" htmlFor="">
                                    Email
                                 </label>
                                 <span className="text-sm font-normal text-red-500">*</span>
                              </div>
                              <div className="flex px-3">
                                 <Form.Item
                                    className="w-full m-0 "
                                    name="emailAddress"
                                    rules={[
                                       {
                                          required: true,
                                          message: 'Please enter the correct format',
                                          type: 'email',
                                          pattern: RegExp(
                                             /^[a-z][a-z0-9_.]{5,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$/gm
                                          )
                                       }
                                    ]}
                                    validateStatus={errors?.EmailAddress ? 'error' : ''}
                                    help={errors?.EmailAddress}
                                 >
                                    <Input
                                       bordered={false}
                                       placeholder="Input Email"
                                       className="text-sm font-semibold font-weight placeholder:italic px-0"
                                    />
                                 </Form.Item>
                              </div>
                           </div>
                        </div>
                        <div className="flex w-[495px] bg-[#fff] border-[0.5px] border-solid border-[#B8B8B8] mt-4 ">
                           <div className="flex items-center justify-center border-r-[0.5px] border-[#B8B8B8] px-5">
                              <UserOutlined style={{ width: '16px', height: '12px', color: '#222222' }} />
                           </div>
                           <div className="flex flex-col w-full">
                              <div className="pl-3 flex items-center py-1 border-b-[0.5px] border-[#B8B8B8]">
                                 <label className="text-[#119AE2]" htmlFor="">
                                    UserName
                                 </label>
                                 <span className="ml-1 text-sm font-normal text-red-500">*</span>
                              </div>
                              <div className="flex px-3">
                                 <Form.Item
                                    className="w-full m-0"
                                    name="username"
                                    rules={[{ required: true, message: 'Please input UserName' }]}
                                    validateStatus={errors?.Username ? 'error' : ''}
                                    help={errors?.Username}
                                 >
                                    <Input
                                       bordered={false}
                                       placeholder="Input UserName"
                                       className="text-sm font-semibold font-weight placeholder:italic px-0"
                                    />
                                 </Form.Item>
                              </div>
                           </div>
                        </div>

                        <div className="flex w-[495px] bg-[#fff] border-[0.5px] border-solid border-[#B8B8B8] mt-4 ">
                           <div className="flex items-center justify-center border-r-[0.5px] border-[#B8B8B8] px-5">
                              <MailOutlined style={{ width: '16px', height: '12px', color: '#222222' }} />
                           </div>
                           <div className="flex flex-col w-full">
                              <div className="pl-3 flex items-center py-1 border-b-[0.5px] border-[#B8B8B8]">
                                 <label className="text-[#119AE2]" htmlFor="">
                                    Gender
                                 </label>
                                 <span className="text-sm font-normal text-red-500">*</span>
                              </div>
                              <div className="flex px-3">
                                 <Form.Item
                                    className="w-full m-0 "
                                    name="gender"
                                    rules={[{ required: true, message: 'Please choose Gender' }]}
                                    validateStatus={errors?.Gender ? 'error' : ''}
                                    help={errors?.Gender}
                                 >
                                    <Radio.Group>
                                       <Radio value="male">Male</Radio>
                                       <Radio value="female">Female</Radio>
                                       <Radio value="more">Other</Radio>
                                    </Radio.Group>
                                 </Form.Item>
                              </div>
                           </div>
                        </div>
                        <div className="flex w-[495px] bg-[#fff] border-[0.5px] border-solid border-[#B8B8B8] mt-4">
                           <div className="flex items-center justify-center border-r-[0.5px] border-[#B8B8B8] px-5">
                              <LockOutlined style={{ width: '16px', height: '12px', color: '#222222' }} />
                           </div>
                           <div className="flex flex-col w-full">
                              <div className="pl-3 flex items-center py-1 border-b-[0.5px] border-[#B8B8B8]">
                                 <label className="text-[#119AE2]" htmlFor="">
                                    Password
                                 </label>
                                 <span className="ml-1 text-sm font-normal text-red-500">*</span>
                              </div>
                              <div className="flex px-3">
                                 <Form.Item
                                    className="w-full m-0"
                                    name="password"
                                    rules={[{ required: true, message: 'Please input password' }]}
                                    validateStatus={errors?.Password ? 'error' : ''}
                                    help={errors?.Password}
                                 >
                                    <Input.Password bordered={false} placeholder="Input Password" />
                                 </Form.Item>
                              </div>
                           </div>
                        </div>
                        {/* <div className="text-right">
                           <Link to="/forgot-password">
                              <span className="inline-block text-sm font-normal cursor-pointer text-[#222222]">
                                 Forgot Password
                              </span>
                           </Link>
                        </div> */}
                        <div className="flex justify-center text-white font-bold item-center my-[12px]">
                           <button
                              type="submit"
                              className="w-[252px] h-[50px] p-2 rounded-[30px]  bg-[#119AE2]  border-none outline-none"
                           >
                              {loading ? (
                                 <>
                                    <Spin
                                       indicator={
                                          <LoadingOutlined style={{ fontSize: 24 }} spin className="text-white" />
                                       }
                                    />{' '}
                                    Currently signup
                                 </>
                              ) : (
                                 'SignUp'
                              )}
                           </button>
                        </div>
                     </Form>
                  </div>
                  <p className="mb-6 text-xs font-normal text-center lg:text-sm text-text3 lg:mb-8">
                     Already have an account{' '}
                     <Link to="/signin" className="font-bold underline text-sm text-[#119AE2]">
                        SignIn
                     </Link>
                  </p>
                  <div className="w-[93px] h-[1px] bg-[#119AE2] mb-3 mx-auto"></div>
               </div>
            </div>
            <div className="singin">
               <img src={images.doctorCreate} className="object-cover w-full bg-no-repeat bg-contain" alt="" />
            </div>
         </div>
         <Modal title="Are you a doctor or a patient?" open={open} onCancel={() => setOpen(false)} footer={null}>
            <p>Please choose so we can help you have the best experience</p>
            <Button type="primary" onClick={() => handleSubmitRegister(true)}>
               I'm a doctor
            </Button>
            <Button className="ml-3" onClick={() => handleSubmitRegister(false)}>
               I'm a patient
            </Button>
         </Modal>
      </div>
   );
}
