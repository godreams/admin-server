import React from 'react'
import {Router, Route, browserHistory} from 'react-router'

import Loader from 'components/Loader'
import Login from 'components/Login'
import Dashboard from 'components/Dashboard'

export default class Routes extends React.Component {
  render () {
    return (
      <Router history={browserHistory}>
        <Route path='/' component={Loader} />
        <Route path='/login' component={Login} />
        <Route path='/dashboard' component={Dashboard} />
      </Router>
    )
  }
}
