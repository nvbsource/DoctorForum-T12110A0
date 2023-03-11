import 'antd/dist/antd.min.css';
import React, { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Navigate, Outlet, Route, Routes } from 'react-router-dom';
import 'swiper/css';
import 'swiper/css/autoplay';
import 'swiper/css/grid';
import {
   deleteUserOnline,
   loginSuccess,
   pushUserOnline,
   selectIsAuthenticatedAuth,
   selectUserAuth,
   setUserOnline
} from './app/features/auth/authSlice';
import { getRoom, pushContentChat } from './app/features/chat/chatSlice';
import connection from './app/HubConnection/hubConnection';
import AuthenticateRoute from './components/AuthenticateRoute';
import DefaultLayout from './components/DefaultLayout/DefaultLayout';
import DefaultOnlyHeader from './components/DefaultLayout/DefaultOnlyHeader';
import DetailPost from './components/Posts/DetailPost';
import EditPost from './components/Posts/EditPost';
import PrivateRoute from './components/PrivateRoute';
import ChatPage from './routes/ChatPage';
import ConfirmPasswordPage from './routes/ConfirmPasswordPage';
import FindDoctor from './routes/FindDoctor';
import ForgotPasswordPage from './routes/ForgotPasswordPage';
import HomePage from './routes/HomePage';
import PostInTopicPage from './routes/PostInTopicPage';
import DefaultProfilePage from './routes/Profile/DefaultProfilePage';
import ProfileDoctor from './routes/Profile/ProfileDoctor';
import Appointment from './routes/Profile/Services/Appointment';
import AppointmentManagement from './routes/Profile/Services/AppointmentManagement';
import Specialty from './routes/Profile/Services/Specialty';
import PersonalInformation from './routes/Profile/Settings/PersonalInformation';
import SecuritySettings from './routes/Profile/Settings/SecuritySettings';
import SingInPage from './routes/SignInPage';
import SignUpPage from './routes/SignUpPage';
import authService from './services/authService';
import { audioNewMessage } from './utils/function';

function App() {
   const dispatch = useDispatch();
   const access_token = localStorage.getItem('access_token');
   const userLogin = useSelector(selectUserAuth);
   const isLogin = useSelector(selectIsAuthenticatedAuth);
   useEffect(() => {
      if (isLogin) {
         connection.on('newMessage', message => {
            console.log(message);
            if (!message?.isYou) {
               audioNewMessage();
            }
            dispatch(pushContentChat(message));
            dispatch(getRoom());
         });
         connection.on('onError', message => {
            console.log('Received error: ', JSON.stringify(message));
         });
         connection.on('UserOnline', user => {
            if (Array.isArray(user)) {
               console.log(user.map(item => item.id) + ' =====> online array');
               dispatch(setUserOnline(user));
            } else {
               console.log(user.id + ' =====> online');
               dispatch(pushUserOnline(user));
            }
         });
         connection.on('UserOffline', user => {
            console.log(user.id + ' =====> offline');
            dispatch(deleteUserOnline(user));
         });
      }
   }, [dispatch, isLogin]);

   useEffect(() => {
      (async () => {
         if (access_token) {
            try {
               const user = await authService.getProfile();
               dispatch(loginSuccess(user.data.result));
            } catch (error) {}
         }
         document.body.classList.add('loaded');
      })();
   }, [dispatch, access_token]);
   return (
      <>
         <Routes>
            <Route
               path="/"
               element={
                  <DefaultLayout>
                     <HomePage />
                  </DefaultLayout>
               }
            />
            <Route
               path="posts"
               element={
                  <DefaultLayout>
                     <Outlet />
                  </DefaultLayout>
               }
            >
               <Route path=":topicParentId" element={<PostInTopicPage />} />
               <Route path="detail/:postId" element={<DetailPost />} />
               <Route path="edit/:postId" element={<EditPost />} />
            </Route>
            <Route
               path="profile"
               element={
                  <DefaultLayout>
                     <PrivateRoute>
                        <DefaultProfilePage />
                     </PrivateRoute>
                  </DefaultLayout>
               }
            >
               <Route index element={<Navigate to="settings/personal-information" />}></Route>
               <Route path="settings">
                  <Route index element={<Navigate to="personal-information" />}></Route>
                  <Route path="personal-information" element={<PersonalInformation />}></Route>
                  <Route path="security-settings" element={<SecuritySettings />}></Route>
               </Route>
               <Route path="services">
                  <Route path="appointment" element={<Appointment />}></Route>
                  <Route path="appointment-management" element={<AppointmentManagement />}></Route>
                  <Route path="specialty-management" element={<Specialty />}></Route>
               </Route>
            </Route>
            <Route
               path="messages"
               element={
                  <DefaultOnlyHeader>
                     <PrivateRoute>
                        <ChatPage />
                     </PrivateRoute>
                  </DefaultOnlyHeader>
               }
            >
               <Route path=":id" element={<ChatPage />} />
            </Route>
            <Route
               path="/signup"
               element={
                  <AuthenticateRoute>
                     <DefaultLayout>
                        <SignUpPage />
                     </DefaultLayout>
                  </AuthenticateRoute>
               }
            />
            <Route
               path="/signin"
               element={
                  <AuthenticateRoute>
                     <DefaultLayout>
                        <SingInPage />
                     </DefaultLayout>
                  </AuthenticateRoute>
               }
            />
            <Route
               path="/forgot-password"
               element={
                  <AuthenticateRoute>
                     <DefaultLayout>
                        <ForgotPasswordPage />
                     </DefaultLayout>
                  </AuthenticateRoute>
               }
            />
            <Route
               path="/confirm-password"
               element={
                  <AuthenticateRoute>
                     <DefaultLayout>
                        <ConfirmPasswordPage />
                     </DefaultLayout>
                  </AuthenticateRoute>
               }
            />
            <Route
               path="/finddoctor"
               element={
                  <DefaultLayout>
                     <FindDoctor />
                  </DefaultLayout>
               }
            />
            <Route
               path="/profile/:userId"
               element={
                  <DefaultLayout>
                     <ProfileDoctor />
                  </DefaultLayout>
               }
            />
         </Routes>
         <div id="loader-wrapper">
            <div id="loader"></div>
            <div className="loader-section section-left"></div>
            <div className="loader-section section-right"></div>
         </div>
      </>
   );
}

export default App;
