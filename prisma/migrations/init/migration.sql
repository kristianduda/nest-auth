-- CreateTable
CREATE TABLE "admin_permissions" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "action" TEXT,
    "subject" TEXT,
    "properties" json,
    "conditions" json,
    "created_at" DATETIME,
    "updated_at" DATETIME,
    "created_by_id" INTEGER,
    "updated_by_id" INTEGER,
    CONSTRAINT "admin_permissions_updated_by_id_fkey" FOREIGN KEY ("updated_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION,
    CONSTRAINT "admin_permissions_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "admin_permissions_role_links" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "permission_id" INTEGER,
    "role_id" INTEGER,
    "permission_order" INTEGER,
    CONSTRAINT "admin_permissions_role_links_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "admin_roles" ("id") ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT "admin_permissions_role_links_permission_id_fkey" FOREIGN KEY ("permission_id") REFERENCES "admin_permissions" ("id") ON DELETE CASCADE ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "admin_roles" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "code" TEXT,
    "description" TEXT,
    "created_at" DATETIME,
    "updated_at" DATETIME,
    "created_by_id" INTEGER,
    "updated_by_id" INTEGER,
    CONSTRAINT "admin_roles_updated_by_id_fkey" FOREIGN KEY ("updated_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION,
    CONSTRAINT "admin_roles_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "admin_users" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "firstname" TEXT,
    "lastname" TEXT,
    "username" TEXT,
    "email" TEXT,
    "password" TEXT,
    "reset_password_token" TEXT,
    "registration_token" TEXT,
    "is_active" BOOLEAN,
    "blocked" BOOLEAN,
    "prefered_language" TEXT,
    "created_at" DATETIME,
    "updated_at" DATETIME,
    "created_by_id" INTEGER,
    "updated_by_id" INTEGER,
    CONSTRAINT "admin_users_updated_by_id_fkey" FOREIGN KEY ("updated_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION,
    CONSTRAINT "admin_users_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "admin_users_roles_links" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "user_id" INTEGER,
    "role_id" INTEGER,
    "role_order" INTEGER,
    "user_order" INTEGER,
    CONSTRAINT "admin_users_roles_links_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "admin_roles" ("id") ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT "admin_users_roles_links_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "admin_users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "files" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "alternative_text" TEXT,
    "caption" TEXT,
    "width" INTEGER,
    "height" INTEGER,
    "formats" json,
    "hash" TEXT,
    "ext" TEXT,
    "mime" TEXT,
    "size" REAL,
    "url" TEXT,
    "preview_url" TEXT,
    "provider" TEXT,
    "provider_metadata" json,
    "folder_path" TEXT,
    "created_at" DATETIME,
    "updated_at" DATETIME,
    "created_by_id" INTEGER,
    "updated_by_id" INTEGER,
    CONSTRAINT "files_updated_by_id_fkey" FOREIGN KEY ("updated_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION,
    CONSTRAINT "files_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "files_folder_links" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "file_id" INTEGER,
    "folder_id" INTEGER,
    "file_order" INTEGER,
    CONSTRAINT "files_folder_links_folder_id_fkey" FOREIGN KEY ("folder_id") REFERENCES "upload_folders" ("id") ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT "files_folder_links_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files" ("id") ON DELETE CASCADE ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "files_related_morphs" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "file_id" INTEGER,
    "related_id" INTEGER,
    "related_type" TEXT,
    "field" TEXT,
    "order" INTEGER,
    CONSTRAINT "files_related_morphs_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files" ("id") ON DELETE CASCADE ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "i18n_locale" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "code" TEXT,
    "created_at" DATETIME,
    "updated_at" DATETIME,
    "created_by_id" INTEGER,
    "updated_by_id" INTEGER,
    CONSTRAINT "i18n_locale_updated_by_id_fkey" FOREIGN KEY ("updated_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION,
    CONSTRAINT "i18n_locale_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "strapi_api_token_permissions" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "action" TEXT,
    "created_at" DATETIME,
    "updated_at" DATETIME,
    "created_by_id" INTEGER,
    "updated_by_id" INTEGER,
    CONSTRAINT "strapi_api_token_permissions_updated_by_id_fkey" FOREIGN KEY ("updated_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION,
    CONSTRAINT "strapi_api_token_permissions_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "strapi_api_token_permissions_token_links" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "api_token_permission_id" INTEGER,
    "api_token_id" INTEGER,
    "api_token_permission_order" INTEGER,
    CONSTRAINT "strapi_api_token_permissions_token_links_api_token_id_fkey" FOREIGN KEY ("api_token_id") REFERENCES "strapi_api_tokens" ("id") ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT "strapi_api_token_permissions_token_links_api_token_permission_id_fkey" FOREIGN KEY ("api_token_permission_id") REFERENCES "strapi_api_token_permissions" ("id") ON DELETE CASCADE ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "strapi_api_tokens" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "description" TEXT,
    "type" TEXT,
    "access_key" TEXT,
    "last_used_at" DATETIME,
    "expires_at" DATETIME,
    "lifespan" BIGINT,
    "created_at" DATETIME,
    "updated_at" DATETIME,
    "created_by_id" INTEGER,
    "updated_by_id" INTEGER,
    CONSTRAINT "strapi_api_tokens_updated_by_id_fkey" FOREIGN KEY ("updated_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION,
    CONSTRAINT "strapi_api_tokens_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "strapi_core_store_settings" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "key" TEXT,
    "value" TEXT,
    "type" TEXT,
    "environment" TEXT,
    "tag" TEXT
);

-- CreateTable
CREATE TABLE "strapi_database_schema" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "schema" json,
    "time" DATETIME,
    "hash" TEXT
);

-- CreateTable
CREATE TABLE "strapi_migrations" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "time" DATETIME
);

-- CreateTable
CREATE TABLE "strapi_webhooks" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "url" TEXT,
    "headers" json,
    "events" json,
    "enabled" BOOLEAN
);

-- CreateTable
CREATE TABLE "up_permissions" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "action" TEXT,
    "created_at" DATETIME,
    "updated_at" DATETIME,
    "created_by_id" INTEGER,
    "updated_by_id" INTEGER,
    CONSTRAINT "up_permissions_updated_by_id_fkey" FOREIGN KEY ("updated_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION,
    CONSTRAINT "up_permissions_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "up_permissions_role_links" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "permission_id" INTEGER,
    "role_id" INTEGER,
    "permission_order" INTEGER,
    CONSTRAINT "up_permissions_role_links_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "up_roles" ("id") ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT "up_permissions_role_links_permission_id_fkey" FOREIGN KEY ("permission_id") REFERENCES "up_permissions" ("id") ON DELETE CASCADE ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "up_roles" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "description" TEXT,
    "type" TEXT,
    "created_at" DATETIME,
    "updated_at" DATETIME,
    "created_by_id" INTEGER,
    "updated_by_id" INTEGER,
    CONSTRAINT "up_roles_updated_by_id_fkey" FOREIGN KEY ("updated_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION,
    CONSTRAINT "up_roles_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "up_users" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "username" TEXT,
    "email" TEXT,
    "provider" TEXT,
    "password" TEXT,
    "reset_password_token" TEXT,
    "confirmation_token" TEXT,
    "confirmed" BOOLEAN,
    "blocked" BOOLEAN,
    "created_at" DATETIME,
    "updated_at" DATETIME,
    "created_by_id" INTEGER,
    "updated_by_id" INTEGER,
    CONSTRAINT "up_users_updated_by_id_fkey" FOREIGN KEY ("updated_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION,
    CONSTRAINT "up_users_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "up_users_role_links" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "user_id" INTEGER,
    "role_id" INTEGER,
    "user_order" INTEGER,
    CONSTRAINT "up_users_role_links_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "up_roles" ("id") ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT "up_users_role_links_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "up_users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "upload_folders" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "path_id" INTEGER,
    "path" TEXT,
    "created_at" DATETIME,
    "updated_at" DATETIME,
    "created_by_id" INTEGER,
    "updated_by_id" INTEGER,
    CONSTRAINT "upload_folders_updated_by_id_fkey" FOREIGN KEY ("updated_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION,
    CONSTRAINT "upload_folders_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "admin_users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "upload_folders_parent_links" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "folder_id" INTEGER,
    "inv_folder_id" INTEGER,
    "folder_order" INTEGER,
    CONSTRAINT "upload_folders_parent_links_inv_folder_id_fkey" FOREIGN KEY ("inv_folder_id") REFERENCES "upload_folders" ("id") ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT "upload_folders_parent_links_folder_id_fkey" FOREIGN KEY ("folder_id") REFERENCES "upload_folders" ("id") ON DELETE CASCADE ON UPDATE NO ACTION
);

-- CreateIndex
CREATE INDEX "admin_permissions_updated_by_id_fk" ON "admin_permissions"("updated_by_id");

-- CreateIndex
CREATE INDEX "admin_permissions_created_by_id_fk" ON "admin_permissions"("created_by_id");

-- CreateIndex
CREATE INDEX "admin_permissions_role_links_order_inv_fk" ON "admin_permissions_role_links"("permission_order");

-- CreateIndex
CREATE INDEX "admin_permissions_role_links_inv_fk" ON "admin_permissions_role_links"("role_id");

-- CreateIndex
CREATE INDEX "admin_permissions_role_links_fk" ON "admin_permissions_role_links"("permission_id");

-- CreateIndex
CREATE UNIQUE INDEX "admin_permissions_role_links_unique" ON "admin_permissions_role_links"("permission_id", "role_id");

-- CreateIndex
CREATE INDEX "admin_roles_updated_by_id_fk" ON "admin_roles"("updated_by_id");

-- CreateIndex
CREATE INDEX "admin_roles_created_by_id_fk" ON "admin_roles"("created_by_id");

-- CreateIndex
CREATE INDEX "admin_users_updated_by_id_fk" ON "admin_users"("updated_by_id");

-- CreateIndex
CREATE INDEX "admin_users_created_by_id_fk" ON "admin_users"("created_by_id");

-- CreateIndex
CREATE INDEX "admin_users_roles_links_order_inv_fk" ON "admin_users_roles_links"("user_order");

-- CreateIndex
CREATE INDEX "admin_users_roles_links_order_fk" ON "admin_users_roles_links"("role_order");

-- CreateIndex
CREATE INDEX "admin_users_roles_links_inv_fk" ON "admin_users_roles_links"("role_id");

-- CreateIndex
CREATE INDEX "admin_users_roles_links_fk" ON "admin_users_roles_links"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "admin_users_roles_links_unique" ON "admin_users_roles_links"("user_id", "role_id");

-- CreateIndex
CREATE INDEX "files_updated_by_id_fk" ON "files"("updated_by_id");

-- CreateIndex
CREATE INDEX "files_created_by_id_fk" ON "files"("created_by_id");

-- CreateIndex
CREATE INDEX "upload_files_folder_path_index" ON "files"("folder_path");

-- CreateIndex
CREATE INDEX "files_folder_links_order_inv_fk" ON "files_folder_links"("file_order");

-- CreateIndex
CREATE INDEX "files_folder_links_inv_fk" ON "files_folder_links"("folder_id");

-- CreateIndex
CREATE INDEX "files_folder_links_fk" ON "files_folder_links"("file_id");

-- CreateIndex
CREATE UNIQUE INDEX "files_folder_links_unique" ON "files_folder_links"("file_id", "folder_id");

-- CreateIndex
CREATE INDEX "files_related_morphs_fk" ON "files_related_morphs"("file_id");

-- CreateIndex
CREATE INDEX "i18n_locale_updated_by_id_fk" ON "i18n_locale"("updated_by_id");

-- CreateIndex
CREATE INDEX "i18n_locale_created_by_id_fk" ON "i18n_locale"("created_by_id");

-- CreateIndex
CREATE INDEX "strapi_api_token_permissions_updated_by_id_fk" ON "strapi_api_token_permissions"("updated_by_id");

-- CreateIndex
CREATE INDEX "strapi_api_token_permissions_created_by_id_fk" ON "strapi_api_token_permissions"("created_by_id");

-- CreateIndex
CREATE INDEX "strapi_api_token_permissions_token_links_order_inv_fk" ON "strapi_api_token_permissions_token_links"("api_token_permission_order");

-- CreateIndex
CREATE INDEX "strapi_api_token_permissions_token_links_inv_fk" ON "strapi_api_token_permissions_token_links"("api_token_id");

-- CreateIndex
CREATE INDEX "strapi_api_token_permissions_token_links_fk" ON "strapi_api_token_permissions_token_links"("api_token_permission_id");

-- CreateIndex
CREATE UNIQUE INDEX "strapi_api_token_permissions_token_links_unique" ON "strapi_api_token_permissions_token_links"("api_token_permission_id", "api_token_id");

-- CreateIndex
CREATE INDEX "strapi_api_tokens_updated_by_id_fk" ON "strapi_api_tokens"("updated_by_id");

-- CreateIndex
CREATE INDEX "strapi_api_tokens_created_by_id_fk" ON "strapi_api_tokens"("created_by_id");

-- CreateIndex
CREATE INDEX "up_permissions_updated_by_id_fk" ON "up_permissions"("updated_by_id");

-- CreateIndex
CREATE INDEX "up_permissions_created_by_id_fk" ON "up_permissions"("created_by_id");

-- CreateIndex
CREATE INDEX "up_permissions_role_links_order_inv_fk" ON "up_permissions_role_links"("permission_order");

-- CreateIndex
CREATE INDEX "up_permissions_role_links_inv_fk" ON "up_permissions_role_links"("role_id");

-- CreateIndex
CREATE INDEX "up_permissions_role_links_fk" ON "up_permissions_role_links"("permission_id");

-- CreateIndex
CREATE UNIQUE INDEX "up_permissions_role_links_unique" ON "up_permissions_role_links"("permission_id", "role_id");

-- CreateIndex
CREATE INDEX "up_roles_updated_by_id_fk" ON "up_roles"("updated_by_id");

-- CreateIndex
CREATE INDEX "up_roles_created_by_id_fk" ON "up_roles"("created_by_id");

-- CreateIndex
CREATE INDEX "up_users_updated_by_id_fk" ON "up_users"("updated_by_id");

-- CreateIndex
CREATE INDEX "up_users_created_by_id_fk" ON "up_users"("created_by_id");

-- CreateIndex
CREATE INDEX "up_users_role_links_order_inv_fk" ON "up_users_role_links"("user_order");

-- CreateIndex
CREATE INDEX "up_users_role_links_inv_fk" ON "up_users_role_links"("role_id");

-- CreateIndex
CREATE INDEX "up_users_role_links_fk" ON "up_users_role_links"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "up_users_role_links_unique" ON "up_users_role_links"("user_id", "role_id");

-- CreateIndex
CREATE UNIQUE INDEX "upload_folders_path_id_index" ON "upload_folders"("path_id");

-- CreateIndex
CREATE UNIQUE INDEX "upload_folders_path_index" ON "upload_folders"("path");

-- CreateIndex
CREATE INDEX "upload_folders_updated_by_id_fk" ON "upload_folders"("updated_by_id");

-- CreateIndex
CREATE INDEX "upload_folders_created_by_id_fk" ON "upload_folders"("created_by_id");

-- CreateIndex
CREATE INDEX "upload_folders_parent_links_order_inv_fk" ON "upload_folders_parent_links"("folder_order");

-- CreateIndex
CREATE INDEX "upload_folders_parent_links_inv_fk" ON "upload_folders_parent_links"("inv_folder_id");

-- CreateIndex
CREATE INDEX "upload_folders_parent_links_fk" ON "upload_folders_parent_links"("folder_id");

-- CreateIndex
CREATE UNIQUE INDEX "upload_folders_parent_links_unique" ON "upload_folders_parent_links"("folder_id", "inv_folder_id");

