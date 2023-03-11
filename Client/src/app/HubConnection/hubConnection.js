import { HubConnectionBuilder } from '@microsoft/signalr';

const connection = new HubConnectionBuilder()
   .withUrl('http://localhost:5000/Chat', {
      accessTokenFactory: () => `${localStorage.getItem('access_token')}`
   })
   .withAutomaticReconnect()
   .build();

connection.start().then(async () => {
   console.log('Connected!');

   await connection.invoke('GetUserOnline');
});

export default connection;
