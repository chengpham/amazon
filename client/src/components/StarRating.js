import { Star } from './Star'

export function StarRating({ max, currentNumber }) {
  let StarArray = []
  for (let i = 1; i <= max; i++) {
    if (i <= currentNumber) {
      StarArray.push(<Star key={i} style={{ color: 'gold', width: '20px' }} />)
    } else {
      StarArray.push(<Star key={i} style={{ color: 'grey', width: '20px' }} />)
    }
  }
  return <>{StarArray}</>
}
