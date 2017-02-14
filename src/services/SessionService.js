import ApiService from 'services/ApiService'

export default class SessionService {
  // Returns true if there is a token in storage.
  static isStored () {
    return typeof(window.localStorage.authorizationToken) === 'string'
  }

  static isAuthorized(that) {
    return (typeof(that.props.appState.authorization.token) === 'string')
  }

  // Attempt to load user credentials from storage.
  static load (that) {
    if (this.isStored()) {
      if (typeof(that.props.appState.authorization.token) === 'string') {
        return Promise.resolve('success')
      } else {
        let apiService = new ApiService(window.localStorage.authorizationToken)

        return apiService.fetch('user').then((response) => {
          SessionService.store(response.user, that)
          return Promise.resolve('success')
        }).catch((failureResponse) => {
          throw('Token use failed: ' + failureResponse)
        })
      }
    } else {
      throw('called without checking isStored()')
    }
  }

  static store (response, that) {
    that.props.appState.authorization.token = response.auth_token
    that.props.appState.authorization.loginFailureMessage = null
    that.props.appState.authorization.currentUserName = response.name
    that.props.appState.authorization.currentUserRole = response.role
  }
}
