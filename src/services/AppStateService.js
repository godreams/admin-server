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

  static loadDimensions (that) {
    that.props.appState.dimensions = {
      width: window.innerWidth,
      height: window.innerHeight
    }
  }
}
