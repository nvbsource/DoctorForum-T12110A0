import { DatabaseOutlined, PhoneOutlined } from '@ant-design/icons';
import { Button, DatePicker, Descriptions, Form, Input, List, Modal, Select, Tabs, Typography } from 'antd';
import TextArea from 'antd/lib/input/TextArea';
import moment from 'moment';
import React, { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Link, useParams } from 'react-router-dom';
import { getProfileStart, selectProfile, selectUserAuth } from '../../app/features/auth/authSlice';
import PostInProfile from '../../components/Posts/PostInProfile';
import { formatDateTime, getTimeElapsed } from '../../utils/function';
import appointmentResonService from '../../services/appointmentService';
import { toast } from 'react-toastify';
import { useForm } from 'antd/lib/form/Form';
import 'moment-timezone';

export default function ProfileDoctor() {
   const { userId } = useParams();
   const dispatch = useDispatch();
   const profile = useSelector(selectProfile);
   const userLogin = useSelector(selectUserAuth);
   const [openRequestAppointment, setOpenRequestAppointment] = useState(false);
   const [errors, setErrors] = useState({});
   const [form] = useForm();
   const [appointmentReasons, setAppointmentReasons] = useState([]);
   useEffect(() => {
      handleGetAppointmentReson();
   }, []);
   const handleGetAppointmentReson = async () => {
      const response = await appointmentResonService.getAppointmentResonsByUser(userId);
      setAppointmentReasons(response.data?.result);
   };

   useEffect(() => {
      form.setFieldsValue({
         fullName: userLogin?.fullName,
         email: userLogin?.emailAddress,
         phone: userLogin?.phoneNumber,
         startDate: moment()
      });
   }, [userLogin]);
   useEffect(() => {
      dispatch(getProfileStart(userId));
   }, []);
   const handleSubmitCreateAppointment = async values => {
      try {
         const { data } = await appointmentResonService.createAppointment({
            ...values,
            userId,
            startDate: moment.tz(values.startDate.format('YYYY/MM/DD'), 'Asia/Ho_Chi_Minh').clone()
         });
         if (data?.code === 200) {
            setErrors({});
            form.resetFields();
            toast(data.message, { type: 'success', autoClose: 2000 });
         } else {
            toast(data.message, { type: 'error', autoClose: 2000 });
         }
      } catch (error) {
         console.log(error);
         setErrors(error.response.data.errors);
         toast(error.response.data.message, { type: 'error', autoClose: 2000 });
      }
   };
   return (
      <div className="container !my-[40px]">
         <div className="relative bg-white rounded-t-xl overflow-hidden">
            <div className="w-[140px] h-[140px] rounded-full overflow-hidden absolute top-[10px] left-[10px] bg-white">
               <img src={profile?.avatar} alt="" className="absolute w-full h-full top-[0] left-[0]" />
            </div>
            {profile?.id !== userLogin?.id && (
               <div className="absolute right-[10px] top-[10px] flex gap-2">
                  <button
                     className="px-[20px] py-[10px] font-bold cursor-pointer flex gap-2 justify-center items-center bg-[#ffffff] hover:bg-[black] hover:text-[#ffffff] rounded border-[1px] border-solid border-[#eee]"
                     onClick={() => setOpenRequestAppointment(true)}
                  >
                     <DatabaseOutlined />
                     Request Appointment
                  </button>
                  <Link to={`/messages/${profile?.id}`} className="text-inherit">
                     <button className="px-[20px] py-[10px] font-bold cursor-pointer flex gap-2 justify-center items-center bg-[#ffffff] hover:bg-[black] hover:text-[#ffffff] border-[1px] rounded border-solid border-[#eee]">
                        <PhoneOutlined />
                        Send Message
                     </button>
                  </Link>
               </div>
            )}
            <div className="pl-[170px] border-b-[1px] border-b-[#cccc] border-b-solid bg-[#009962] p-3 text-white">
               <h2 className="font-bold mb-0 text-white">{profile?.fullName}</h2>
               <div className="font-[500]">
                  <p>
                     <span className="font-[600]">Join:</span> {formatDateTime(profile?.created_at)}
                  </p>
                  <p>
                     <span className="font-[600]">Last login:</span>{' '}
                     {!profile?.isAnonymouse ? getTimeElapsed(profile?.lastLogin_at) : 'Anonymouse'}
                  </p>
               </div>
            </div>
            <div className="w-[calc(100%-170px)] ml-auto pr-3 py-3">
               <div className="flex justify-between">
                  <div className="text-center">
                     <div className="font-[500]">Posts</div>
                     <span>{profile?.posts?.length}</span>
                  </div>
               </div>
            </div>
         </div>
         <div>
            <Tabs
               defaultActiveKey="1"
               size="small"
               items={[
                  {
                     label: `ARTICLES ON PROFILE`,
                     key: '1',
                     children: (
                        <div className="flex flex-col">
                           {profile?.posts?.map(item => (
                              <PostInProfile data={item} user={profile} />
                           ))}
                        </div>
                     )
                  },
                  {
                     label: `INTRODUCE`,
                     key: '2',
                     children: (
                        <div className="p-3 bg-white rounded-b-xl">
                           <p>{profile?.description}</p>
                           <Descriptions>
                              <Descriptions.Item label="Full Name">
                                 {profile?.fullName || 'Anonymouse'}
                              </Descriptions.Item>
                              <Descriptions.Item label="Telephone">
                                 {profile?.phoneNumber || 'Anonymouse'}
                              </Descriptions.Item>
                              <Descriptions.Item label="Website">{profile?.website || 'Anonymouse'}</Descriptions.Item>
                              <Descriptions.Item label="Street Address">
                                 {profile?.location?.streetAddress || 'Anonymouse'}
                              </Descriptions.Item>
                              <Descriptions.Item label="Street Address 2">
                                 {profile?.location?.streetAddress2 || 'Anonymouse'}
                              </Descriptions.Item>
                              <Descriptions.Item label="Zip Code">
                                 {profile?.location?.zipCode || 'Anonymouse'}
                              </Descriptions.Item>
                           </Descriptions>
                           <List
                              header={<div>Specialties</div>}
                              bordered
                              dataSource={profile?.specialtyDoctors || []}
                              renderItem={item => (
                                 <List.Item>
                                    <Typography.Text mark></Typography.Text> {item?.specialty?.name}
                                 </List.Item>
                              )}
                           />
                        </div>
                     )
                  }
               ]}
            />
         </div>
         <Modal
            title="Send Request Appointment"
            centered
            open={openRequestAppointment}
            onCancel={() => setOpenRequestAppointment(false)}
            footer={null}
            width={600}
         >
            <Form layout="vertical" onFinish={handleSubmitCreateAppointment} form={form}>
               <Form.Item
                  className="mb-2"
                  name="fullName"
                  label="Full Name"
                  rules={[{ required: true }]}
                  validateStatus={errors?.FullName ? 'error' : ''}
                  help={errors?.FullName}
               >
                  <Input placeholder="Full Name" />
               </Form.Item>
               <Form.Item
                  className="mb-2"
                  name="email"
                  label="Email Address"
                  rules={[
                     {
                        type: 'email',
                        message: 'The input is not valid E-mail!'
                     },
                     {
                        required: true
                     }
                  ]}
                  validateStatus={errors?.Email ? 'error' : ''}
                  help={errors?.Email}
               >
                  <Input placeholder="Email Address" />
               </Form.Item>
               <Form.Item
                  className="mb-2"
                  name="phone"
                  label="Phone Number"
                  rules={[
                     { required: true },
                     {
                        message: 'Please enter the correct format',
                        pattern: new RegExp(/(84|0[3|5|7|8|9])+([0-9]{8})\b/g)
                     }
                  ]}
                  validateStatus={errors?.Phone ? 'error' : ''}
                  help={errors?.Phone}
               >
                  <Input placeholder="Phone Number" />
               </Form.Item>
               <Form.Item
                  className="mb-2"
                  name="appointmentReasonId"
                  label="Appointment Reason"
                  rules={[{ required: true }]}
                  validateStatus={errors?.AppointmentReasonId ? 'error' : ''}
                  help={errors?.AppointmentReasonId}
               >
                  <Select options={appointmentReasons.map(item => ({ value: item.id, label: item.name }))}></Select>
               </Form.Item>
               <Form.Item
                  className="mb-2"
                  name="other"
                  label="Other"
                  validateStatus={errors?.Other ? 'error' : ''}
                  help={errors?.Other}
               >
                  <TextArea rows={4} />
               </Form.Item>
               <Form.Item
                  className="mb-2"
                  name="startDate"
                  label="Start Date"
                  rules={[{ required: true }]}
                  validateStatus={errors?.StartDate ? 'error' : ''}
                  help={errors?.StartDate}
               >
                  <DatePicker
                     style={{ width: '100%' }}
                     disabledDate={current => {
                        return moment().add(-1, 'days') >= current;
                     }}
                  />
               </Form.Item>
               <Button type="primary" htmlType="submit">
                  Send Request
               </Button>
            </Form>
         </Modal>
      </div>
   );
}
