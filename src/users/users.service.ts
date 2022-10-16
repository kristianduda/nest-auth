import { Injectable } from '@nestjs/common'
import { User } from '@prisma/client'
import { PrismaService } from '../prisma.service'

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  async findOneByEmail(email: string): Promise<User | undefined> {
    return await this.prisma.user.findUnique({
      where: {
        email,
      },
    })
  }

  async findOneById(id: number): Promise<User | undefined> {
    const user = await this.prisma.user.findUnique({
      where: {
        id,
      },
    })

    if (user) {
      user.password = undefined
    }

    return user
  }
}
