export default class AppStateService {
  static loadDimensions (that) {
    that.props.appState.dimensions = {
      width: window.innerWidth,
      height: window.innerHeight
    }
  }
}
