import { IsNotEmpty, IsOptional, IsString } from 'class-validator'

export class CreateUserDto {
  @IsString()
  @IsNotEmpty()
  email: string

  @IsString()
  @IsNotEmpty()
  password: string

  @IsString()
  @IsOptional()
  firstname?: string

  @IsString()
  @IsOptional()
  lastname?: string
}
