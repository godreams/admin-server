import React from 'react'
import ReactDOM from 'react-dom'
import Routes from 'components/Routes'
import {observable} from 'mobx'
import {Provider} from 'mobx-react'

import 'grommet/scss/vanilla/index'

const appState = observable({
  authorization: {
    token: null,
    loginFailureMessage: null,
    currentUserName: null,
    currentUserRoles: [],
    random: 'random'
  }
})

ReactDOM.render(
  <Provider appState={appState}>
    <Routes />
  </Provider>, document.getElementById('root')
)
