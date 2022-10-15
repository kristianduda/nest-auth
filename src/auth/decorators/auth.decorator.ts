import { UseGuards } from '@nestjs/common';
import { applyDecorators } from '@nestjs/common';
import { SetMetadata } from '@nestjs/common';
import { JwtAuthGuard } from '../guards/jwt-auth.guard';
import { Permission } from '../enums/permission.enum';
import { PermissionsGuard } from '../guards/permissions.guard';

export function Auth(...permissions: Permission[]) {
  return applyDecorators(
    SetMetadata('permissions', permissions),
    UseGuards(JwtAuthGuard, PermissionsGuard),
    // ApiBearerAuth(),
    // ApiUnauthorizedResponse({ description: 'Unauthorized' }),
  );
}