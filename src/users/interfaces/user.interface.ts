import { admin_users, admin_users_roles_links } from '@prisma/client'

export interface User extends admin_users {
  admin_users_roles_links?: admin_users_roles_links[]
}
