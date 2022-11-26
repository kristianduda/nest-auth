import { admin_users, admin_users_roles_links } from '@prisma/client'

export type User = admin_users

export interface UserDetail extends User {
  admin_users_roles_links: admin_users_roles_links[]
}
