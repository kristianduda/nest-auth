import { BadRequestException, Body, Controller, Delete, Get, NotFoundException, Param, Post, Put, Query } from '@nestjs/common'
import { ApiTags } from '@nestjs/swagger'
import { Auth } from '../auth/decorators/auth.decorator'
import { CurrentUser } from '../auth/decorators/currentUser.decorator'
import { Role } from '../auth/enums/role.enum'
import { FindDto } from '../prisma/dto/find.dto'
import { FindOneDto } from '../prisma/dto/findOne.dto'
import { BaseList } from '../prisma/interfaces/baseList.interface'
import { CreateUserDto } from './dto/createUser.dto'
import { UpdateUserDto } from './dto/updateUser.dto'
import { User } from './interfaces/user.interface'
import { UsersService } from './users.service'

@ApiTags('users')
@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Auth()
  @Get('current')
  async findCurrent(@CurrentUser() currentUser) {
    return await this.usersService.findById(currentUser)
  }

  @Auth(Role.Admin)
  @Put('current')
  async updateCurrent(@CurrentUser() currentUser, @Body() user: UpdateUserDto): Promise<User> {
    return await this.usersService.update(currentUser, user);
  }

  @Auth(Role.Admin)
  @Get(':id')
  async user(@Param() params: FindOneDto): Promise<User> {
    const user = await this.usersService.findById(params.id)
    if(!user) {
      throw new NotFoundException();
    }

    return user;
  }

  @Auth(Role.Admin)
  @Get()
  async get(@Query() query: FindDto): Promise<BaseList<User>> {
    return await this.usersService.get(query);
  }

  @Post()
  async create(@Body() user: CreateUserDto): Promise<User> {
    const u = await this.usersService.findByEmail(user.email);
    if(u) {
      throw new BadRequestException();
    } 

    return await this.usersService.create(user)
  }
  
  @Auth(Role.Admin)
  @Put(':id')
  async update(@Param() params: FindOneDto, @Body() user: UpdateUserDto): Promise<User> {
    return await this.usersService.update(params.id, user);
  }

  @Auth(Role.Admin)
  @Delete(':id')
  async delete(@Param() params: FindOneDto): Promise<User> {
    return await this.usersService.delete(params.id)
  }
}
