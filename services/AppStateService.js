export default class AppStateService {
  static loadState (that) {
    let authorizationToken = window.localStorage.authorizationToken

    if (typeof(authorizationToken) === 'string') {
      that.props.appState.authorization.token = authorizationToken
    }
  }

  static unloadState (that) {
    window.localStorage.removeItem('authorizationToken')
    that.props.appState.authorization.token = null
  }
}
