import React from 'react'
import {Link} from 'react-router'

import Article from 'grommet/components/Article'
import Heading from 'grommet/components/Heading'
import Paragraph from 'grommet/components/Paragraph'

const NotFound = () =>
  <Article align='center' full={ true } justify='center'>
    <Heading tag='h1'>404</Heading>
    <Paragraph align='center'>
      We're sorry, but there doesn't appear to be anything here.<br/>
      You should probably head back <Link to='/'>to the main page</Link>.
    </Paragraph>
  </Article>

export default NotFound
