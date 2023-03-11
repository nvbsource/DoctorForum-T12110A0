import { DeleteOutlined, EditOutlined, UploadOutlined } from '@ant-design/icons';
import { Button, Table, TreeSelect, Upload } from 'antd';
import Input from 'antd/lib/input/Input';
import React, { useEffect, useState } from 'react';
import { toast } from 'react-toastify';
import SpecaltyCreateForm from '../../../components/SpecaltyCreateForm';
import authService from '../../../services/authService';
import axiosInstance from '../../../services/AxiosInstance';
import specialtyService from '../../../services/specialtyService';
export default function Specialty() {
   const [inputSpecialty, setInputSpecialty] = useState(false);
   const [visible, setVisible] = useState(false);
   const [specialtiesOfUser, setSpecialtiesOfUser] = useState([]);
   const [specialties, setSpecialties] = useState([]);

   useEffect(() => {
      const getSpecialties = async () => {
         try {
            const { data } = await specialtyService.getSpecialties();
            setSpecialties(
               data.result?.map(item => ({
                  value: item.id,
                  title: item.name,
                  children: item.subSpecialties?.map(subItem => ({ value: subItem.id, title: subItem.name }))
               }))
            );
         } catch (error) {
            console.log(error);
         }
      };

      getSpecialtiesOfDoctor();
      getSpecialties();
   }, []);
   const getSpecialtiesOfDoctor = async () => {
      try {
         const { data } = await specialtyService.getSpecialtiesDoctor();
         setSpecialtiesOfUser(data.result?.map(item => ({ ...item, isEditing: false })));
      } catch (error) {
         console.log(error);
      }
   };
   const getIndex = key => key.split('-')[1];
   const columns = [
      {
         title: 'Specialty',
         dataIndex: 'specialty',
         render: (_, record) => (
            <TreeSelect
               showSearch
               style={{ width: '100%' }}
               disabled
               dropdownStyle={{ maxHeight: 400, overflow: 'auto' }}
               placeholder="Please select"
               defaultValue={record.specialtyId}
               allowClear
               treeDefaultExpandAll
               onChange={value => handleChangeSpecialty(value, getIndex(record.key))}
               treeData={specialties}
            />
         )
      },
      {
         title: 'Education',
         dataIndex: 'education',
         render: (_, record) => (
            <Input
               disabled={!record.isEditing}
               defaultValue={record.educational}
               onChange={e => handleChangeSpecialty(e.target.value, getIndex(record.key))}
            />
         )
      },
      {
         title: 'Status',
         dataIndex: 'status',
         render: (_, record) => {
            switch (record.status) {
               case 'pending':
                  return 'Waiting to upload cv';
               case 'cancel':
                  return 'Canceled';
               case 'accept':
                  return 'Active';
               case 'checking':
                  return 'Checking CV';
               default:
                  return 'Unknown';
            }
         }
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
                     onClick={() => handleSaveSpecialty(getIndex(record.key))}
                  >
                     Save
                  </Button>
               ) : (
                  <Button
                     type="primary"
                     className="rounded-full"
                     icon={<EditOutlined />}
                     onClick={() => handleEditSpecialty(getIndex(record.key))}
                  ></Button>
               )}
               <Button
                  className="ml-3 rounded-full"
                  type="primary"
                  danger
                  icon={<DeleteOutlined />}
                  onClick={() => handleRemoveSpecialty(getIndex(record.key))}
               ></Button>
               {record.status !== "accept" && <Upload
                  accept=".doc,.docx"
                  className="ml-3"
                  showUploadList={false}
                  beforeUpload={async file => {
                     await uploadFileCV(getIndex(record.key), file);
                     return false;
                  }}
               >
                  <Button icon={<UploadOutlined />}>Upload CV File</Button>
               </Upload>}
            </>
         )
      }
   ];
   const handleRemoveSpecialty = async index => {
      try {
         const newSpecialtiesOfUser = [...specialtiesOfUser];
         const item = newSpecialtiesOfUser[index];
         const response = await specialtyService.deleteSpecialtyDoctor(item.id);
         newSpecialtiesOfUser.splice(index, 1);
         setSpecialtiesOfUser(newSpecialtiesOfUser);
         toast(response.data.message, { type: 'success', autoClose: 2000 });
      } catch (error) {
         toast(error.response?.data?.message, { type: 'error', autoClose: 2000 });
      }
   };
   const handleChangeSpecialty = (value, index) => {
      const newSpecialtiesOfUser = [...specialtiesOfUser];
      newSpecialtiesOfUser[index].educational = value;
      setSpecialtiesOfUser(newSpecialtiesOfUser);
   };

   const handleEditSpecialty = index => {
      const newSpecialtiesOfUser = [...specialtiesOfUser];
      newSpecialtiesOfUser[index].isEditing = true;
      setSpecialtiesOfUser(newSpecialtiesOfUser);
   };

   const handleSaveSpecialty = async index => {
      try {
         const newSpecialtiesOfUser = [...specialtiesOfUser];
         const item = newSpecialtiesOfUser[index];
         const response = await specialtyService.updateSpecialtyDoctor(item.id, item.educational);
         item.isEditing = false;
         setSpecialtiesOfUser(newSpecialtiesOfUser);
         toast(response.data.message, { type: 'success', autoClose: 2000 });
      } catch (error) {
         toast(error.response?.data?.message, { type: 'error', autoClose: 2000 });
      }
   };
   const dataSource = specialtiesOfUser.map((item, index) => ({
      key: `${item.id}-${index}`,
      specialtyId: item.specialty?.id,
      educational: item.educational,
      status: item.status,
      isEditing: item.isEditing
   }));
   const handleCancel = () => {
      setVisible(false);
   };
   const showDialog = () => {
      setVisible(true);
   };
   const uploadFileCV = async (index, file) => {
      const newSpecialtiesOfUser = [...specialtiesOfUser];
      const specialty = newSpecialtiesOfUser[index];
      const formData = new FormData();
      formData.append('file', file);
      try {
         const response = await axiosInstance.post(`/SpecialtyDoctor/${specialty.id}/uploadFileCV`, formData, {
            headers: {
               'Content-Type': 'multipart/form-data'
            }
         });
         getSpecialtiesOfDoctor();
         if(response.data.code === 200){
            toast(response.data.message, { type: 'success', autoClose: 2000 });
         }else{
            toast(response.data.message, { type: 'error', autoClose: 2000 });
         }
      } catch (error) {
         toast('Failed to upload file!', { type: 'error', autoClose: 2000 });
      }
   };
   return (
      <div>
         <div className="flex justify-between items-center mb-3">
            <h3 className="font-bold mb-0">Specialty management</h3>
            <Button onClick={showDialog}>+ Add a Specialty</Button>
         </div>
         <Table className="table-primary" dataSource={dataSource} columns={columns} />
         <SpecaltyCreateForm
            visible={visible}
            handleCancel={handleCancel}
            inputSpecialty={inputSpecialty}
            setInputSpecialty={setInputSpecialty}
            reload={getSpecialtiesOfDoctor}
         />
      </div>
   );
}
