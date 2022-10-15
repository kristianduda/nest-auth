import { Controller, Get, Request } from '@nestjs/common';
import { Auth } from '../auth/decorators/auth.decorator';
import { Permission } from 'src/auth/enums/permission.enum';

@Controller('users')
export class UsersController {  
    
  @Auth(Permission.Profile)
  @Get('profile')
  isAdmin(@Request() req) {
    return req.user;
  }
}
