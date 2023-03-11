import { DeleteOutlined, EditOutlined, SaveOutlined } from '@ant-design/icons';
import { Button, Modal, Switch, Table } from 'antd';
import Input from 'antd/lib/input/Input';
import React, { useEffect, useState } from 'react';
import { toast } from 'react-toastify';
import authService from '../services/authService';
export default function AppointmentRequestManage() {
   const [emails, setEmails] = useState([]);
   const [inputEmail, setInputEmail] = useState(null);
   const [statusEmail, setStatusEmail] = useState(true);
   const [visibleCreateEmail, setVisibleCreateEmail] = useState(false);
   useEffect(() => {
      handleGetEmails();
   }, []);

   const getIndex = key => key.split('-')[1];
   const columns = [
      {
         title: 'Email',
         dataIndex: 'email',
         render: (_, record) => (
            <Input
               disabled={!record.isEditing}
               defaultValue={record.name}
               onChange={e => handleChangeEmail(e.target.value, getIndex(record.key))}
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
                     onClick={() => handleSaveEmail(getIndex(record.key))}
                  >
                     Save
                  </Button>
               ) : (
                  <Button
                     type="primary"
                     className="rounded-full"
                     icon={<EditOutlined />}
                     onClick={() => handleEditEmail(getIndex(record.key))}
                  >
                     Edit
                  </Button>
               )}
               <Button
                  className="ml-3 rounded-full"
                  type="primary"
                  danger
                  icon={<DeleteOutlined />}
                  onClick={() => handleRemoveEmail(getIndex(record.key))}
               >
                  Delete
               </Button>
            </>
         )
      }
   ];
   const handleRemoveEmail = async index => {
      try {
         const newEmails = [...emails];
         const item = newEmails[index];
         const response = await authService.deleteEmailReceiverRequest(item.id);
         newEmails.splice(index, 1);
         setEmails(newEmails);
         toast(response.data.message, { type: 'success', autoClose: 2000 });
      } catch (error) {
         toast(error.response?.data?.message, { type: 'error', autoClose: 2000 });
      }
   };
   const handleChangeEmail = (value, index) => {
      const newEmails = [...emails];
      newEmails[index].email = value;
      setEmails(newEmails);
   };

   const handleEditEmail = index => {
      const newEmails = [...emails];
      newEmails[index].isEditing = true;
      setEmails(newEmails);
   };

   const handleSaveEmail = async index => {
      try {
         const newEmails = [...emails];
         const item = newEmails[index];
         const response = await authService.updateEmailReceiverRequest({
            id: item.id,
            email: item.email,
            status: item.status
         });
         item.isEditing = false;
         setEmails(newEmails);
         toast(response.data.message, { type: 'success', autoClose: 2000 });
      } catch (error) {
         toast(error.response?.data?.message, { type: 'error', autoClose: 2000 });
      }
   };
   const dataSource = emails.map((item, index) => ({
      key: `${item.id}-${index}`,
      name: item.email,
      isEditing: item.isEditing
   }));
   const handleCreateEmail = async e => {
      e.preventDefault();
      try {
         const response = await authService.addEmailReceiverRequest({
            email: inputEmail,
            status: statusEmail
         });
         setInputEmail(null);
         setStatusEmail(true);
         handleGetEmails();
         handleCancelCreateEmail();
         toast(response.data.message, { type: 'success', autoClose: 2000 });
      } catch (error) {
         toast('Invalid data', { type: 'error', autoClose: 2000 });
      }
   };
   const handleCancelCreateEmail = () => {
      setVisibleCreateEmail(false);
   };
   const showCreateEmailialog = () => {
      setVisibleCreateEmail(true);
   };
   const handleGetEmails = async () => {
      const response = await authService.getEmailReceiverRequest();
      setEmails(response.data?.result.map(item => ({ ...item, isEditing: false })));
   };

   return (
      <div>
         <div className="flex justify-between items-center mb-3">
            <h3 className="font-bold mb-0">Appointment Request Notifications</h3>
            <Button onClick={showCreateEmailialog}>+ Add a Recipient</Button>
         </div>
         <Table className="table-primary" dataSource={dataSource} columns={columns} />
         <Modal title="Create Email" visible={visibleCreateEmail} onCancel={handleCancelCreateEmail} footer={null}>
            <form onSubmit={handleCreateEmail}>
               <div className="flex gap-3 mb-3 items-center">
                  <Input
                     value={inputEmail}
                     onChange={e => setInputEmail(e.target.value)}
                     className="py-2"
                     placeholder="Input email"
                  />
                  <Switch defaultChecked={statusEmail} onChange={value => setStatusEmail(value)} />
               </div>
               <div className="flex gap-3 justify-center">
                  <Button className="mt-3" type="primary" shape="round" htmlType="submit">
                     <SaveOutlined />
                     Create
                  </Button>
               </div>
            </form>
         </Modal>
      </div>
   );
}
