import axios from 'axios';
import { toast } from 'react-toastify';
import { history } from '../app/store';

const axiosInstance = axios.create({
   baseURL: 'http://localhost:5000/api'
});

axiosInstance.interceptors.request.use(
   config => {
      const token = localStorage.getItem('access_token');
      if (token) {
         config.headers['Authorization'] = `Bearer ${token}`;
      }
      return config;
   },
   error => {
      return Promise.reject(error);
   }
);

axiosInstance.interceptors.response.use(
   response => response,
   error => {
      if (error.response.status === 401) {
         toast(error.response.data?.message, { type: 'error', autoClose: 2000 });
         localStorage.removeItem('access_token');
         history.push('/signin');
      }
      return Promise.reject(error);
   }
);

export default axiosInstance;
