import React from 'react'
import App from 'grommet/components/App'
import LoginForm from 'grommet/components/LoginForm'
import Box from 'grommet/components/Box'
import 'grommet/scss/vanilla/index'
import LoginService from 'LoginService'
import Devtools from 'mobx-react-devtools'
import {observable} from 'mobx';
import {observer, inject} from 'mobx-react';
import AppStateService from 'AppStateService'

@inject('appState') @observer
class Login extends React.Component {
  constructor (props) {
    super(props)

    this.attemptLogin = this.attemptLogin.bind(this)
  }

  componentDidMount () {
    AppStateService.loadState(this)

    if (typeof(this.props.appState.authorization.token) === 'string') {
      this.props.router.push('/dashboard')
    }
  }

  attemptLogin (data) {
    let loginService = new LoginService()
    let that = this

    loginService.fetch(data.username, data.password).then(function (response) {
      that.props.appState.authorization.token = response.auth_token
      that.props.appState.authorization.loginFailureMessage = null
      that.props.appState.authorization.currentUserName = response.name
      that.props.appState.authorization.currentUserRole = response.role
      window.localStorage.authorizationToken = response.auth_token
      that.props.router.push('/dashboard')
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
        <Devtools />
        <Box align='center'>
          <LoginForm onSubmit={this.attemptLogin} title='GoDreams' secondaryText='Administration Interface'
            errors={ this.errors() } rememberMe />
        </Box>
      </App>
    )
  }
}

export default Login
