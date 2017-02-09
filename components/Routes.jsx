import React from 'react'
import {Router, Route, browserHistory} from 'react-router'

import Dashboard from 'Dashboard'
import Login from 'Login'

export default class Routes extends React.Component {
  render () {
    return (
      <Router history={browserHistory}>
        <Route path='/' component={Login} />
        <Route path='dashboard' component={Dashboard} />
      </Router>
    )
  }
}
