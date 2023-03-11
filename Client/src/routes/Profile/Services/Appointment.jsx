import { DeleteOutlined, EditOutlined } from '@ant-design/icons';
import { Button, Modal, Select, Table } from 'antd';
import Input from 'antd/lib/input/Input';
import React, { useEffect, useState } from 'react';
import { useSelector } from 'react-redux';
import { toast } from 'react-toastify';
import { selectUserAuth } from '../../../app/features/auth/authSlice';
import AppointmentReasonForm from '../../../components/AppointmentReasonForm';
import AppointmentRequestManage from '../../../components/AppointmentRequestManage';
import appointmentResonService from '../../../services/appointmentService';

export default function Appointment() {
   const [appointmentReasons, setAppointmentReasons] = useState([]);
   const [visible, setVisible] = useState(false);

   const [appointmentEveryday, setAppointmentEveryday] = useState(null);
   const [sendEmail, setSendEmail] = useState(null);
   const [disabledAppointmentEveryday, setDisabledAppointmentEveryday] = useState(false);
   const [disabledSendEmail, setDisabledSendEmail] = useState(false);
   const userLogin = useSelector(selectUserAuth);

   const options = [];

   useEffect(() => {
      handleGetAppointmentReson();
   }, []);

   useEffect(() => {
      setSendEmail(userLogin?.remindPatient);
      setAppointmentEveryday(userLogin?.appointmentEveryDay);
      setDisabledSendEmail(userLogin?.isDisabledRemindPatient);
      setDisabledAppointmentEveryday(userLogin?.isDisabledAppointmentEveryDay);
   }, [userLogin]);

   const handleGetAppointmentReson = async () => {
      const response = await appointmentResonService.getAppointmentResons();
      setAppointmentReasons(response.data?.result.map(item => ({ ...item, isEditing: false })));
   };

   for (let i = 1; i <= 24; i++) {
      options.push(<Select.Option key={`${i}`}>{`${i} hour${i > 1 ? 's' : ''}`}</Select.Option>);
   }
   for (let i = 1; i <= 4; i++) {
      options.push(<Select.Option key={`${i * 24}`}>{`${i} day${i > 1 ? 's' : ''}`}</Select.Option>);
   }
   const showCreateDialog = () => {
      setVisible(true);
   };

   const handleCancel = () => {
      setVisible(false);
   };
   const handleRemoveAppointmentReason = async index => {
      try {
         const newAppointmentReasons = [...appointmentReasons];
         const item = newAppointmentReasons[index];
         const response = await appointmentResonService.deleteAppointmentReson(item.id);
         newAppointmentReasons.splice(index, 1);
         setAppointmentReasons(newAppointmentReasons);
         toast(response.data.message, { type: 'success', autoClose: 2000 });
      } catch (error) {
         toast(error.response?.data?.message, { type: 'error', autoClose: 2000 });
      }
   };

   const handleChangeAppointmentReason = (value, index) => {
      const newAppointmentReasons = [...appointmentReasons];
      newAppointmentReasons[index].name = value;
      setAppointmentReasons(newAppointmentReasons);
   };

   const handleEditAppointmentReason = index => {
      const newAppointmentReasons = [...appointmentReasons];
      newAppointmentReasons[index].isEditing = true;
      setAppointmentReasons(newAppointmentReasons);
   };

   const handleSaveAppointmentReason = async index => {
      try {
         const newAppointmentReasons = [...appointmentReasons];
         const item = newAppointmentReasons[index];
         const response = await appointmentResonService.updateAppointmentReson({ id: item.id, name: item.name });
         item.isEditing = false;
         setAppointmentReasons(newAppointmentReasons);
         toast(response.data.message, { type: 'success', autoClose: 2000 });
      } catch (error) {
         toast(error.response?.data?.message, { type: 'error', autoClose: 2000 });
      }
   };
   const getIndex = key => key.split('-')[1];
   const columns = [
      {
         title: 'Reason',
         dataIndex: 'name',
         render: (_, record) => (
            <Input
               disabled={!record.isEditing}
               defaultValue={record.name}
               onChange={e => handleChangeAppointmentReason(e.target.value, getIndex(record.key))}
            />
         )
      },
      {
         title: 'Action',
         dataIndex: 'action',
         render: (_, record) => (
            <>
               {record.isEditing ? (
                  <Button
                     type="primary"
                     className="rounded-full"
                     icon={<EditOutlined />}
                     onClick={() => handleSaveAppointmentReason(getIndex(record.key))}
                  >
                     Save
                  </Button>
               ) : (
                  <Button
                     type="primary"
                     className="rounded-full"
                     icon={<EditOutlined />}
                     onClick={() => handleEditAppointmentReason(getIndex(record.key))}
                  >
                     Edit
                  </Button>
               )}
               <Button
                  className="ml-3 rounded-full"
                  type="primary"
                  danger
                  icon={<DeleteOutlined />}
                  onClick={() => handleRemoveAppointmentReason(getIndex(record.key))}
               >
                  Delete
               </Button>
            </>
         )
      }
   ];

   const dataSource = appointmentReasons.map((item, index) => ({
      key: `${item.id}-${index}`,
      name: item.name,
      isEditing: item.isEditing
   }));

   const handleSaveDisabledAppointmentEveryday = async () => {
      try {
         const { data } = await appointmentResonService.updateStateAppointment({
            IsDisabledAppointmentEveryDay: !disabledAppointmentEveryday
         });
         if (data?.code === 200) {
            setDisabledAppointmentEveryday(prev => !prev);
            toast(data.message, { type: 'success', autoClose: 2000 });
         } else {
            toast(data?.message, { type: 'error', autoClose: 2000 });
         }
      } catch (error) {
         toast(error.data?.message, { type: 'error', autoClose: 2000 });
      }
   };
   const handleSaveDisabledSendEmail = async () => {
      try {
         const { data } = await appointmentResonService.updateStateAppointment({
            IsDisabledRemindPatient: !disabledSendEmail
         });
         if (data?.code === 200) {
            setDisabledSendEmail(prev => !prev);
            toast(data.message, { type: 'success', autoClose: 2000 });
         } else {
            toast(data?.message, { type: 'error', autoClose: 2000 });
         }
      } catch (error) {
         toast(error.data?.message, { type: 'error', autoClose: 2000 });
      }
   };
   const handleSaveAppointmentEveryday = async () => {
      try {
         const { data } = await appointmentResonService.updateStateAppointment({
            appointmentEveryDay: appointmentEveryday
         });
         if (data?.code === 200) {
            toast(data.message, { type: 'success', autoClose: 2000 });
         } else {
            toast(data?.message, { type: 'error', autoClose: 2000 });
         }
      } catch (error) {
         toast(error.data?.message, { type: 'error', autoClose: 2000 });
      }
   };
   const handleSaveSendEmail = async () => {
      try {
         const { data } = await appointmentResonService.updateStateAppointment({
            remindPatient: sendEmail
         });
         if (data?.code === 200) {
            toast(data.message, { type: 'success', autoClose: 2000 });
         } else {
            toast(data?.message, { type: 'error', autoClose: 2000 });
         }
      } catch (error) {
         toast(error.data?.message, { type: 'error', autoClose: 2000 });
      }
   };

   return (
      <div>
         <div className="flex flex-col gap-3">
            <div className="border border-[#ccc] border-solid p-3 gap-3 rounded-full mb-5">
               <span className="font-[600]">Prevent</span>
               <Input
                  defaultValue={appointmentEveryday}
                  value={appointmentEveryday}
                  style={{ width: 120 }}
                  bordered={false}
                  className="input-hover-border-bottom"
                  onChange={e => setAppointmentEveryday(e.target.value)}
               />
               <span>appointment every day</span>
               <Button type="primary" className="rounded-full ml-3" onClick={handleSaveAppointmentEveryday}>
                  Save
               </Button>
               <Button
                  type={!disabledAppointmentEveryday ? 'danger' : 'primary'}
                  className="rounded-full ml-3"
                  onClick={handleSaveDisabledAppointmentEveryday}
               >
                  {!disabledAppointmentEveryday ? 'Disabled' : 'Enabled'}
               </Button>
            </div>
            <div className="border border-[#ccc] border-solid p-3 gap-3 rounded-full mb-5">
               <span className="font-[600]">Send email</span>
               <Select
                  defaultValue={sendEmail}
                  value={sendEmail}
                  style={{ width: 100 }}
                  bordered={false}
                  className="input-hover-border-bottom"
                  onChange={value => setSendEmail(value)}
               >
                  {options}
               </Select>
               <span>hour before the appointment starts</span>
               <Button type="primary" className="rounded-full ml-3" onClick={handleSaveSendEmail}>
                  Save
               </Button>
               <Button
                  type={!disabledSendEmail ? 'danger' : 'primary'}
                  className="rounded-full ml-3"
                  onClick={handleSaveDisabledSendEmail}
               >
                  {!disabledSendEmail ? 'Disabled' : 'Enabled'}
               </Button>
            </div>
         </div>
         <div className="flex justify-between items-center mb-3">
            <h3 className="font-bold mb-0">Appointment Reason Management</h3>
            <Button onClick={showCreateDialog}>+ Add Appointment Reason</Button>
         </div>
         <div className="mb-3">
            <Table className="table-primary" dataSource={dataSource} columns={columns} />
         </div>
         <AppointmentRequestManage />
         <Modal title="Create Appointment Reason" visible={visible} onCancel={handleCancel} footer={null}>
            <AppointmentReasonForm reload={handleGetAppointmentReson} />
         </Modal>
      </div>
   );
}
