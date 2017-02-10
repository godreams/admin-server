import React from 'react'
import {Router, Route, browserHistory} from 'react-router'

import Dashboard from 'components/Dashboard'
import Login from 'components/Login'

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
