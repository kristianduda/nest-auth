import { Controller, Get, NotFoundException, Param, Query } from '@nestjs/common'
import { ApiTags } from '@nestjs/swagger'
import { Auth } from '../auth/decorators/auth.decorator'
import { CurrentUser } from '../auth/decorators/currentUser.decorator'
import { Role } from '../auth/enums/role.enum'
import { FindDto } from '../prisma/dto/find.dto'
import { FindOneDto } from '../prisma/dto/findOne.dto'
import { BaseList } from '../prisma/interfaces/baseList.interface'
import { User } from './interfaces/user.interface'
import { UsersService } from './users.service'

@ApiTags('users')
@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Auth()
  @Get('current')
  async currentUser(@CurrentUser() currentUser) {
    return await this.usersService.user(currentUser)
  }

  @Auth(Role.Admin)
  @Get(':id')
  async user(@Param() params: FindOneDto): Promise<User> {
    const user = await this.usersService.user(params.id)
    if(!user) {
      throw new NotFoundException();
    }

    return user;
  }

  @Auth(Role.Admin)
  @Get()
  async users(@Query() query: FindDto): Promise<BaseList<User>> {
    return await this.usersService.users(query);
  }
}
