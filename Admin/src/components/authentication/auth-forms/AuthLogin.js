import Link from 'Link';
import PropTypes from 'prop-types';
import React from 'react';

// material-ui
import {
   Box,
   Button,
   Checkbox,
   Divider,
   FormControl,
   FormControlLabel,
   FormHelperText,
   Grid,
   IconButton,
   InputAdornment,
   InputLabel,
   OutlinedInput,
   Stack,
   Typography,
   useMediaQuery
} from '@mui/material';
import { useTheme } from '@mui/material/styles';

// third party
import { Formik } from 'formik';
import * as Yup from 'yup';

// project imports
import AnimateButton from 'components/ui-component/extended/AnimateButton';
import useAuth from 'hooks/useAuth';
import useConfig from 'hooks/useConfig';
import useScriptRef from 'hooks/useScriptRef';

// assets
import Visibility from '@mui/icons-material/Visibility';
import VisibilityOff from '@mui/icons-material/VisibilityOff';

const Google = '/assets/images/icons/google.svg';

// ============================|| FIREBASE - LOGIN ||============================ //

const Login = ({ loginProp, ...others }) => {
   const theme = useTheme();
   const scriptedRef = useScriptRef();

   const { login } = useAuth();
   const [showPassword, setShowPassword] = React.useState(false);
   const handleClickShowPassword = () => {
      setShowPassword(!showPassword);
   };

   const handleMouseDownPassword = event => {
      event.preventDefault();
   };

   return (
      <>
         <Grid container direction="column" justifyContent="center" spacing={2}>
            <Grid item xs={12}>
               <Box
                  sx={{
                     alignItems: 'center',
                     display: 'flex'
                  }}
               >
                  <Divider sx={{ flexGrow: 1 }} orientation="horizontal" />
               </Box>
            </Grid>
         </Grid>

         <Formik
            initialValues={{
               username: '',
               password: '',
               submit: null
            }}
            validationSchema={Yup.object().shape({
               username: Yup.string().required('Username is required'),
               password: Yup.string().max(255).required('Password is required')
            })}
            onSubmit={async (values, { setErrors, setStatus, setSubmitting }) => {
               try {
                  await login(values.username, values.password).then(
                     () => {
                        // WARNING: do not set any formik state here as formik might be already destroyed here. You may get following error by doing so.
                        // Warning: Can't perform a React state update on an unmounted component. This is a no-op, but it indicates a memory leak in your application.
                        // To fix, cancel all subscriptions and asynchronous tasks in a useEffect cleanup function.
                        // github issue: https://github.com/formium/formik/issues/2430
                     },
                     err => {
                        if (scriptedRef.current) {
                           setStatus({ success: false });
                           setErrors({ submit: err.message });
                           setSubmitting(false);
                        }
                     }
                  );
               } catch (err) {
                  console.error(err);
                  if (scriptedRef.current) {
                     setStatus({ success: false });
                     setErrors({ submit: err.message });
                     setSubmitting(false);
                  }
               }
            }}
         >
            {({ errors, handleBlur, handleChange, handleSubmit, isSubmitting, touched, values }) => (
               <form noValidate onSubmit={handleSubmit} {...others}>
                  <FormControl
                     fullWidth
                     error={Boolean(touched.username && errors.username)}
                     sx={{ ...theme.typography.customInput }}
                  >
                     <InputLabel htmlFor="outlined-adornment-email-login">Username</InputLabel>
                     <OutlinedInput
                        id="outlined-adornment-email-login"
                        type="email"
                        value={values.username}
                        name="username"
                        onBlur={handleBlur}
                        onChange={handleChange}
                        label="Username"
                        inputProps={{}}
                     />
                     {touched.username && errors.username && (
                        <FormHelperText error id="standard-weight-helper-text-email-login">
                           {errors.username}
                        </FormHelperText>
                     )}
                  </FormControl>

                  <FormControl
                     fullWidth
                     error={Boolean(touched.password && errors.password)}
                     sx={{ ...theme.typography.customInput }}
                  >
                     <InputLabel htmlFor="outlined-adornment-password-login">Password</InputLabel>
                     <OutlinedInput
                        id="outlined-adornment-password-login"
                        type={showPassword ? 'text' : 'password'}
                        value={values.password}
                        name="password"
                        onBlur={handleBlur}
                        onChange={handleChange}
                        endAdornment={
                           <InputAdornment position="end">
                              <IconButton
                                 aria-label="toggle password visibility"
                                 onClick={handleClickShowPassword}
                                 onMouseDown={handleMouseDownPassword}
                                 edge="end"
                                 size="large"
                              >
                                 {showPassword ? <Visibility /> : <VisibilityOff />}
                              </IconButton>
                           </InputAdornment>
                        }
                        label="Password"
                        inputProps={{}}
                     />
                     {touched.password && errors.password && (
                        <FormHelperText error id="standard-weight-helper-text-password-login">
                           {errors.password}
                        </FormHelperText>
                     )}
                  </FormControl>
                  {errors.submit && (
                     <Box sx={{ mt: 3 }}>
                        <FormHelperText error>{errors.submit}</FormHelperText>
                     </Box>
                  )}

                  <Box sx={{ mt: 2 }}>
                     <AnimateButton>
                        <Button
                           disableElevation
                           disabled={isSubmitting}
                           fullWidth
                           size="large"
                           type="submit"
                           variant="contained"
                           color="secondary"
                        >
                           Sign in
                        </Button>
                     </AnimateButton>
                  </Box>
               </form>
            )}
         </Formik>
      </>
   );
};

Login.propTypes = {
   loginProp: PropTypes.number
};

export default Login;
