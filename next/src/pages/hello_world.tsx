import type { NextPage } from 'next'
import SimpleButton from '@/components/SimpleButton'

const HelloWorld: NextPage = () => {
  const hundleOnClick = () => {
    console.log('Clicked from hello world!')
  }
  return (
    <div>
      <h1>Title</h1>
      <p>content</p>
      <SimpleButton text={'From HelloWorld'} onClick={hundleOnClick} />
    </div>
  )
}

export default HelloWorld
