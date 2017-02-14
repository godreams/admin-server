import React from 'react'
import {observer, inject} from 'mobx-react'
import {observable} from 'mobx'
import Box from 'grommet/components/Box'
import Table from 'grommet/components/Table'
import TableHeader from 'grommet/components/TableHeader'
import TableRow from 'grommet/components/TableRow'
import ApiService from 'services/ApiService'
import Button from 'grommet/components/Button'
import CoachForm from 'components/CoachForm'

@inject('appState') @observer
@observer export default class CoachesTable extends React.Component {
  @observable coaches = null
  @observable coachFormVisible = false

  constructor (props) {
    super(props)

    this.fetchCoaches = this.fetchCoaches.bind(this)
    this.coachDetail = this.coachDetail.bind(this)
    this.showCoachForm = this.showCoachForm.bind(this)
    this.hideCoachForm = this.hideCoachForm.bind(this)
  }

  componentDidMount () {
    this.fetchCoaches()
  }

  fetchCoaches () {
    console.log('Fetching coaches')
    let apiService = new ApiService(this.props.appState.authorization.token)
    apiService.fetch('coaches').then(response => {
      console.log('Fetched ' + response.coaches.length + ' coach(es) from server.')
      this.coaches = response.coaches
    })
  }

  coachesPresent() {
    return this.coaches !== null
  }

  coachDetail(coach) {
    return (
      <TableRow key={coach.id.toString()}>
        <td>{coach.name}</td>
        <td>{coach.email}</td>
        <td>{coach.phone}</td>
        <td className="secondary">coming soon...</td>
      </TableRow>
    )
  }

  showCoachForm () {
    this.coachFormVisible = true
  }

  hideCoachForm () {
    this.coachFormVisible = false
  }

  render () {
    return (
      <Box direction='column'>
        { this.props.appState.authorization.currentUserRole == 'Fellow' &&
        <Box align='center' pad='medium'>
          <Button label='Add Coach' primary={ true } onClick={ this.showCoachForm }/>
          { this.coachFormVisible && <CoachForm closeLayerCB={ this.hideCoachForm }/> }
        </Box>
        }
        <Box>
          <Table scrollable={true} selectable={true}>
            <TableHeader labels={['Name', 'Email', 'Phone', 'Actions']}/>
            <tbody>
            { this.coachesPresent() &&
            this.coaches.map(coach => this.coachDetail(coach))
            }
            { !this.coachesPresent() &&
            <TableRow>
              <td>Loading coaches...</td>
            </TableRow>
            }
            </tbody>
          </Table>
        </Box>
      </Box>
    )
  }
}
