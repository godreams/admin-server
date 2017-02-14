import React from 'react'
import {observer, inject} from 'mobx-react'
import {observable, computed} from 'mobx'
import Layer from 'grommet/components/Layer'
import Form from 'grommet/components/Form'
import Header from 'grommet/components/Header'
import Heading from 'grommet/components/Heading'
import FormField from 'grommet/components/FormField'
import TextInput from 'grommet/components/TextInput'
import NumberInput from 'grommet/components/NumberInput'
import Footer from 'grommet/components/Footer'
import Button from 'grommet/components/Button'
import ApiService from 'services/ApiService'
import SpinningIcon from 'grommet/components/icons/Spinning'
import Box from 'grommet/components/Box'
import Status from 'grommet/components/icons/Status'

@inject('appState') @observer
export default class DonationForm extends React.Component {
  constructor (props) {
    super(props)

    this.handleClose = this.handleClose.bind(this)
    this.onChange = this.onChange.bind(this)
    this.error = this.error.bind(this)
    this.errorMessage = this.errorMessage.bind(this)
    this.submit = this.submit.bind(this)
  }

  @observable donationDetails = {
    name: null,
    email: null,
    phone: null,
    amount: null,
    date: null,
    pan: null,
    address: null
  }

  @observable showErrors = {
    base: false,
    name: false,
    email: false,
    phone: false,
    amount: false
  }
  
  @observable formState = 'fresh'

  handleClose () {
    this.props.closeLayerCB()
  }

  error (field) {
    let showError = this.showErrors.base || this.showErrors[field]
    return showError ? this.errorMessage(field) : ''
  }

  // TODO: Can this be written cleaner? Some dynamic function calling?
  errorMessage(field) {
    if (field == 'name') {
      return this.nameErrorMessage
    } else if (field == 'phone') {
      return this.phoneErrorMessage
    } else if (field == 'email') {
      return this.emailErrorMessage
    } else if (field == 'amount') {
      return this.amountErrorMessage
    }
  }

  @computed get nameErrorMessage () {
    let hasNameError = this.donationDetails.name == null || this.donationDetails.name.length < 2
    return hasNameError ? 'does not look like a name' : ''
  }

  @computed get emailErrorMessage () {
    // Reference for regex: http://www.w3resource.com/javascript/form/email-validation.php
    const EMAIL_REGEX = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/
    let hasEmailError = !EMAIL_REGEX.test(this.donationDetails.email)
    return hasEmailError ? 'does not look like a valid email' : ''
  }

  @computed get phoneErrorMessage () {
    const PHONE_REGEX = /^[0-9]{10}$/
    let hasPhoneError = !PHONE_REGEX.test(this.donationDetails.phone)
    return hasPhoneError ? 'is not a 10-digit mobile number' : ''
  }

  @computed get amountErrorMessage () {
    let hasAmountError = this.donationDetails.amount == null || this.donationDetails.amount < 1
    return hasAmountError ? 'needs to a positive number' : ''
  }

  @computed get hasAnyError() {
    return this.nameErrorMessage || this.emailErrorMessage || this.phoneErrorMessage || this.amountErrorMessage
  }

  onChange (event) {
    this.donationDetails[event.target.name] = event.target.value
    this.showErrors[event.target.name] = true
  }

  submit (event) {
    event.preventDefault()
    if(this.hasAnyError) {
      this.showErrors.base = true
    } else {
      this.formState = 'submitting'
      let form = new FormData()
      Object.keys(this.donationDetails).forEach(key => form.append(key, this.donationDetails[key]))

      let apiService = new ApiService(this.props.appState.authorization.token)
      console.log('Posting new donation to server...')
      apiService.post('donations', form).then((response) => {
        this.formState = 'complete'
        console.log('response:')
        console.log(response)
      })
    }
  }

  render () {
    return (
    <Layer closer={true} onClose={this.handleClose} style={{height: '200px', width: '100px'}}>
      { this.formState == 'submitting' &&
      <Box direction='column' justify='center' align='center' pad='medium'>
        <SpinningIcon size='xlarge'/>
        <span style={{color: 'grey'}}>Recording Your Donation</span>
      </Box>
      }
      { this.formState == 'fresh' &&
      <Form pad='medium'>
        <Header direction='column' pad='medium'>
          <Heading>
            Donor Details
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
        <FormField label='Amount' error={ this.error('amount') }>
          <NumberInput name='amount' onChange={ this.onChange }/>
        </FormField>
        <FormField label='PAN'>
          <TextInput name='pan' onDOMChange={ this.onChange }/>
        </FormField>
        <FormField label='Address'>
          <TextInput name='address' onDOMChange={ this.onChange }/>
        </FormField>
        <Footer pad={{'vertical': 'medium'}}>
          <Button label='Add' type='submit' onClick={this.submit}/>
        </Footer>
      </Form>
      }
      { this.formState == 'complete' &&
      <Box direction='column' justify='center' align='center' pad='medium'>
        <Status value='ok'/>
        <span>Donation Recorded!</span>
      </Box>
      }
    </Layer>
    )
  }
}

DonationForm.propTypes = {
  closeLayerCB: React.PropTypes.func
};
