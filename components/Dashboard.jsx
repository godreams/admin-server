import React from 'react'
import App from 'grommet/components/App'
import Header from 'grommet/components/Header'
import Title from 'grommet/components/Title'
import {observer, inject} from 'mobx-react'
import UserService from 'UserService'
import {observable} from 'mobx'
import Sidebar from 'grommet/components/Sidebar'
import Menu from 'grommet/components/Menu'
import Anchor from 'grommet/components/Anchor'
import Footer from 'grommet/components/Footer'
import Split from 'grommet/components/Split'
import Box from 'grommet/components/Box'
import UserIcon from 'grommet/components/icons/base/User'
import Heading from 'grommet/components/Heading'
import AppStateService from 'AppStateService'
import DonationsTable from 'DonationsTable'
import Button from 'grommet/components/Button'
import DonationForm from 'DonationForm'

@inject('appState') @observer
@observer export default class Dashboard extends React.Component {
  @observable userName = 'Loading...'
  @observable donationFormVisible = false

  constructor (props) {
    super(props)

    this.logout = this.logout.bind(this)
    this.showDonationForm = this.showDonationForm.bind(this)
    this.hideDonationForm = this.hideDonationForm.bind(this)
  }

  componentDidMount () {
    // TODO: @hari: Do we need the loadState below? Cant we just use UserService(window.localStorage.authorizationToken) with a presence check?
    AppStateService.loadState(this)

    if (typeof(this.props.appState.authorization.token) !== 'string') {
      this.props.router.push('/')
      return
    }

    // TODO: Isn't it better to call this an AuthorizationService?
    let userService = new UserService(this.props.appState.authorization.token)
    let that = this

    userService.fetch().then(function (response) {
      // TODO: Probably just update currentUserName and currentUserRole here?
      that.userName = response.name
    }).catch(function (response) {
      // TODO: simply call this.logout() here?
      console.log(response.code)
    })
  }

  logout () {
    AppStateService.unloadState(this)
    this.props.router.push('/')
  }

  showDonationForm () {
    this.donationFormVisible = true
  }

  hideDonationForm () {
    this.donationFormVisible = false
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
                  <Heading tag='h4' strong={ true }>Donations</Heading>
                </Header>

                <Anchor href='#' className='active'>Pending</Anchor>
                <Anchor href='#'>Approved</Anchor>


                <Header align='end'>
                  <Heading tag='h4' strong={ true }>Users</Heading>
                </Header>

                <Anchor href='#'>Volunteers</Anchor>
                <Anchor href='#'>Coaches</Anchor>
                <Anchor href='#'>Fellows</Anchor>
              </Menu>
            </Box>

            <Footer pad={{horizontal: 'medium', vertical: 'small'}}>
              <Menu icon={<UserIcon />} dropAlign={{bottom: 'bottom'}} colorIndex="neutral-1-a">
                <Box pad="medium">
                  <Heading tag="h3" margin="none">{this.userName}</Heading>
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
          <Box margin='medium' alignSelf='center'>
            <Button label='Add Donation' primary={ true } onClick={ this.showDonationForm }/>
            { this.donationFormVisible && <DonationForm closeLayerCB={ this.hideDonationForm }/> }
          </Box>
          <Box>
            <DonationsTable />
          </Box>
          </Box>
        </Split>
      </App>
    )
  }
}
