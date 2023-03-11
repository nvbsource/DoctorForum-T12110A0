import { CheckOutlined, LoadingOutlined, PlusOutlined } from '@ant-design/icons';
import { Alert, Button, Col, Form, Input, Radio, Row, Select, Table, Upload } from 'antd';
import React, { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { toast } from 'react-toastify';
import { clearError, saveProfileStart, selectErrorsAuth, selectUserAuth } from '../../../app/features/auth/authSlice';
import axiosInstance from '../../../services/AxiosInstance';
import positionService from '../../../services/positionService';
import { beforeUploadImage, formatDateTime, getBase64 } from '../../../utils/function';

export default function PersonalInformation() {
   const userLogin = useSelector(selectUserAuth);
   const errors = useSelector(selectErrorsAuth);
   const dispatch = useDispatch();
   const [loading, setLoading] = useState(false);
   const [position, setPosition] = useState([]);
   const [form] = Form.useForm();
   const [imageUrl, setImageUrl] = useState(null);
   useEffect(() => {
      form.setFieldsValue({
         ...userLogin,
         created_at: formatDateTime(userLogin?.created_at),
         updated_at: formatDateTime(userLogin?.updated_at),
         lastLogin_at: formatDateTime(userLogin?.lastLogin_at)
      });
      setImageUrl(userLogin?.avatar);
   }, [userLogin, form]);

   useEffect(() => {
      handleGetPositions();
      dispatch(clearError());
   }, [dispatch]);

   const handleSubmit = values => {
      dispatch(saveProfileStart(values));
   };
   const handleGetPositions = async () => {
      const response = await positionService.getPositions();
      setPosition(response.data.result);
   };
   const uploadButton = (
      <div>
         {loading ? <LoadingOutlined /> : <PlusOutlined />}
         <div style={{ marginTop: 8 }}>Upload</div>
      </div>
   );
   const uploadAvatar = async file => {
      const formData = new FormData();
      formData.append('avatar', file);
      try {
         const response = await axiosInstance.post('/User/change-avatar', formData, {
            headers: {
               'Content-Type': 'multipart/form-data'
            }
         });
         toast(response.data.message, { type: 'success', autoClose: 2000 });
         return response.data.result;
      } catch (error) {
         toast('Failed to change avatar!', { type: 'error', autoClose: 2000 });
      }
   };

   return (
      <div>
         <Form onFinish={handleSubmit} style={{ maxWidth: 600 }} layout="vertical" className="!max-w-full" form={form}>
            <div className="flex items-end gap-[20px] mb-3">
               <Upload
                  name="avatar"
                  listType="picture-circle"
                  className="avatar-uploader !h-[100px] !w-[100px] rounded-full bg-red-400 flex justify-center items-center text-center overflow-hidden"
                  showUploadList={false}
                  beforeUpload={async file => {
                     const imageUrl = await uploadAvatar(file);
                     setImageUrl(imageUrl);
                     return false;
                  }}
               >
                  {imageUrl ? <img src={imageUrl} alt="avatar" style={{ width: '100%' }} /> : uploadButton}
               </Upload>
               <Form.Item name="gender" label="Gender">
                  <Radio.Group>
                     <Radio value="male">Male</Radio>
                     <Radio value="female">Female</Radio>
                     <Radio value="more">Other</Radio>
                  </Radio.Group>
               </Form.Item>
               <div className="flex-1 flex">
                  <Form.Item name="created_at" label="Created at" className="flex-1 pr-5">
                     <Input className="w-full py-2" placeholder="Create at" disabled />
                  </Form.Item>
                  <Form.Item name="updated_at" label="Updated at" className="flex-1 pr-5">
                     <Input className="w-full py-2" placeholder="Updated at" disabled />
                  </Form.Item>
                  <Form.Item name="lastLogin_at" label="Last Login" className="flex-1">
                     <Input className="w-full py-2" placeholder="Last Login" disabled />
                  </Form.Item>
               </div>
            </div>
            <Row>
               <Col span={12} className="pr-5">
                  <Form.Item
                     name="firstName"
                     label="First Name"
                     validateStatus={errors?.FirstName ? 'error' : ''}
                     help={errors?.FirstName}
                  >
                     <Input className="w-full py-2" placeholder="First Name" />
                  </Form.Item>
               </Col>
               <Col span={12}>
                  <Form.Item
                     name="lastName"
                     label="Last Name"
                     validateStatus={errors?.LastName ? 'error' : ''}
                     help={errors?.LastName}
                  >
                     <Input className="w-full py-2" placeholder="First Name" />
                  </Form.Item>
               </Col>
            </Row>
            <Row>
               <Col span={12} className="pr-5">
                  <Form.Item
                     name="phoneNumber"
                     label="Phone Number"
                     validateStatus={errors?.PhoneNumber ? 'error' : ''}
                     help={errors?.PhoneNumber}
                  >
                     <Input className="w-full py-2" placeholder="Phone Number" />
                  </Form.Item>
               </Col>
               <Col span={12}>
                  <Form.Item name="emailAddress" label="Email Address">
                     <Input className="w-full py-2" placeholder="Email Address" disabled />
                  </Form.Item>
               </Col>
            </Row>
            <Form.Item
               name="description"
               label="Description"
               validateStatus={errors?.LastName ? 'error' : ''}
               help={errors?.LastName}
            >
               <Input.TextArea className="w-full py-2" placeholder="Description" />
            </Form.Item>
            {userLogin?.isDoctor && (
               <>
                  <h3 className="font-bold">Organization Address</h3>
                  <Form.Item name="positionId" label="Position At Organization">
                     <Select
                        showSearch
                        placeholder="Position At Organization"
                        optionFilterProp="children"
                        filterOption={(input, option) => (option?.label ?? '').includes(input)}
                        filterSort={(optionA, optionB) =>
                           (optionA?.label ?? '').toLowerCase().localeCompare((optionB?.label ?? '').toLowerCase())
                        }
                        options={position.map(item => ({
                           value: item.id,
                           label: item.name
                        }))}
                     />
                  </Form.Item>
               </>
            )}
            <Row>
               <Col span={8} className="pr-5">
                  <Form.Item
                     name={['location', 'streetAddress']}
                     label="Street Address"
                     validateStatus={errors?.StreetAddress ? 'error' : ''}
                     help={errors?.StreetAddress}
                  >
                     <Input className="w-full py-2" placeholder="Street Address" />
                  </Form.Item>
               </Col>
               <Col span={8} className="pr-5">
                  <Form.Item
                     name={['location', 'streetAddress2']}
                     label="Street Address 2"
                     validateStatus={errors?.StreetAddress2 ? 'error' : ''}
                     help={errors?.StreetAddress2}
                  >
                     <Input className="w-full py-2" placeholder="Street Address 2" />
                  </Form.Item>
               </Col>
               <Col span={8}>
                  <Form.Item
                     name={['location', 'zipCode']}
                     label="Zip Code"
                     validateStatus={errors?.ZipCode ? 'error' : ''}
                     help={errors?.ZipCode}
                  >
                     <Input className="w-full py-2" placeholder="Zip Code" />
                  </Form.Item>
               </Col>
               {userLogin?.isDoctor && (
                  <Col span={24}>
                     <Alert
                        message="The street address will be applied to the doctor search"
                        type="warning"
                        className="mb-3"
                        showIcon
                     />
                  </Col>
               )}
            </Row>
            <Button type="primary" shape="round" icon={<CheckOutlined />} className="mb-5" htmlType="submit">
               Update
            </Button>
         </Form>
         <Table
            className="table-primary"
            columns={[
               {
                  title: 'Ip Address',
                  dataIndex: 'ipAddress'
               },
               {
                  title: 'Device',
                  dataIndex: 'device'
               },
               {
                  title: 'Time',
                  dataIndex: 'time'
               }
            ]}
            dataSource={userLogin?.userAccessLogs?.map(item => ({
               key: item.id,
               ipAddress: item.ipAddress,
               device: item.deviceInfo,
               time: formatDateTime(item.accessTime)
            }))}
            bordered
            title={() => <h3 className="font-bold">Account login history</h3>}
         />
      </div>
   );
}
