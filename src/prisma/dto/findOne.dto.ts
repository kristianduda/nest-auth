import { Transform } from 'class-transformer'
import { IsNumber } from 'class-validator'

export class FindOneDto {
  @IsNumber()
  @Transform(({ value }) => parseInt(value))
  id: number
}
