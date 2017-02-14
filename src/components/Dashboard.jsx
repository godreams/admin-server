import React from 'react'
import {observer, inject} from 'mobx-react'
import {observable} from 'mobx'

import App from 'grommet/components/App'
import Header from 'grommet/components/Header'
import Title from 'grommet/components/Title'
import Sidebar from 'grommet/components/Sidebar'
import Menu from 'grommet/components/Menu'
import Anchor from 'grommet/components/Anchor'
import Footer from 'grommet/components/Footer'
import Split from 'grommet/components/Split'
import Box from 'grommet/components/Box'
import UserIcon from 'grommet/components/icons/base/User'
import Heading from 'grommet/components/Heading'
import DonationsTable from 'components/DonationsTable'
import VolunteersTable from 'components/VolunteersTable'
import CoachesTable from 'components/CoachesTable'
import FellowsTable from 'components/FellowsTable'

import SessionService from 'services/SessionService'
import AppStateService from 'services/AppStateService'

@inject('appState') @observer
@observer export default class Dashboard extends React.Component {
  constructor (props) {
    super(props)

    this.logout = this.logout.bind(this)
    this.hasVolunteers = this.hasVolunteers.bind(this)
    this.hasCoaches = this.hasCoaches.bind(this)
    this.hasFellows = this.hasFellows.bind(this)
    this.showDonationsTable = this.showDonationsTable.bind(this)
    this.showVolunteersTable = this.showVolunteersTable.bind(this)
    this.showCoachesTable = this.showCoachesTable.bind(this)
    this.showFellowsTable = this.showFellowsTable.bind(this)
  }

  // show the donations table by default
  @observable visibleTable = 'donations'

  componentWillMount () {
    if (SessionService.isAuthorized(this)) {
      // We're ready. Proceed to render.
    } else if (SessionService.isStored()) {
      this.props.router.push('/')
    } else {
      this.props.router.push('/login')
    }
  }

  logout () {
    AppStateService.unloadState(this)
    this.props.router.push('/')
  }

  hasVolunteers () {
    return ['Coach', 'Fellow', 'NationalFinanceHead'].includes(this.props.appState.authorization.currentUserRole)
  }

  hasCoaches () {
    return ['Fellow', 'NationalFinanceHead'].includes(this.props.appState.authorization.currentUserRole)
  }

  hasFellows () {
    return this.props.appState.authorization.currentUserRole == 'NationalFinanceHead'
  }

  showDonationsTable () {
    console.log('Displaying donations...')
    this.visibleTable = 'donations'
  }

  showVolunteersTable () {
    console.log('Displaying volunteers...')
    this.visibleTable = 'volunteers'
  }

  showCoachesTable () {
    console.log('Displaying coaches...')
    this.visibleTable = 'coaches'
  }

  showFellowsTable () {
    console.log('Displaying fellows...')
    this.visibleTable = 'fellows'
  }

  render () {
    return (
      <App centered={false}>
        <Split flex='right'>
          <Sidebar colorIndex='neutral-1'>
            <Box pad={ {horizontal: 'medium'} }>
              <Header>
                <Title>
                  Guardians donorApp
                </Title>
              </Header>

              <Menu size="small">
                <Header align='end'>
                  <Heading tag='h4' strong={ true } onClick={ this.showDonationsTable }>Donations</Heading>
                </Header>

                <Anchor href='#' className='active'>Pending</Anchor>
                <Anchor href='#'>Approved</Anchor>

                { this.props.appState.authorization.currentUserRole != 'Volunteer' &&
                <Header align='end'>
                  <Heading tag='h4' strong={ true }>Users</Heading>
                </Header>
                }

                { this.hasVolunteers() &&
                <Anchor onClick={ this.showVolunteersTable }>Volunteers</Anchor>
                }

                { this.hasCoaches() &&
                <Anchor onClick={ this.showCoachesTable }>Coaches</Anchor>
                }

                { this.hasFellows() &&
                <Anchor onClick={ this.showFellowsTable }>Fellows</Anchor>
                }

              </Menu>
            </Box>

            <Footer pad={{horizontal: 'medium', vertical: 'small'}}>
              <Menu icon={<UserIcon />} dropAlign={{bottom: 'bottom'}} colorIndex="neutral-1-a">
                <Box pad="medium">
                  <Heading tag="h3" margin="none">{this.props.appState.authorization.currentUserName}</Heading>
                </Box>
                <Anchor href="#" onClick={this.logout} label="Logout" />
              </Menu>
            </Footer>
          </Sidebar>

          <Box direction='column'>
          <Box colorIndex='neutral-2' justify='center' align='center' pad='medium'>
            <Header direction='row' justify='between' pad={{horizontal: 'medium'}}>
              <Title>Guardians donorApp</Title>
            </Header>
            <h3>Welcome {this.props.appState.authorization.currentUserName}</h3>
            <em>(You are logged in as a { this.props.appState.authorization.currentUserRole })</em>
          </Box>
          <Box>
            { this.visibleTable === 'donations' &&
              <DonationsTable />
            }
            { this.visibleTable === 'volunteers' &&
              <VolunteersTable />
            }
            {
              this.visibleTable === 'coaches' &&
              <CoachesTable />
            }
            {
              this.visibleTable === 'fellows' &&
              <FellowsTable />
            }
          </Box>
          </Box>
        </Split>
      </App>
    )
  }
}
