import React from 'react'
import ReactDOM from 'react-dom'
import Routes from 'Routes'
import {observable} from 'mobx'
import {Provider} from 'mobx-react'

const appState = observable({
  authorization: {
    token: null,
    loginFailureMessage: null,
    currentUserName: null,
    currentUserRole: null
  }
})

ReactDOM.render(
  <Provider appState={appState}>
    <Routes />
  </Provider>, document.getElementById('root')
)
