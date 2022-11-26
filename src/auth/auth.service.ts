import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { User } from '../users/interfaces/user.interface';
import { UsersService } from '../users/users.service';
import { Payload } from './interfaces/payload.interface';
import { Token } from './interfaces/token.interface';

@Injectable()
export class AuthService {
  constructor(
    private readonly usersService: UsersService,
    private readonly jwtService: JwtService,
  ) {}

  async validateUser(email: string, pass: string): Promise<User> {
    const user = await this.usersService.userByEmail(email);

    if (user && await bcrypt.compare(pass, user.password)) {
      return { ...user, password: undefined };
    }
    return null;
  }

  async login(user: User) : Promise<Token> {
    const roles = user.admin_users_roles_links.map(r => r.role_id)

    const payload : Payload = { id: user.id, roles };
    return {
      id: user.id,
      access_token: this.jwtService.sign(payload),
      roles
    };
  }
}
