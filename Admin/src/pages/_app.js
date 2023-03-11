// global styles
import PropTypes from 'prop-types';

// third-party
import { Provider } from 'react-redux';

// styles
import 'scss/style.scss';
import 'styles/globals.css';

// project import
import Snackbar from 'components/ui-component/extended/Snackbar';
import Locales from 'components/ui-component/Locales';
import RTLLayout from 'components/ui-component/RTLLayout';
import { ConfigProvider } from 'contexts/ConfigContext';
import NavigationScroll from 'layout/NavigationScroll';
import { store } from 'store';
import ThemeCustomization from 'themes';

// import { Auth0Provider as AuthProvider } from '../contexts/Auth0Context';
import { JWTProvider as AuthProvider } from 'contexts/JWTContext';
// import { AWSCognitoProvider as AuthProvider } from 'contexts/AWSCognitoContext';

const Noop = ({ children }) => <> {children} </>;

Noop.propTypes = {
   children: PropTypes.node
};

// ==============================|| APP ||============================== //

function App({ Component, pageProps }) {
   const getLayout = Component.getLayout ?? (page => page);

   return (
      <Provider store={store}>
         <ConfigProvider>
            <ThemeCustomization>
               <RTLLayout>
                  <Locales>
                     <NavigationScroll>
                        <AuthProvider>
                           <>
                              {getLayout(<Component {...pageProps} />)}
                              <Snackbar />
                           </>
                        </AuthProvider>
                     </NavigationScroll>
                  </Locales>
               </RTLLayout>
            </ThemeCustomization>
         </ConfigProvider>
      </Provider>
   );
}

App.propTypes = {
   Component: PropTypes.func,
   pageProps: PropTypes.object
};

export default App;
