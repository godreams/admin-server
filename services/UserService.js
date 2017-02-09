import ApiService from 'ApiService'

export default class UserService {
  constructor (token) {
    this.token = token
  }

  fetch () {
    let apiService = new ApiService(this.token)
    return apiService.fetch('user')
  }
}
