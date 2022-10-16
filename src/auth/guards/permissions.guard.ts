import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { Permission } from '../enums/permission.enum';

@Injectable()
export class PermissionsGuard implements CanActivate {
  constructor(private reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const requiredPermission = this.reflector.getAllAndOverride<Permission>('permissions', [
      context.getHandler(),
      context.getClass(),
    ])[0];

    if (!requiredPermission) {
      return true;
    }
    const { user } = context.switchToHttp().getRequest();
    return (user.permissions & requiredPermission) > 0;
  }
}
