import React from 'react'
import {observer, inject} from 'mobx-react'
import {observable, computed} from 'mobx'

import Layer from 'grommet/components/Layer'
import Form from 'grommet/components/Form'
import Header from 'grommet/components/Header'
import Heading from 'grommet/components/Heading'
import FormField from 'grommet/components/FormField'
import TextInput from 'grommet/components/TextInput'
import Footer from 'grommet/components/Footer'
import Button from 'grommet/components/Button'
import SpinningIcon from 'grommet/components/icons/Spinning'
import Box from 'grommet/components/Box'
import Status from 'grommet/components/icons/Status'

import UserService from 'services/UserService'
import ApiService from 'services/ApiService'

@inject('appState') @observer
export default class FellowForm extends React.Component {
  constructor (props) {
    super(props)

    this.error = this.error.bind(this)
    this.errorMessage = this.errorMessage.bind(this)
    this.handleClose = this.handleClose.bind(this)
    this.updateDetail = this.updateDetail.bind(this)
    this.onChange = this.onChange.bind(this)
    this.submit = this.submit.bind(this)
  }

  @observable fellowDetails = {
    name: null,
    email: null,
    phone: null
  }

  @observable showErrors = {
    base: false,
    name: false,
    email: false,
    phone: false
  }

  @observable formState = 'fresh'
  @observable emailValidating = false
  @observable emailDuplicate = false

  error (field) {
    let showError = this.showErrors.base || this.showErrors[field]
    return showError ? this.errorMessage(field) : ''
  }

  errorMessage (field) {
    if (field == 'name') {
      return this.nameErrorMessage
    } else if (field == 'phone') {
      return this.phoneErrorMessage
    } else if (field == 'email') {
      return this.emailErrorMessage
    }
  }

  @computed get nameErrorMessage () {
    let hasNameError = this.fellowDetails.name == null || this.fellowDetails.name.length < 2
    return hasNameError ? 'does not look like a name' : ''
  }

  @computed get emailErrorMessage () {
    if (this.emailDuplicate) {
      return 'is already a Fellow'
    }

    // Reference for regex: http://www.w3resource.com/javascript/form/email-validation.php
    const EMAIL_REGEX = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/
    let hasEmailError = !EMAIL_REGEX.test(this.fellowDetails.email)
    return hasEmailError ? 'does not look like a valid email' : ''
  }

  @computed get phoneErrorMessage () {
    const PHONE_REGEX = /^[0-9]{10}$/
    let hasPhoneError = !PHONE_REGEX.test(this.fellowDetails.phone)
    return hasPhoneError ? 'is not a 10-digit mobile number' : ''
  }

  @computed get hasAnyError () {
    return this.nameErrorMessage || this.emailErrorMessage || this.phoneErrorMessage
  }

  handleClose () {
    this.props.closeLayerCB()
  }

  updateDetail (key, value) {
    this.fellowDetails[key] = value

    // Clear the duplicate email error if email is edited.
    if (key === 'email') {
      this.emailDuplicate = false
    }
  }

  onChange (event) {
    this.updateDetail(event.target.name, event.target.value)
    this.showErrors[event.target.name] = true
  }

  submit (event) {
    event.preventDefault()

    if (this.hasAnyError) {
      this.showErrors.base = true
    } else {
      let userService = new UserService(this.props.appState.authorization.token)
      this.emailValidating = true

      let that = this

      userService.find(this.fellowDetails.email).then((response) => {
        if (response.user.roles.includes('Fellow')) {
          that.emailDuplicate = true
        } else {
          that.submitForm()
        }
      }).catch(() => {
        that.submitForm()
      }).then(() => {
        that.emailValidating = false
      })
    }
  }

  submitForm () {
    this.formState = 'submitting'
    let form = new FormData()
    Object.keys(this.fellowDetails).forEach(key => form.append(key, this.fellowDetails[key]));

    let apiService = new ApiService(this.props.appState.authorization.token)
    apiService.post('fellows', form).then(response => {
      this.formState = 'complete'
      this.props.addFellowCB(response.fellow)
    })
  }

  render () {
    return (
      <Layer closer={true} onClose={this.handleClose}>
        { this.formState == 'submitting' &&
        <Box direction='column' justify='center' align='center' pad='medium'>
          <SpinningIcon size='xlarge'/>
          <span style={{color: 'grey'}}>Adding New Fellow</span>
        </Box>
        }
        { this.formState == 'fresh' &&
        <Form pad='medium'>
          <Header direction='column' pad='medium'>
            <Heading>
              Fellow Details
            </Heading>
            { this.showErrors.base &&
            <span style={{color: 'red'}}>Form has errors!</span>
            }
          </Header>
          <FormField label='Name' error={ this.error('name') }>
            <TextInput name='name' onDOMChange={ this.onChange }/>
          </FormField>
          <FormField label='Email' error={ this.error('email') }>
            <TextInput name='email' onDOMChange={ this.onChange }/>
          </FormField>
          <FormField label='Phone' error={ this.error('phone') }>
            <TextInput name='phone' onDOMChange={ this.onChange }/>
          </FormField>

          <Footer pad={{'vertical': 'medium'}}>
            { this.emailValidating &&
            <div>Validating email...</div>
            }
            { !this.emailValidating &&
            <Button label='Add' type='submit' onClick={this.submit}/>
            }
          </Footer>
        </Form>
        }
        { this.formState == 'complete' &&
        <Box direction='column' justify='center' align='center' pad='medium'>
          <Status value='ok'/>
          <span>Fellow created!</span>
        </Box>
        }
      </Layer>
    )
  }
}

FellowForm.propTypes = {
  closeLayerCB: React.PropTypes.func,
  addFellowCB: React.PropTypes.func
};
