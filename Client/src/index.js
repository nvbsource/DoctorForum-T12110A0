import 'antd/dist/antd.min.css';
import React from 'react';
import ReactDOM from 'react-dom/client';
import { Provider } from 'react-redux';
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { HistoryRouter as Router } from 'redux-first-history/rr6';
import 'swiper/css';
import 'swiper/css/autoplay';
import 'swiper/css/grid';
import App from './App';
import { history, store } from './app/store';
import { ErrorBoundary } from './components/ErrorBoundary';
import './index.css';

ReactDOM.createRoot(document.getElementById('root')).render(
   <Router history={history}>
      <Provider store={store}>
         <ErrorBoundary>
            <App />
            <ToastContainer />
         </ErrorBoundary>
      </Provider>
   </Router>
);
