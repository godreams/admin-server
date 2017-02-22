import ApiService from 'services/ApiService'

export default class SessionService {
  // Returns true if there is a token in storage.
  static isStored () {
    return typeof(window.localStorage.authorizationToken) === 'string'
  }

  // Returns true if user is already logged in.
  static isAuthorized (that) {
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

  // Store session data in localStorage and in state.
  static store (response, that) {
    // Store the token in localStorage if it isn't there.
    if (typeof(window.localStorage.authorizationToken) === 'undefined') {
      window.localStorage.authorizationToken = response.auth_token
    }

    that.props.appState.authorization.token = response.auth_token
    that.props.appState.authorization.loginFailureMessage = null
    that.props.appState.authorization.currentUserName = response.name

    for (let role of response.roles) {
      that.props.appState.authorization.currentUserRoles.push(role)
    }
  }

  // Check if current user has a specific role.
  static hasRole (that, role) {
    return (that.props.appState.authorization.currentUserRoles.indexOf(role) >= 0)
  }

  // Check if current user has one among an array of possible roles.
  static hasAnyRole (that, roles) {
    for (let role of roles) {
      if (that.props.appState.authorization.currentUserRoles.indexOf(role) >= 0) {
        return true
      }
    }

    return false
  }

  // Destroy session.
  static destroy (that) {
    // Get rid of stored token.
    window.localStorage.removeItem('authorizationToken')

    // If there is an authorized session, destroy state values.
    if (this.isAuthorized(that)) {
      that.props.appState.authorization.token = null
      that.props.appState.authorization.loginFailureMessage = null
      that.props.appState.authorization.currentUserName = null
      that.props.appState.authorization.currentUserRoles.length = 0
    }
  }
}
