import { ApiProperty } from '@nestjs/swagger'
import { Transform } from 'class-transformer'
import { IsNumber, IsOptional, Min } from 'class-validator'

type SortOrder = { [key: string]: 'asc' | 'desc' }
export class FindDto {
  @Transform(({ value }) => parseInt(value))
  @IsNumber()
  @Min(0)
  @IsOptional()
  skip?: number

  @Transform(({ value }) => parseInt(value))
  @IsNumber()
  @IsOptional()
  @Min(1)
  take?: number

  @ApiProperty({
    description: 'Prisma where object',
    type: {},
  })
  @IsOptional()
  @Transform(({ value }) => JSON.parse(value))
  where?: object

  @ApiProperty({
    description: 'Prisma orderBy object',
    type: {},
  })
  @IsOptional()
  @Transform(({ value }) => JSON.parse(value))
  orderBy?: SortOrder
}



// export class UserListDto implements BaseList<User> {
//   total: number

//   @ApiProperty({
//     type: UserDto,
//     isArray: true,
//   })
//   data: User[]
// }
