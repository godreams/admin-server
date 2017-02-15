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
import ApiService from 'services/ApiService'
import SpinningIcon from 'grommet/components/icons/Spinning'
import Box from 'grommet/components/Box'
import Status from 'grommet/components/icons/Status'

@inject('appState') @observer
export default class CoachForm extends React.Component {
  constructor (props) {
    super(props)

    this.error = this.error.bind(this)
    this.errorMessage = this.errorMessage.bind(this)
    this.handleClose = this.handleClose.bind(this)
    this.updateDetail = this.updateDetail.bind(this)
    this.onChange = this.onChange.bind(this)
    this.submit = this.submit.bind(this)
  }

  @observable coachDetails = {
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

  error (field) {
    let showError = this.showErrors.base || this.showErrors[field]
    return showError ? this.errorMessage(field) : ''
  }

  errorMessage(field) {
    if (field == 'name') {
      return this.nameErrorMessage
    } else if (field == 'phone') {
      return this.phoneErrorMessage
    } else if (field == 'email') {
      return this.emailErrorMessage
    }
  }

  @computed get nameErrorMessage () {
    let hasNameError = this.coachDetails.name == null || this.coachDetails.name.length < 2
    return hasNameError ? 'does not look like a name' : ''
  }

  @computed get emailErrorMessage () {
    // Reference for regex: http://www.w3resource.com/javascript/form/email-validation.php
    const EMAIL_REGEX = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/
    let hasEmailError = !EMAIL_REGEX.test(this.coachDetails.email)
    return hasEmailError ? 'does not look like a valid email' : ''
  }

  @computed get phoneErrorMessage () {
    const PHONE_REGEX = /^[0-9]{10}$/
    let hasPhoneError = !PHONE_REGEX.test(this.coachDetails.phone)
    return hasPhoneError ? 'is not a 10-digit mobile number' : ''
  }

  @computed get hasAnyError() {
    return this.nameErrorMessage || this.emailErrorMessage || this.phoneErrorMessage
  }

  handleClose () {
    this.props.closeLayerCB()
  }

  updateDetail (key, value) {
    this.coachDetails[key] = value
  }

  onChange (event) {
    this.updateDetail(event.target.name, event.target.value)
    this.showErrors[event.target.name] = true
  }

  submit (event) {
    event.preventDefault()
    if(this.hasAnyError) {
      this.showErrors.base = true
    } else {
      this.formState = 'submitting'
      let form = new FormData()
      Object.keys(this.coachDetails).forEach(key => form.append(key, this.coachDetails[key]));

      let apiService = new ApiService(this.props.appState.authorization.token)
      apiService.post('coaches', form).then(response => {
        this.formState = 'complete'
        this.props.addCoachCB(response.coach)
      })
    }
  }

  render () {
    return (
      <Layer closer={true} onClose={this.handleClose}>
        { this.formState == 'submitting' &&
        <Box direction='column' justify='center' align='center' pad='medium'>
          <SpinningIcon size='xlarge'/>
          <span style={{color: 'grey'}}>Adding New Coach</span>
        </Box>
        }
        { this.formState == 'fresh' &&
        <Form pad='medium'>
          <Header direction='column' pad='medium'>
            <Heading>
              Coach Details
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
            <Button label='Add' type='submit' onClick={this.submit}/>
          </Footer>
        </Form>
        }
        { this.formState == 'complete' &&
        <Box direction='column' justify='center' align='center' pad='medium'>
          <Status value='ok'/>
          <span>Coach created!</span>
        </Box>
        }
      </Layer>
    )
  }
}

CoachForm.propTypes = {
  closeLayerCB: React.PropTypes.func,
  addCoachCB: React.PropTypes.func
};
