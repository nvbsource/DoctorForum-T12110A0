import { UserOutlined } from '@ant-design/icons';
import { Form, Input } from 'antd';
import { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Link } from 'react-router-dom';
import { clearError, loginStart, selectErrorsAuth } from '../app/features/auth/authSlice';
import { images } from '../assets';
export default function ForgotPasswordPage() {
   const dispatch = useDispatch();
   const errors = useSelector(selectErrorsAuth);
   const handleSubmit = values => {
      const { email, password } = values;
      dispatch(loginStart({ email, password }));
   };

   useEffect(() => {
      dispatch(clearError());
   }, [dispatch]);

   return (
      <div className="container !my-[40px]">
         <div className="flex flex-row bg-white rounded-xl truncate">
            <div className="singin flex flex-2 justify-center items-center flex-col gap-y-[29px] sm:flex">
               <img src={images.doctorCreate} className="w-full h-full bg-no-repeat bg-contain" alt="" />
            </div>
            <div className="flex flex-col justify-center p-3 mb-10 sm:items-center flex-3">
               <div className="w-[164px]  mx-auto">
                  <img src={images.doctor_logo} className="w-full h-full" alt="" />
               </div>
               <div className="flex flex-col gap-y-[12px] form_signin">
                  <h2 className="sm:text-xl text-base  font-black text-[#373737] m-auto">Forgot Password</h2>
                  <Form
                     name="basic"
                     labelCol={{ span: 8 }}
                     wrapperCol={{ span: 24 }}
                     onFinish={handleSubmit}
                     onFinishFailed={() => {}}
                     autoComplete="off"
                  >
                     <div className="flex sm:w-[495px] w-full bg-[#fff] border-[0.5px] border-solid border-[#B8B8B8] mt-8 ">
                        <div className="flex items-center justify-center border-r-[0.5px] border-[#B8B8B8] px-5">
                           <UserOutlined style={{ width: '16px', height: '12px', color: '#222222' }} />
                        </div>
                        <div className="flex flex-col w-full">
                           <div className="pl-3 flex items-center py-1 border-b-[0.5px] border-[#B8B8B8]">
                              <label className="text-[#119AE2]" htmlFor="">
                                 Email
                              </label>
                              <span className="ml-1 text-sm font-normal text-red-500">*</span>
                           </div>
                           <div className="flex px-3">
                              <Form.Item
                                 className="w-full m-0"
                                 name="email"
                                 rules={[{ required: true, message: 'Please input email' }]}
                                 validateStatus={errors?.Email ? 'error' : ''}
                                 help={errors?.Email}
                              >
                                 <Input
                                    bordered={false}
                                    placeholder="Input email"
                                    className="text-sm font-semibold placeholder:italic px-0"
                                 />
                              </Form.Item>
                           </div>
                        </div>
                     </div>
                     <div className="flex justify-center text-white font-bold item-center my-5">
                        <button
                           type="submit"
                           className="sm:w-[252px] w-[181px] sm:h-[50px] p-2 rounded-[30px] bg-[#119AE2] border-none outline-none"
                        >
                           Send Email
                        </button>
                     </div>
                  </Form>
               </div>
               <p className="mb-6 text-xs font-normal text-center lg:text-sm text-text3 lg:mb-8">
                  did you remember the password?{' '}
                  <Link to="/signin" className="font-bold underline text-sm text-[#119AE2]">
                     SignIn
                  </Link>
               </p>
               <div className="w-[93px] h-[1px] bg-[#119AE2] mb-3"></div>
            </div>
         </div>
      </div>
   );
}
