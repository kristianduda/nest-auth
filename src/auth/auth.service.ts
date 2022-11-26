import { Injectable } from '@nestjs/common'
import { ConfigService } from '@nestjs/config'
import { JwtService } from '@nestjs/jwt'
import * as bcrypt from 'bcrypt'
import { User } from '../users/interfaces/user.interface'
import { UsersService } from '../users/users.service'
import { Payload } from './interfaces/payload.interface'
import { Token } from './interfaces/token.interface'

@Injectable()
export class AuthService {
  constructor(
    private readonly usersService: UsersService,
    private readonly jwtService: JwtService,
    private readonly configService: ConfigService
  ) {}

  async validateUser(email: string, pass: string): Promise<User> {
    const user = await this.usersService.findByEmail(email)

    if (user && (await bcrypt.compare(pass, user.password))) {
      return { ...user, password: undefined }
    }
    return null
  }

  async refresh(id: number) {
    const user = await this.usersService.findById(id)
    return await this.login(user)
  }

  async login(user: User): Promise<Token> {
    const roles = user.admin_users_roles_links.map((r) => r.role_id)

    const payload: Payload = { id: user.id, roles }
    return {
      id: user.id,
      roles,
      access_token: this.jwtService.sign(payload, {
        secret: this.configService.get<string>('SECRET'),
        expiresIn: this.configService.get<string>('TOKEN_EXP'),
      }),
      refresh_token: this.jwtService.sign(payload, {
        secret: this.configService.get<string>('REFRESH_SECRET'),
        expiresIn: this.configService.get<string>('REFRESH_TOKEN_EXP'),
      }),
    }
  }
}
