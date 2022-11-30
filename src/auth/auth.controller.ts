import { Controller, Post, Request, UseGuards } from '@nestjs/common'
import { ApiBody, ApiCreatedResponse, ApiTags } from '@nestjs/swagger'
import { LoginDto } from 'src/auth/dto/login.dto'
import { AuthService } from './auth.service'
import { CurrentUser } from './decorators/currentUser.decorator'
import { SessionDto } from './dto/session.dto'
import { LocalAuthGuard } from './guards/local-auth.guard'
import { RefreshAuthGuard } from './guards/refresh-auth.guard'

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @ApiBody({ type: LoginDto })
  @ApiCreatedResponse({ type: SessionDto })
  @UseGuards(LocalAuthGuard)
  @Post('login')
  async login(@Request() req) {
    return this.authService.login(req.user)
  }

  @ApiCreatedResponse({ type: SessionDto })
  @UseGuards(RefreshAuthGuard)
  @Post('refresh')
  async refresh(@CurrentUser() currentUser) {
    return await this.authService.refresh(currentUser)
  }
}
