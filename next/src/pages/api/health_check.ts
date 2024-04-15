import type { NextApiRequest, NextApiResponse } from 'next'

export default function handler(req: NextApiRequest, res: NextApiResponse) {
  res.status(200)
  res.setHeader('Content-Type', 'application/json')
  res.end(JSON.stringify({ status: 'ok' }))
}
