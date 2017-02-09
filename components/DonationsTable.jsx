import React from 'react'
import {observer, inject} from 'mobx-react'
import {observable} from 'mobx'
import Table from 'grommet/components/Table'
import TableHeader from 'grommet/components/TableHeader'
import TableRow from 'grommet/components/TableRow'
import Devtools from 'mobx-react-devtools'
import ApiService from 'ApiService'

@inject('appState') @observer
@observer export default class DonationsTable extends React.Component {
  @observable donations = null

  constructor (props) {
    super(props)

    this.fetchDonations = this.fetchDonations.bind(this)
    this.donationDetail = this.donationDetail.bind(this)
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

  render () {
    return (
      <div>
        <Devtools />
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
      </div>
    )
  }
}
