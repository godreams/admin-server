import React from 'react'
import {observer, inject} from 'mobx-react'
import {observable} from 'mobx'

import Box from 'grommet/components/Box'
import Table from 'grommet/components/Table'
import TableHeader from 'grommet/components/TableHeader'
import TableRow from 'grommet/components/TableRow'
import Button from 'grommet/components/Button'
import DonationForm from 'components/DonationForm'

import SessionService from 'services/SessionService'
import ApiService from 'services/ApiService'

@inject('appState') @observer
@observer export default class DonationsTable extends React.Component {
  @observable donations = null
  @observable donationFormVisible = false

  constructor (props) {
    super(props)

    this.fetchDonations = this.fetchDonations.bind(this)
    this.donationDetail = this.donationDetail.bind(this)
    this.showDonationForm = this.showDonationForm.bind(this)
    this.hideDonationForm = this.hideDonationForm.bind(this)
    this.addDonation = this.addDonation.bind(this)
    this.approvalLink = this.approvalLink.bind(this)
    this.approve = this.approve.bind(this)
    this.markApproval = this.markApproval.bind(this)
    this.downloadReceipt = this.downloadReceipt.bind(this)
  }

  componentDidMount () {
    if (SessionService.isAuthorized(this)) {
      this.fetchDonations()
    }
  }

  fetchDonations () {
    console.log('Fetching donations with token:' + this.props.appState.authorization.token)
    let apiService = new ApiService(this.props.appState.authorization.token)
    apiService.fetch('donations').then(response => {
      console.log('Fetched ' + response.donations.length + ' donation(s) from server.')
      this.donations = response.donations
    })
  }

  donationsPresent() {
    return this.donations !== null
  }

  donationDetail(donation) {
    return (
      <TableRow key={donation.id.toString()}>
        <td>{donation.name}</td>
        <td>{donation.amount}</td>
        <td>{donation.created_at}</td>
        <td className="secondary">{donation.status}</td>
        <td>
          {donation.approvable ? this.approvalLink(donation) : ''}
          {donation.approved ? this.receiptLink(donation) : ''}
        </td>
      </TableRow>
    )
  }

  showDonationForm () {
    this.donationFormVisible = true
  }

  hideDonationForm () {
    this.donationFormVisible = false
  }

  addDonation (donation) {
    this.donations.unshift(donation)
  }

  approvalLink (donation) {
    return (
      <a onClick={this.approve.bind(null, donation.id)}>Approve</a>
    )
  }

  receiptLink (donation) {
    return (
      <a onClick={this.downloadReceipt.bind(null, donation.id)}>Download Receipt</a>
    )
  }

  downloadReceipt (donationId) {
    let apiService = new ApiService(this.props.appState.authorization.token)

    apiService.fetch('donations/' + donationId + '/receipt').then(response => {
      let pdfAsDataUri = "data:application/pdf;base64,"+response.receipt.pdf_base64;
      window.open(pdfAsDataUri);
    })
  }

  approve (donationId) {
    let apiService = new ApiService(this.props.appState.authorization.token)
    let postURL = 'donations/' + donationId + '/approve'
    apiService.post(postURL, null).then(response => {
      this.markApproval(response.donation)
    })
  }

  markApproval (donation) {
    let oldEntry = this.donations.find(d => d.id === donation.id)
    oldEntry.status = donation.status
    oldEntry.approvable = donation.approvable
  }

  render () {
    return (
      <Box direction='column'>
        { SessionService.hasRole(this, 'Volunteer') &&
        <Box align='center' pad='medium'>
          <Button label='Add Donation' primary={ true } onClick={ this.showDonationForm }/>
          { this.donationFormVisible && <DonationForm closeLayerCB={ this.hideDonationForm } addDonationCB={ this.addDonation }/> }
        </Box>
        }
        <Box>
          <Table scrollable={true} selectable={true}>
            <TableHeader labels={['Donor', 'Amount', 'Date', 'Status', 'Actions']}/>
              <tbody>
              { this.donationsPresent() &&
              this.donations.map(donation => this.donationDetail(donation))
              }
              { !this.donationsPresent() &&
              <TableRow>
                <td>Loading donations...</td>
              </TableRow>
              }
            </tbody>
          </Table>
        </Box>
      </Box>
    )
  }
}
