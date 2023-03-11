import { CloseCircleOutlined, SaveOutlined } from '@ant-design/icons';
import { Button, Form, Select } from 'antd';
import Input from 'antd/lib/input/Input';
import React, { useState } from 'react';
import { toast } from 'react-toastify';
import appointmentResonService from '../services/appointmentService';

export default function AppointmentReasonForm({ reload }) {
   const [inputs, setInputs] = useState([{}]);
   const [errors, setErrors] = useState({});
   const [form] = Form.useForm();

   const options = [];

   for (let i = 1; i <= 24; i++) {
      options.push(<Select.Option key={`${i} hour`}>{`${i} hour${i > 1 ? 's' : ''}`}</Select.Option>);
   }
   for (let i = 1; i <= 4; i++) {
      options.push(<Select.Option key={`${i} day`}>{`${i} day${i > 1 ? 's' : ''}`}</Select.Option>);
   }
   const handleAddInput = () => {
      setInputs([...inputs, { value: '', isEditing: true }]);
   };
   const handleRemoveInputCreate = index => {
      const newInputs = [...inputs];
      newInputs.splice(index, 1);
      setInputs(newInputs);
   };
   const handleSubmit = async values => {
      try {
         const response = await appointmentResonService.createAppointmentResons(
            Object.values(values).map(item => ({ name: item }))
         );
         form.resetFields();
         setInputs([{}]);
         setErrors({});
         reload();
         toast(response.data.message, { type: 'success', autoClose: 2000 });
      } catch (error) {
         setErrors(error.response?.data?.errors);
         toast(error.response?.data?.message, { type: 'error', autoClose: 2000 });
      }
   };
   return (
      <div>
         <div className="mb-3">
            <Form onFinish={handleSubmit} form={form}>
               {inputs.map((input, index) => {
                  return (
                     <div key={index}>
                        <div className="flex gap-3 mb-3">
                           <Form.Item
                              className="w-full m-0"
                              name={`AppointmentReason[${index}]`}
                              validateStatus={errors[`AppointmentReason[${index}]`] ? 'error' : ''}
                              help={errors[`AppointmentReason[${index}]`]}
                           >
                              <Input value={input.value} className="py-2" placeholder={`Reason ${index + 1}`} />
                           </Form.Item>
                           <Button
                              onClick={() => handleRemoveInputCreate(index)}
                              type="danger"
                              className="border-none text-white hover:text-white py-2"
                              style={{ height: '100%' }}
                           >
                              <CloseCircleOutlined />
                           </Button>
                        </div>
                     </div>
                  );
               })}
               <div className="flex gap-3 justify-center">
                  <Button onClick={handleAddInput} className="mt-3" type="primary" shape="round">
                     Add Input +
                  </Button>
                  <Button className="mt-3" type="primary" shape="round" htmlType="submit">
                     <SaveOutlined />
                     Create
                  </Button>
               </div>
            </Form>
         </div>
      </div>
   );
}
