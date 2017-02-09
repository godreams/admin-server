import 'whatwg-fetch'

export default class ApiService {
  constructor (token) {
    this.token = token
    this.baseUrl = 'http://localhost:3001'
  }

  headers () {
    if (this.token) {
      return {Authorization: this.token}
    } else {
      return {}
    }
  }

  fetch (path, method = 'GET', body = null) {
    console.log('Calling ' + this.fullUrl(path))
    return fetch(this.fullUrl(path), {
      method: method,
      headers: this.headers(),
      body: body
    }).then(function(response) {
      let parseResponse = response.json()

      if (response.ok) {
        return parseResponse
      } else {
        return parseResponse.then(parsedResponse => Promise.reject(parsedResponse))
      }
    })
  }

  post (path, body) {
    this.fetch(path, 'POST', body)
  }

  fullUrl (path) {
    return [this.baseUrl, path].join('/')
  }
}
