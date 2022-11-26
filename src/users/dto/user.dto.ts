import { ApiProperty } from '@nestjs/swagger'
import { admin_users_roles_links } from '@prisma/client'
import { BaseList } from '../../prisma/interfaces/baseList.interface'
import { User, UserDetail } from '../interfaces/user.interface'

export class UserDto implements User {
  id: number
  firstname: string
  lastname: string
  username: string
  email: string
  password: string
  reset_password_token: string
  registration_token: string
  is_active: boolean
  blocked: boolean
  prefered_language: string
  created_at: Date
  updated_at: Date
  created_by_id: number
  updated_by_id: number
}

export class UserDetailDto extends UserDto implements UserDetail {
  admin_users_roles_links: admin_users_roles_links[]
}

export class UserListDto implements BaseList<User> {
  total: number

  @ApiProperty({
    type: UserDto,
    isArray: true,
  })
  data: User[]
}
