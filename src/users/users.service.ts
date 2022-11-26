import { Injectable } from '@nestjs/common'
import { Prisma } from '@prisma/client'
import { BaseList } from '../prisma/interfaces/baseList.interface'
import { PrismaService } from '../prisma/prisma.service'
import { User } from './interfaces/user.interface'

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  async userByEmail(email: string): Promise<User | undefined> {
    const user = await this.prisma.admin_users.findFirst({
      where: {
        email,
      },
      include: {
        admin_users_roles_links: true,
      },
    })

    return user
  }

  async user(id: number): Promise<User | null> {
    const user = await this.prisma.admin_users.findUnique({
      where: {
        id,
      },
      include: {
        admin_users_roles_links: true,
      },
    })

    if (user) {
      user.password = undefined
    }

    return user
  }

  async users(params: {
    skip?: number
    take?: number
    where?: Prisma.admin_usersWhereInput
    orderBy?: Prisma.admin_usersOrderByWithRelationInput
  }): Promise<BaseList<User>> {
    const { skip, take, where, orderBy } = params

    const total = await this.prisma.admin_users.count({ where })
    console.log(total)

    const data = await this.prisma.admin_users.findMany({
      skip,
      take,
      where,
      orderBy
    })

    return { total, data}
  }

  async createUser(data: Prisma.admin_usersCreateInput): Promise<User> {
    return this.prisma.admin_users.create({
      data,
    })
  }

  async updateUser(id: number, data: Prisma.admin_usersCreateInput): Promise<User> {
    return this.prisma.admin_users.update({
      data,
      where: { id },
    })
  }

  async deleteUser(id: number): Promise<User> {
    return this.prisma.admin_users.delete({
      where: {
        id,
      },
    })
  }
}
