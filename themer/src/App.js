import React from 'react';
import Iframe from 'react-iframe'
import RightPanel from './components/RightPanel'
import './App.css';

function App() {
  return (
    <React.Fragment>
      <Iframe url="https://localhost:9443/devportal"
        width="100%"
        height="100vh"
        id="myId"
        className="myClassname"
        display="initial"
        position="relative"
        frameBorder={0}
        />
      <RightPanel />
    </React.Fragment>
  );
}

export default App;
