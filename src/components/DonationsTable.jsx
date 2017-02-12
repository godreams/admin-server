import React from 'react'
import {observer, inject} from 'mobx-react'
import {observable} from 'mobx'
import Box from 'grommet/components/Box'
import Table from 'grommet/components/Table'
import TableHeader from 'grommet/components/TableHeader'
import TableRow from 'grommet/components/TableRow'
import ApiService from 'services/ApiService'
import SessionStorageService from 'services/SessionStorageService'
import Button from 'grommet/components/Button'
import DonationForm from 'components/DonationForm'

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
  }

  componentWillMount () {
    let authorized = SessionStorageService.authorized(this)
    console.log('authorization:' + authorized)

    // redirect to login if not authorized
    if (!authorized) {
      this.props.router.push('/')
    }
  }

  componentDidMount () {
    this.fetchDonations()
  }

  fetchDonations () {
    console.log('Fetching donations')
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
      </TableRow>
    )
  }

  showDonationForm () {
    this.donationFormVisible = true
  }

  hideDonationForm () {
    this.donationFormVisible = false
  }

  render () {
    return (
      <Box direction='column'>
        <Box align='center' pad='medium'>
          <Button label='Add Donation' primary={ true } onClick={ this.showDonationForm }/>
          { this.donationFormVisible && <DonationForm closeLayerCB={ this.hideDonationForm }/> }
        </Box>
        <Box>
          <Table scrollable={true} selectable={true}>
            <TableHeader labels={['Donor', 'Amount', 'Date', 'Status']}/>
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
