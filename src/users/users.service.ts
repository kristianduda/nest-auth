import { Injectable } from '@nestjs/common'
import { Prisma } from '@prisma/client'
import * as bcrypt from 'bcrypt'
import { BaseList } from '../prisma/interfaces/baseList.interface'
import { PrismaService } from '../prisma/prisma.service'
import { User, UserDetail } from './interfaces/user.interface'

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  async findByEmail(email: string): Promise<UserDetail | undefined> {
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

  async findById(id: number): Promise<UserDetail | null> {
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

  async get(params: {
    skip?: number
    take?: number
    where?: Prisma.admin_usersWhereInput
    orderBy?: Prisma.admin_usersOrderByWithRelationInput
  }): Promise<BaseList<User>> {
    const { skip, take, where, orderBy } = params

    const total = await this.prisma.admin_users.count({ where })
    const data = await this.prisma.admin_users.findMany({
      skip,
      take,
      where,
      orderBy
    })

    return { total, data}
  }

  async create(data: Prisma.admin_usersCreateInput): Promise<User> {
    data.password = await bcrypt.hash(data.password, 10)

    return this.prisma.admin_users.create({
      data,
    })
  }

  async update(id: number, data: Prisma.admin_usersCreateInput): Promise<User> {
    return this.prisma.admin_users.update({
      data,
      where: { id },
    })
  }

  async delete(id: number): Promise<User> {
    return this.prisma.admin_users.delete({
      where: {
        id,
      },
    })
  }
}
