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

@inject('appState') @observer
export default class CoachForm extends React.Component {
  constructor (props) {
    super(props)

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

  @computed get nameErrorMessage() {
    if (this.coachDetails.name != null && this.coachDetails.name.length == 0) {
      return 'cannot be blank'
    } else {
      return ''
    }
  }

  @computed get emailErrorMessage() {
    // Reference for regex: http://www.w3resource.com/javascript/form/email-validation.php
    const EMAIL_REGEX = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/
    let invalid = !EMAIL_REGEX.test(this.coachDetails.email)
    let notEmpty = this.coachDetails.email != null

    if (notEmpty && invalid) {
      return 'does not look like a valid email'
    } else {
      return ''
    }
  }

  @computed get phoneErrorMessage() {
    let notEmpty = this.coachDetails.phone != null
    const PHONE_REGEX = /^[0-9]{10}$/
    let invalid = !PHONE_REGEX.test(this.coachDetails.phone)
    if (invalid && notEmpty) {
      return 'is not a 10-digit mobile number'
    } else {
      return ''
    }
  }

  @computed get hasAnyError() {
    // TODO: Add check for length of error messages
    let required = [this.coachDetails.name, this.coachDetails.email, this.coachDetails.phone]
    return required.includes(null)
  }

  handleClose () {
    this.props.closeLayerCB()
  }

  updateDetail (key, value) {
    this.coachDetails[key] = value
  }

  onChange (event) {
    this.updateDetail(event.target.name, event.target.value)
  }

  submit () {
    if(this.hasAnyError) {
      // TODO: Display alert of error
      console.log('Form has error!')
    } else {
      console.log('Creating new Coach')
      let form = new FormData()
      Object.keys(this.coachDetails).forEach(key => form.append(key, this.coachDetails[key]));

      let apiService = new ApiService(this.props.appState.authorization.token)
      apiService.post('coaches', form).then(response => {
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
              Coach Details
            </Heading>
          </Header>
          <FormField label='Name' error={ this.nameErrorMessage }>
            <TextInput name='name' onDOMChange={ this.onChange }/>
          </FormField>
          <FormField label='Email' error={ this.emailErrorMessage }>
            <TextInput name='email' onDOMChange={ this.onChange }/>
          </FormField>
          <FormField label='Phone' error={ this.phoneErrorMessage }>
            <TextInput name='phone' onDOMChange={ this.onChange }/>
          </FormField>
          <Footer pad={{'vertical': 'medium'}}>
            <Button label='Add' type='submit' onClick={this.submit}/>
          </Footer>
        </Form>
      </Layer>
    )
  }
}

CoachForm.propTypes = {
  closeLayerCB: React.PropTypes.func
};
