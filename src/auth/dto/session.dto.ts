import { Session } from '../interfaces/session.interface'

export class SessionDto implements Session {
  id: number
  roles: number[]
  access_token: string
  refresh_token: string
}
