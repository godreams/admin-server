import React from 'react'
import {observer, inject} from 'mobx-react'
import {observable} from 'mobx'
import Box from 'grommet/components/Box'
import Table from 'grommet/components/Table'
import TableHeader from 'grommet/components/TableHeader'
import TableRow from 'grommet/components/TableRow'
import ApiService from 'services/ApiService'
import Button from 'grommet/components/Button'
import VolunteerForm from 'components/VolunteerForm'

@inject('appState') @observer
@observer export default class VolunteersTable extends React.Component {
  @observable volunteers = null
  @observable volunteerFormVisible = false

  constructor (props) {
    super(props)

    this.fetchVolunteers = this.fetchVolunteers.bind(this)
    this.volunteerDetail = this.volunteerDetail.bind(this)
    this.showVolunteerForm = this.showVolunteerForm.bind(this)
    this.hideVolunteerForm = this.hideVolunteerForm.bind(this)
    this.addVolunteer = this.addVolunteer.bind(this)
  }

  componentDidMount () {
    this.fetchVolunteers()
  }

  fetchVolunteers () {
    console.log('Fetching volunteers')
    let apiService = new ApiService(this.props.appState.authorization.token)
    apiService.fetch('volunteers').then(response => {
      console.log('Fetched ' + response.volunteers.length + ' volunteer(s) from server.')
      this.volunteers = response.volunteers
    })
  }

  volunteersPresent() {
    return this.volunteers !== null
  }

  volunteerDetail(volunteer) {
    return (
      <TableRow key={volunteer.id.toString()}>
        <td>{volunteer.name}</td>
        <td>{volunteer.email}</td>
        <td>{volunteer.phone}</td>
        <td className="secondary">coming soon...</td>
      </TableRow>
    )
  }

  showVolunteerForm () {
    this.volunteerFormVisible = true
  }

  hideVolunteerForm () {
    this.volunteerFormVisible = false
  }

  addVolunteer (volunteer) {
    this.volunteers.unshift(volunteer)
  }

  render () {
    return (
      <Box direction='column'>
        { this.props.appState.authorization.currentUserRole == 'Coach' &&
        <Box align='center' pad='medium'>
          <Button label='Add Volunteer' primary={ true } onClick={ this.showVolunteerForm }/>
          { this.volunteerFormVisible && <VolunteerForm closeLayerCB={ this.hideVolunteerForm } addVolunteerCB={ this.addVolunteer }/> }
        </Box>
        }
        <Box>
          <Table scrollable={true} selectable={true}>
            <TableHeader labels={['Name', 'Email', 'Phone', 'Actions']}/>
            <tbody>
            { this.volunteersPresent() &&
            this.volunteers.map(volunteer => this.volunteerDetail(volunteer))
            }
            { !this.volunteersPresent() &&
            <TableRow>
              <td>Loading volunteers...</td>
            </TableRow>
            }
            </tbody>
          </Table>
        </Box>
      </Box>
    )
  }
}
