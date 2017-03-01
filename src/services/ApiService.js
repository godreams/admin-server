import 'whatwg-fetch'

export default class ApiService {
  constructor (token) {
    this.token = token
    if (typeof(process.env.API_BASE_URL) === 'undefined') {
      this.baseUrl = 'http://localhost:3000/api'
    } else {
      this.baseUrl = process.env.API_BASE_URL
    }
  }

  headers () {
    if (this.token) {
      return {Authorization: this.token}
    } else {
      return {}
    }
  }

  fetch (path, method = 'GET', body = null) {
    console.log('Calling: ' + this.fullUrl(path))
    return fetch(this.fullUrl(path), {
      method: method,
      headers: this.headers(),
      body: body
    }).then((response) => {
      let parseResponse = response.json()

      if (response.ok) {
        return parseResponse
      } else {
        return parseResponse.then(parsedResponse => Promise.reject(parsedResponse))
      }
    })
  }

  post (path, body) {
    return this.fetch(path, 'POST', body)
  }

  get (path, body) {
    return this.fetch(path, 'GET', body)
  }

  fullUrl (path) {
    return [this.baseUrl, path].join('/')
  }
}
