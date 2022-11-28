import { Token } from '../interfaces/token.interface'

export class TokenDto implements Token {
  id: number
  roles: number[]
  access_token: string
  refresh_token: string
}
