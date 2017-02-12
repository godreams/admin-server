import React from 'react'
import App from 'grommet/components/App'
import Header from 'grommet/components/Header'
import Title from 'grommet/components/Title'
import {observer, inject} from 'mobx-react'
import {observable} from 'mobx'
import Sidebar from 'grommet/components/Sidebar'
import Menu from 'grommet/components/Menu'
import Anchor from 'grommet/components/Anchor'
import Footer from 'grommet/components/Footer'
import Split from 'grommet/components/Split'
import Box from 'grommet/components/Box'
import UserIcon from 'grommet/components/icons/base/User'
import Heading from 'grommet/components/Heading'
import AppStateService from 'services/AppStateService'
import DonationsTable from 'components/DonationsTable'
import VolunteersTable from 'components/VolunteersTable'
import SessionStorageService from 'services/SessionStorageService'

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
  }

  // show the donations table by default
  @observable visibleTable = 'donations'

  componentWillMount () {
    let authorized = SessionStorageService.authorized(this)
    console.log('authorization:' + authorized)

    // redirect to login if not authorized
    if (!authorized) {
      this.props.router.push('/')
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

  render () {
    return (
      <App centered={false}>
        <Split flex='right'>
          <Sidebar colorIndex='neutral-1'>
            <Box pad={ {horizontal: 'medium'} }>
              <Header>
                <Title>
                  National Finance Head
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
                <Anchor href='#'>Coaches</Anchor>
                }

                { this.hasFellows() &&
                <Anchor href='#'>Fellows</Anchor>
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
          </Box>
          </Box>
        </Split>
      </App>
    )
  }
}
