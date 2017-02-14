import React from 'react'
import {observable} from 'mobx'
import {observer, inject} from 'mobx-react'

import App from 'grommet/components/App'
import LoginForm from 'grommet/components/LoginForm'
import Box from 'grommet/components/Box'

import SessionService from 'services/SessionService'
import LoginService from 'services/LoginService'

@inject('appState') @observer
class Login extends React.Component {
  constructor (props) {
    super(props);

    this.attemptLogin = this.attemptLogin.bind(this)
  }

  componentWillMount() {
    if (SessionService.isAuthorized(this)) {
      this.props.router.push('/dashboard')
    } else if (SessionService.isStored()) {
      this.props.router.push('/')
    }
  }

  attemptLogin (data) {
    let loginService = new LoginService()
    let that = this

    loginService.fetch(data.username, data.password).then(function (response) {
      SessionService.store(response, that)
      that.props.router.push('/')
    }).catch(function (response) {
      console.log(response.code)
      that.props.appState.authorization.loginFailureMessage = response.message
    })
  }

  errors () {
    if (this.props.appState.authorization.loginFailureMessage) {
      return [this.props.appState.authorization.loginFailureMessage]
    } else {
      return []
    }
  }

  render () {
    return (
      <App centered={false}>
        <Box align='center'>
          <LoginForm onSubmit={this.attemptLogin} title='GoDreams' secondaryText='Administration Interface'
            errors={ this.errors() } rememberMe />
        </Box>
      </App>
    )
  }
}

export default Login
