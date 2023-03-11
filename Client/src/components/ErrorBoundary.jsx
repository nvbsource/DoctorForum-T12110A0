import React from 'react';

export class ErrorBoundary extends React.Component {
   constructor(props) {
      super(props);
      this.state = { hasError: false, error: null, info: null };
   }
   static getDerivedStateFromError(error) {
      return { hasError: true, error };
   }

   componentDidCatch(error, info) {
      this.setState({ info });
   }

   render() {
      if (this.state.hasError) {
         return (
            <>
               <div id="error-page">
                  <h1>Oops!</h1>
                  <p>Sorry, an unexpected error has occurred.</p>
                  <p>{this.state.info?.componentStack}</p>
               </div>
            </>
         );
      }
      return this.props.children;
   }
}
