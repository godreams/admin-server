import ApiService from 'ApiService'

export default class LoginService {
  fetch (email, password) {
    let apiService = new ApiService()
    return apiService.fetch('authenticate?email=' + email + '&password=' + password)
  }
}
