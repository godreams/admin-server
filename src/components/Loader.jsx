import React from 'react'
import {observer, inject} from 'mobx-react'
import {observable, computed} from 'mobx'

import Article from 'grommet/components/Article'
import Box from 'grommet/components/Box'
import Heading from 'grommet/components/Heading'
import Meter from 'grommet/components/Meter'
import Button from 'grommet/components/Button'

import SessionService from 'services/SessionService'

@inject('appState') @observer
export default class Loader extends React.Component {
  @observable status = 'loading'
  @observable progress = 0

  @computed get isLoading () {
    return this.status == 'loading'
  }

  @computed get hasErrored () {
    return this.status == 'error'
  }

  @computed get hasLoaded () {
    return this.status == 'loaded'
  }

  @computed get headingMessage () {
    if (this.isLoading) {
      return 'Loading...'
    } else if (this.hasLoaded) {
      return 'Ready!'
    } else {
      return 'Oops. :-('
    }
  }

  @computed get footerMessage () {
    if (this.hasLoaded) {
      return <Button path='/dashboard'>Go to Dashboard</Button>
    } else if (this.hasErrored) {
      return <Button path='/login'>Try logging in</Button>
    }
  }

  componentDidMount () {
    if (SessionService.isAuthorized(this)) {
      this.props.router.push('/dashboard')
    } else if (SessionService.isStored()) {
      this.progress = 20
      let that = this

      SessionService.load(this).then(() => {
        that.progress = 100
        that.status = 'loaded'
      }).catch(() => {
        that.progress = 50
        that.status = 'error'
        SessionService.destroy(that)
      })
    } else {
      this.props.router.push('/login')
    }
  }

  render () {
    return (
      <Article align='center' full={ true } justify='center'>
        <Box>
          <Heading tag='h2'>
            { this.headingMessage }
          </Heading>

          <Meter vertical={false} value={ this.progress }/>

          { this.footerMessage }
        </Box>
      </Article>
    )
  }
}
