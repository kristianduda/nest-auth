import { Controller, Post, Request, UseGuards } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { AuthService } from './auth.service';
import { LocalAuthGuard } from './guards/local-auth.guard';

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @UseGuards(LocalAuthGuard)
  @Post('login')
  async login(@Request() req) {
    return this.authService.login(req.user);
  }

//   @UseGuards(JwtAuthGuard)
//   @Post('logout')
//   async logout(@CurrentUser() currentUser) {
//     return this.authService.logout(currentUser._id);
//   }

//   @UseGuards(RefreshAuthGuard) 
//   @Post('refresh')
//   async refresh(@CurrentUser() currentUser) {
//     const payload = await this.authService.refresh(currentUser);
//     if(!payload) {
//       throw new ForbiddenException()
//     }

//     return payload;
//   }
}
