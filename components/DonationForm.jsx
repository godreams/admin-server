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
import ApiService from 'ApiService'

@inject('appState') @observer
export default class DonationForm extends React.Component {
  @observable donationDetails = {
    name: null,
    email: null,
    phone: null,
    amount: null,
    date: null,
    pan: null,
    address: null
  }

  @computed get hasNameError() {
    return this.donationDetails.name != null && this.donationDetails.name.length == 0
  }

  @computed get hasEmailError() {
    // Reference for regex: http://www.w3resource.com/javascript/form/email-validation.php
    const EMAIL_REGEX = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/
    let invalid = !EMAIL_REGEX.test(this.donationDetails.email)
    let notEmpty = this.donationDetails.email != null
    return  notEmpty && invalid
  }

  @computed get hasPhoneError() {
    let notEmpty = this.donationDetails.phone != null
    const PHONE_REGEX = /^[0-9]{10}$/
    let invalid = !PHONE_REGEX.test(this.donationDetails.phone)
    return invalid && notEmpty
  }

  @computed get hasAmountError() {
    return this.donationDetails.amount != null && this.donationDetails.amount < 1
  }

  @computed get hasAnyError() {
    let required = [this.donationDetails.name, this.donationDetails.email, this.donationDetails.phone, this.donationDetails.amount]
    return required.includes(null) || this.hasNameError || this.hasEmailError || this.hasPhoneError || this.hasAmountError
  }

  constructor (props) {
    super(props)

    this.handleClose = this.handleClose.bind(this)
    this.updateDetail = this.updateDetail.bind(this)
    this.onChange = this.onChange.bind(this)
    this.nameErrorMessage = this.nameErrorMessage.bind(this)
    this.emailErrorMessage = this.emailErrorMessage.bind(this)
    this.phoneErrorMessage = this.phoneErrorMessage.bind(this)
    this.amountErrorMessage = this.amountErrorMessage.bind(this)
    this.submit = this.submit.bind(this)
  }

  handleClose () {
    this.props.closeLayerCB()
  }

  updateDetail (key, value) {
    this.donationDetails[key] = value
  }

  onChange (event) {
    this.updateDetail(event.target.name, event.target.value)
  }

  nameErrorMessage () {
    return this.hasNameError ? "cannot be blank" : ""
  }

  emailErrorMessage () {
    return this.hasEmailError ? "doesn't look like a valid email" : ""
  }

  phoneErrorMessage () {
    return this.hasPhoneError ? "is not a 10-digit mobile number" : ""
  }

  amountErrorMessage () {
    return this.hasAmountError ? "needs to a positive number" : ""
  }

  submit () {
    if(this.hasAnyError) {
      // TODO: Display alert of error
      console.log('Form has error!')
    } else {
      let form = new FormData()
      Object.keys(this.donationDetails).forEach(key => form.append(key, this.donationDetails[key]));

      let apiService = new ApiService(this.props.appState.authorization.token)
      apiService.post('donations', form).then(response => {
        // TODO: Handle response
        console.log(response)
      })
    }
  }

  render () {
    return (
    <Layer closer={true} onClose={this.handleClose}>
        <Form pad='medium'>
          <Header>
            <Heading>
              Donor Details
            </Heading>
          </Header>
          <FormField label='Name' error={ this.nameErrorMessage() }>
            <TextInput name='name' onDOMChange={ this.onChange }/>
          </FormField>
          <FormField label='Email' error={ this.emailErrorMessage() }>
            <TextInput name='email' onDOMChange={ this.onChange }/>
          </FormField>
          <FormField label='Phone' error={ this.phoneErrorMessage() }>
            <TextInput name='phone' onDOMChange={ this.onChange }/>
          </FormField>
          <FormField label='Amount' error={ this.amountErrorMessage() }>
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
    </Layer>
    )
  }
}

DonationForm.propTypes = {
  closeLayerCB: React.PropTypes.func
};
