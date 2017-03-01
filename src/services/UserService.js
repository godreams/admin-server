import ApiService from 'services/ApiService'

export default class UserService {
  constructor (token) {
    this.token = token
  }

  fetch () {
    let apiService = new ApiService(this.token)
    return apiService.fetch('user')
  }

  find (email) {
    let apiService = new ApiService(this.token)
    return apiService.get('users/find?email=' + email)
  }
}
