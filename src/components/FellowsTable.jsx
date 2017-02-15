import React from 'react'
import {observer, inject} from 'mobx-react'
import {observable} from 'mobx'
import Box from 'grommet/components/Box'
import Table from 'grommet/components/Table'
import TableHeader from 'grommet/components/TableHeader'
import TableRow from 'grommet/components/TableRow'
import ApiService from 'services/ApiService'
import Button from 'grommet/components/Button'
import FellowForm from 'components/FellowForm'

@inject('appState') @observer
@observer export default class FellowsTable extends React.Component {
  @observable fellows = null
  @observable fellowFormVisible = false

  constructor (props) {
    super(props)

    this.fetchFellows = this.fetchFellows.bind(this)
    this.fellowDetail = this.fellowDetail.bind(this)
    this.showFellowForm = this.showFellowForm.bind(this)
    this.hideFellowForm = this.hideFellowForm.bind(this)
    this.addFellow = this.addFellow.bind(this)
  }

  componentDidMount () {
    this.fetchFellows()
  }

  fetchFellows () {
    console.log('Fetching fellows')
    let apiService = new ApiService(this.props.appState.authorization.token)
    apiService.fetch('fellows').then(response => {
      console.log('Fetched ' + response.fellows.length + ' fellow(s) from server.')
      this.fellows = response.fellows
    })
  }

  fellowsPresent() {
    return this.fellows !== null
  }

  fellowDetail(fellow) {
    return (
      <TableRow key={fellow.id.toString()}>
        <td>{fellow.name}</td>
        <td>{fellow.email}</td>
        <td>{fellow.phone}</td>
        <td className="secondary">coming soon...</td>
      </TableRow>
    )
  }

  showFellowForm () {
    this.fellowFormVisible = true
  }

  hideFellowForm () {
    this.fellowFormVisible = false
  }

  addFellow (fellow) {
    this.fellows.unshift(fellow)
  }

  render () {
    return (
      <Box direction='column'>
        { this.props.appState.authorization.currentUserRole == 'NationalFinanceHead' &&
        <Box align='center' pad='medium'>
          <Button label='Add Fellow' primary={ true } onClick={ this.showFellowForm }/>
          { this.fellowFormVisible && <FellowForm closeLayerCB={ this.hideFellowForm } addFellowCB={ this.addFellow }/> }
        </Box>
        }
        <Box>
          <Table scrollable={true} selectable={true}>
            <TableHeader labels={['Name', 'Email', 'Phone', 'Actions']}/>
            <tbody>
            { this.fellowsPresent() &&
            this.fellows.map(fellow => this.fellowDetail(fellow))
            }
            { !this.fellowsPresent() &&
            <TableRow>
              <td>Loading fellows...</td>
            </TableRow>
            }
            </tbody>
          </Table>
        </Box>
      </Box>
    )
  }
}
