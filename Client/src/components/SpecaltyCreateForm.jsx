import { SaveOutlined, UploadOutlined } from '@ant-design/icons';
import { Button, Form, Input, Modal, TreeSelect, Upload } from 'antd';
import React, { useEffect, useState } from 'react';
import { toast } from 'react-toastify';
import specialtyService from '../services/specialtyService';
import { normFile } from '../utils/function';

export default function SpecaltyCreateForm({ visible, handleCancel, inputSpecialty, setInputSpecialty, reload }) {
   const [specialties, setSpecialties] = useState([]);
   const [specialtiesSelect, setSpecialtiesSelect] = useState([]);

   useEffect(() => {
      const getSpecialties = async () => {
         try {
            const { data } = await specialtyService.getSpecialties();
            setSpecialties(data.result);
         } catch (error) {
            console.log(error);
         }
      };
      getSpecialties();
   }, []);
   useEffect(() => {
      setSpecialtiesSelect(
         specialties.map(item => ({
            value: item.id,
            title: item.name,
            children: item.subSpecialties?.map(subItem => ({ value: subItem.id, title: subItem.name }))
         }))
      );
   }, [specialties]);
   const handleSubmit = async values => {
      try {
         const { specialtyId, educational } = values;
         const response = await specialtyService.createSpecialtyDoctor({ specialtyId, educational });
         if (response.data.code === 200) {
            reload();
            toast(response.data.message, { type: 'success', autoClose: 2000 });
         } else {
            toast(response.data.message, { type: 'error', autoClose: 2000 });
         }
      } catch (error) {
         console.error(error);
         toast(error.response?.data?.message, { type: 'error', autoClose: 2000 });
      }
   };

   return (
      <Modal title="Create Specialty" visible={visible} onCancel={handleCancel} footer={null}>
         <Form onFinish={handleSubmit}>
            <Form.Item
               className="w-full m-0"
               name="specialtyId"
               rules={[{ required: true, message: 'Please choose specialty' }]}
            >
               <TreeSelect
                  showSearch
                  style={{ width: '100%' }}
                  value={inputSpecialty}
                  dropdownStyle={{ maxHeight: 400, overflow: 'auto' }}
                  placeholder="Please select"
                  allowClear
                  treeDefaultExpandAll
                  onChange={setInputSpecialty}
                  treeData={specialtiesSelect}
               />
            </Form.Item>
            <Form.Item
               className="w-full m-0"
               name="educational"
               rules={[{ required: true, message: 'Please input educational' }]}
            >
               <Input
                  bordered={false}
                  placeholder="Input Educational "
                  className="border border-solid border-[#ccc] mt-3"
               />
            </Form.Item>
            <div className="flex gap-3 justify-center">
               <Button className="mt-3" type="primary" shape="round" htmlType="submit">
                  <SaveOutlined />
                  Create
               </Button>
            </div>
         </Form>
      </Modal>
   );
}
