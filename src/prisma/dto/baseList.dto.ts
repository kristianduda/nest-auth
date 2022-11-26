import { BaseList } from '../interfaces/baseList.interface'

export class BaseListDto implements BaseList<any> {
  total: number
  data: any[]
}
