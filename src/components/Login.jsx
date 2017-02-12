import React from 'react'
import App from 'grommet/components/App'
import LoginForm from 'grommet/components/LoginForm'
import Box from 'grommet/components/Box'
import 'grommet/scss/vanilla/index'
import LoginService from 'services/LoginService'
import {observable} from 'mobx'
import {observer, inject} from 'mobx-react'
import SessionStorageService from 'services/SessionStorageService'

@inject('appState') @observer
class Login extends React.Component {
  constructor (props) {
    super(props);

    this.attemptLogin = this.attemptLogin.bind(this)
  }

  componentWillMount () {
    let authorized = SessionStorageService.authorized(this)
    console.log('authorized:' + authorized)

    // redirect to dashboard if already authorized
    if (authorized) {
      this.props.router.push('/dashboard')
    }
  }

  attemptLogin (data) {
    let loginService = new LoginService()
    let that = this

    loginService.fetch(data.username, data.password).then(function (response) {
      SessionStorageService.store(response, that)
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
        <Box align='center'>
          <LoginForm onSubmit={this.attemptLogin} title='GoDreams' secondaryText='Administration Interface'
            errors={ this.errors() } rememberMe />
        </Box>
      </App>
    )
  }
}

export default Login
