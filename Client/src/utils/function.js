import { toast } from 'react-toastify';
import moment from 'moment';
import file from '../assets/audio/message.mp3';
export const findUserOnlineByUserId = ({ usersOnline, userId }) => {
   return usersOnline.some(item => item.id === userId);
};
export const findUserReceiverByLogin = ({ users, userIdLogin }) => {
   return users.find(item => item !== userIdLogin);
};
export const audioNewMessage = () => {
   const audio = new Audio(file);
   audio.addEventListener('canplaythrough', event => {
      audio.play();
   });
};
export const beforeUploadImage = file => {
   const isJpgOrPng = file.type === 'image/jpeg' || file.type === 'image/png';
   if (!isJpgOrPng) {
      toast.error('You can only upload JPG/PNG file!');
   }
   const isLt2M = file.size / 1024 / 1024 < 2;
   if (!isLt2M) {
      toast.error('Image must smaller than 2MB!');
   }
   return isJpgOrPng && isLt2M;
};

export const printDistance = distance => {
   const distanceInFeet = Math.round(distance * 3.28084 * 10000);
   const distanceInMeters = Math.round(distance * 1000);
   const distanceInKm = distance.toFixed(1);
   if (distanceInFeet < 4) {
      return `${distanceInFeet} step`;
   } else if (distanceInMeters < 1000) {
      return `${distanceInMeters} meters`;
   } else {
      return `${distanceInKm} kilometer`;
   }
};
export const objectToQueryString = obj => {
   const parts = [];
   for (let i in obj) {
      if (obj[i]) {
         parts.push(encodeURIComponent(i) + '=' + encodeURIComponent(obj[i]));
      }
   }
   return parts.join('&');
};

export const sliceString = (string, length, suffixes) => {
   let newString = string;
   if (string?.length > length) {
      newString = string.slice(0, length).trim() + suffixes;
   }
   return newString;
};

export const getTimeElapsed = datetimeString => {
   const datetime = moment(datetimeString);
   const now = moment();
   const diffSeconds = now.diff(datetime, 'seconds');
   if (diffSeconds < 60) {
      return 'Just Posted';
   } else if (diffSeconds < 3600) {
      const diffMinutes = Math.floor(diffSeconds / 60);
      return `${diffMinutes} Minute${diffMinutes > 1 ? 's' : ''} Ago`;
   } else if (diffSeconds < 86400) {
      const diffHours = Math.floor(diffSeconds / 3600);
      return `${diffHours} Hour${diffHours > 1 ? 's' : ''} Ago`;
   } else {
      const diffDays = Math.floor(diffSeconds / 86400);
      return `${diffDays} Day${diffDays > 1 ? 's' : ''} Ago`;
   }
};
export const normFile = e => {
   if (Array.isArray(e)) {
      return e;
   }
   return e && e.fileList;
};
export const getBase64 = (img, callback) => {
   const reader = new FileReader();
   reader.addEventListener('load', () => callback(reader.result));
   reader.readAsDataURL(img);
};

export function formatDateTime(dateTimeStr) {
   const formattedDateTime = moment(dateTimeStr).format('DD/MM/YYYY HH:mm:ss');
   return formattedDateTime;
}
