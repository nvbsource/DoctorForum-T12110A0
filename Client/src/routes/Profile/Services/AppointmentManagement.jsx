import { DownOutlined, InfoCircleOutlined } from '@ant-design/icons';
import { Badge, Button, DatePicker, Dropdown, Form, Input, Modal, Radio, Space, Table, TimePicker } from 'antd';
import { useForm } from 'antd/lib/form/Form';
import TextArea from 'antd/lib/input/TextArea';
import moment from 'moment';
import React, { useEffect, useState } from 'react';
import { toast } from 'react-toastify';
import appointmentResonService from '../../../services/appointmentService';
import axiosInstance from '../../../services/AxiosInstance';
import { formatDateTime } from '../../../utils/function';
import 'moment-timezone';
export default function AppointmentManagement() {
   const [appointments, setAppointments] = useState([]);
   const [appointmentDetail, setAppointmentDetail] = useState({});
   const [open, setOpen] = useState(false);
   const [openEdit, setOpenEdit] = useState(false);
   const [form] = useForm();
   const [requiredMark, setRequiredMarkType] = useState('accept');
   useEffect(() => {
      handleGetAppointment();
   }, []);
   const handleGetAppointment = async () => {
      const { data } = await appointmentResonService.getAppointment();
      if (data.code === 200) {
         setAppointments(data.result);
      }
   };
   const onRequiredTypeChange = (e) => {
      setRequiredMarkType(e.target.value);
   };
   const columns = [
      {
         title: 'Day',
         dataIndex: 'day',
         key: 'day',
         sorter: (a, b) => moment(new Date(a.date)).unix() - moment(new Date(b.date)).unix()
      },
      {
         title: 'Number Appointment',
         dataIndex: 'numberAppointment',
         key: 'numberAppointment',
         sorter: (a, b) => a.numberAppointment - b.numberAppointment
      },
      {
         title: 'Number Pending',
         dataIndex: 'numberPending',
         key: 'numberPending',
         sorter: (a, b) => a.numberPending - b.numberPending
      }
   ];

   const expandedRowRender = _record => {
      const items = [{ key: '1', label: 'Send Email' }];
      const columns = [
         { title: 'Created At', dataIndex: 'createdAt', key: 'createdAt' },
         { title: 'Arrival Time', dataIndex: 'arrivalTime', key: 'arrivalTime' },
         { title: 'Name', dataIndex: 'name', key: 'name' },
         { title: 'Phone', dataIndex: 'phone', key: 'phone' },
         { title: 'Reason', dataIndex: 'reason', key: 'reason' },
         // {
         //    title: 'Status',
         //    key: 'state',
         //    render: _record => {
         //       switch (_record.status) {
         //          case 'pending':
         //             return <Badge status="error" text="Un finished" />;
         //          case 'success':
         //             return <Badge status="success" text="Finished" />;
         //          default:
         //             return <Badge status="error" text="Unknown" />;
         //       }
         //    }
         // },
         {
            title: 'Action',
            dataIndex: 'operation',
            key: 'operation',
            render: (index, _record) => (
               <Space size="middle">
                  <Button
                     className="rounded-full"
                     type="primary"
                     onClick={() => {
                        setAppointmentDetail(_record);
                        setOpen(true);
                     }}
                  >
                     Detail
                  </Button>
                  {
                     _record.status === "pending" && <Button
                        className="rounded-full"
                        type="primary"
                        onClick={() => {
                           setAppointmentDetail(_record);
                           setOpenEdit(true);
                        }}
                     >
                        Browse
                     </Button>
                  }
                  {
                     _record.status === "cancel" && <Button
                        className="rounded-full bg-[red]"
                     >
                        Cancel
                     </Button>
                  }
                  {
                     _record.status === "accept" && <Button
                        className="rounded-full bg-[#00f0a4]"
                     >
                        Accept
                     </Button>
                  }
               </Space>
            )
         }
      ];
      const data = _record.listAppointments.map(item => ({
         ...item,
         key: item.id.toString(),
         createdAt: formatDateTime(item.created_at),
         arrivalTime: moment(item.startDate).format('YYYY/MM/DD'),
         phone: item.phone,
         name: item.fullName,
         reason: item.appointmentReason.name
      }));
      return <Table className="table-dark" columns={columns} dataSource={data} pagination={false} />;
   };
   const handleSubmitEdit = async (values) => {
      try {
         const { data } = await axiosInstance.put(`/Appointment/${appointmentDetail?.id}/updateState`, {
            status: requiredMark,
            timeStart: moment.tz(values.timeStart?.format('YYYY/MM/DD HH:mm:ss'), 'Asia/Ho_Chi_Minh')?.clone(),
            commentAdmin: values.commentAdmin
         });
         if (data?.code === 200) {
            handleGetAppointment();
            setOpenEdit(false);
            toast(data.message, { type: 'success', autoClose: 2000 });
         } else {
            toast(data.message, { type: 'error', autoClose: 2000 });
         }
      } catch (error) {
         toast(error.message, { type: 'error', autoClose: 2000 });
      }
   }
   return (
      <div>
         <Table
            className="table-primary"
            columns={columns}
            expandable={{ expandedRowRender }}
            rowClassName={(_record, index) => (_record.day === moment().format('YYYY/MM/DD') ? 'bg-[#eee]' : '')}
            dataSource={appointments.map((item, index) => ({
               key: `${index}-${item.startDate}`,
               day: moment(item.startDate).format('YYYY/MM/DD'),
               numberAppointment: item.numberAppointment,
               numberPending: item.numberPending,
               listAppointments: item.listAppointments
            }))}
         />
         <Modal title="Detail Appointment" open={open} onCancel={() => setOpen(false)} footer={null}>
            <Form className="w-full" layout="vertical">
               <Form.Item label="Full Name">
                  <Input value={appointmentDetail.fullName} disabled />
               </Form.Item>
               <Form.Item label="Email Address">
                  <Input value={appointmentDetail.email} disabled />
               </Form.Item>
               <Form.Item label="Phone Number">
                  <Input value={appointmentDetail.phone} disabled />
               </Form.Item>
               <Form.Item label="Start Date">
                  <DatePicker className="w-full" value={moment(appointmentDetail.startDate)} disabled />
               </Form.Item>
               <Form.Item label="Reason">
                  <Input value={appointmentDetail.appointmentReason?.name} disabled />
               </Form.Item>
               <Form.Item label="Other">
                  <TextArea rows={4} disabled value={appointmentDetail.other} />
               </Form.Item>
            </Form>
         </Modal>
         <Modal title="Update appointment status" open={openEdit} onCancel={() => setOpenEdit(false)} footer={null}>
            <Form
               form={form}
               layout="vertical"
               requiredMark={requiredMark}
               onFinish={handleSubmitEdit}
            >
               <Form.Item label="State" name="requiredMarkValue">
                  <Radio.Group onChange={onRequiredTypeChange} defaultValue={requiredMark}>
                     <Radio.Button value="accept">Accept</Radio.Button>
                     <Radio.Button value="cancel">Cancel</Radio.Button>
                  </Radio.Group>
               </Form.Item>
               {requiredMark === 'accept' && (
                  <Form.Item
                     name="timeStart"
                     label="Time Start"
                     required
                     tooltip="This is a required field"
                     rules={[{ required: true, message: 'Please choose time start' }]}
                  >
                     <TimePicker format={'HH:mm'} className="w-full" />
                  </Form.Item>
               )}
               <Form.Item
                  label="Other"
                  name="commentAdmin"
                  tooltip={{ title: 'Message content for patients', icon: <InfoCircleOutlined /> }}
               >
                  <Input placeholder="Message content for patients" />
               </Form.Item>
               <Form.Item>
                  <Button type="primary" htmlType='submit'>Submit</Button>
               </Form.Item>
            </Form>
         </Modal>
      </div>
   );
}
