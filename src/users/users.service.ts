import { Injectable } from "@nestjs/common";
import { PrismaService } from "../prisma.service";

export type User = any;

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  async findOne(username: string): Promise<User | undefined> {
    return await this.prisma.user.findUnique({
      where: {
        username,
      },
    });
  }
}
