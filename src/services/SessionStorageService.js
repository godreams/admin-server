import ApiService from 'services/ApiService'

export default class SessionStorageService {
  static authorized (that) {
    console.log('Confirming authorization...')
    console.log('present token in appState: ' + that.props.appState.authorization.token)
    console.log('token in window local storage: ' + window.localStorage.authorizationToken)
    // check if localStorage has a token in it
    if (typeof(window.localStorage.authorizationToken) === 'string') {
      // pass authorization if appState already has a token
      if (typeof(that.props.appState.authorization.token) === 'string') {
        return true
      } else {
        // else populate the appState using the token from localStorage
        // TODO: fetch user info sending token
        let apiService = new ApiService(window.localStorage.authorizationToken)
        apiService.fetch('user').then((response) => {
          console.log('User info fetched')
          SessionStorageService.store(response.user, that)
        })
        return true
      }
    } else {
      // no token anywhere!
      return false
    }
  }

  static store (response, that) {
    console.log('Storing user info...')
    that.props.appState.authorization.token = response.auth_token
    that.props.appState.authorization.loginFailureMessage = null
    that.props.appState.authorization.currentUserName = response.name
    that.props.appState.authorization.currentUserRole = response.role
  }
}