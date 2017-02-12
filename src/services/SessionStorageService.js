export default class SessionStorageService {
  static authorized (that) {
    console.log('Confirming authorization');
    console.log('present token in appState' + that.props.appState.authorization.token);
    console.log('token in window local storage: ' + window.localStorage.authorizationToken);
    if (typeof(window.localStorage.authorizationToken) === 'string') {
      if (typeof(that.props.appState.authorization.token) === 'string') {
        return true;
      } else {
        // TODO: fetch user info sending token
        return false
      }
    } else {
      return false;
    }
  }

  static store (response, that) {
    that.props.appState.authorization.token = response.auth_token;
    that.props.appState.authorization.loginFailureMessage = null;
    that.props.appState.authorization.currentUserName = response.name;
    that.props.appState.authorization.currentUserRole = response.role;
  }
}