/*M!999999\- enable the sandbox mode */ 
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "base_unit" (
  "id" int(11) NOT NULL AUTO_INCREMENT,
  "name" varchar(255) NOT NULL,
  "description" text DEFAULT NULL,
  "company_id" int(11) NOT NULL,
  "created_by" int(11) DEFAULT NULL,
  "updated_by" int(11) DEFAULT NULL,
  "create_time" datetime DEFAULT current_timestamp(),
  "update_time" datetime DEFAULT NULL,
  PRIMARY KEY ("id"),
  UNIQUE KEY "unique_company_name" ("company_id","name"),
  CONSTRAINT "fk_base_unit_company_id" FOREIGN KEY ("company_id") REFERENCES "companies" ("id") ON DELETE CASCADE
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "companies" (
  "id" int(11) NOT NULL AUTO_INCREMENT,
  "name" varchar(255) NOT NULL,
  "mobile" bigint(20) NOT NULL,
  "email" varchar(255) NOT NULL,
  "address" varchar(255) NOT NULL,
  "logo" blob DEFAULT NULL,
  "business_type" enum('RETAIL','WHOLESALE') NOT NULL DEFAULT 'WHOLESALE',
  "status" enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  "created_by" int(11) DEFAULT NULL,
  "updated_by" int(11) DEFAULT NULL,
  "create_time" datetime DEFAULT current_timestamp(),
  "update_time" datetime DEFAULT NULL,
  PRIMARY KEY ("id"),
  UNIQUE KEY "name" ("name"),
  UNIQUE KEY "mobile" ("mobile"),
  UNIQUE KEY "email" ("email")
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "databasechangelog" (
  "ID" varchar(255) NOT NULL,
  "AUTHOR" varchar(255) NOT NULL,
  "FILENAME" varchar(255) NOT NULL,
  "DATEEXECUTED" datetime NOT NULL,
  "ORDEREXECUTED" int(11) NOT NULL,
  "EXECTYPE" varchar(10) NOT NULL,
  "MD5SUM" varchar(35) DEFAULT NULL,
  "DESCRIPTION" varchar(255) DEFAULT NULL,
  "COMMENTS" varchar(255) DEFAULT NULL,
  "TAG" varchar(255) DEFAULT NULL,
  "LIQUIBASE" varchar(20) DEFAULT NULL,
  "CONTEXTS" varchar(255) DEFAULT NULL,
  "LABELS" varchar(255) DEFAULT NULL,
  "DEPLOYMENT_ID" varchar(10) DEFAULT NULL
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "databasechangeloglock" (
  "ID" int(11) NOT NULL,
  "LOCKED" bit(1) NOT NULL,
  "LOCKGRANTED" datetime DEFAULT NULL,
  "LOCKEDBY" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("ID")
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "order_items" (
  "id" int(11) NOT NULL AUTO_INCREMENT,
  "order_id" int(11) DEFAULT NULL,
  "product_id" int(11) DEFAULT NULL,
  "product_code" varchar(15) DEFAULT NULL,
  "name" varchar(255) DEFAULT NULL,
  "quantity" decimal(10,2) DEFAULT NULL,
  "unit_price" decimal(10,2) DEFAULT 0.00,
  "total_price" decimal(10,2) DEFAULT 0.00,
  "created_by" int(11) DEFAULT NULL,
  "updated_by" int(11) DEFAULT NULL,
  "create_time" datetime DEFAULT current_timestamp(),
  "update_time" datetime DEFAULT NULL,
  PRIMARY KEY ("id"),
  KEY "FK_order_items_product_id" ("product_id"),
  KEY "idx_order_product" ("order_id","product_id"),
  CONSTRAINT "FK_order_items_order_id" FOREIGN KEY ("order_id") REFERENCES "orders" ("id") ON DELETE CASCADE,
  CONSTRAINT "FK_order_items_product_id" FOREIGN KEY ("product_id") REFERENCES "products" ("id") ON DELETE CASCADE
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "orders" (
  "id" int(11) NOT NULL AUTO_INCREMENT,
  "total_amount" decimal(10,2) DEFAULT NULL,
  "status" enum('PLACED','IN_PROGRESS','READY_FOR_DELIVERY','OUT_FOR_DELIVERY','DELIVERED') NOT NULL DEFAULT 'PLACED',
  "comment" varchar(250) DEFAULT NULL,
  "retailer_id" int(11) NOT NULL,
  "retailer_company_id" int(11) NOT NULL,
  "wholesaler_company_id" int(11) NOT NULL,
  "added_by" varchar(255) DEFAULT NULL,
  "modify_by" varchar(255) DEFAULT NULL,
  "order_der_date" date DEFAULT NULL,
  "order_der_time" time DEFAULT curtime(),
  "created_by" int(11) DEFAULT NULL,
  "updated_by" int(11) DEFAULT NULL,
  "create_time" datetime DEFAULT current_timestamp(),
  "update_time" datetime DEFAULT NULL,
  PRIMARY KEY ("id"),
  KEY "FK_orders_retailer_id" ("retailer_id"),
  KEY "fk_orders_retailer_company_id" ("retailer_company_id"),
  KEY "fk_orders_wholesaler_company_id" ("wholesaler_company_id"),
  CONSTRAINT "FK_orders_retailer_id" FOREIGN KEY ("retailer_id") REFERENCES "users" ("id") ON DELETE CASCADE,
  CONSTRAINT "fk_orders_retailer_company_id" FOREIGN KEY ("retailer_company_id") REFERENCES "companies" ("id") ON DELETE CASCADE,
  CONSTRAINT "fk_orders_wholesaler_company_id" FOREIGN KEY ("wholesaler_company_id") REFERENCES "companies" ("id") ON DELETE CASCADE
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "payments" (
  "id" int(11) NOT NULL AUTO_INCREMENT,
  "payment_method" enum('CASH','CREDIT_CARD','DEBIT_CARD') NOT NULL,
  "amount" decimal(10,2) NOT NULL,
  "payment_date" date NOT NULL,
  "comment" varchar(255) DEFAULT NULL,
  "received_by" varchar(15) DEFAULT NULL,
  "modify_by" varchar(15) DEFAULT NULL,
  "retailer_id" int(11) NOT NULL,
  "retailer_company_id" int(11) NOT NULL,
  "wholesaler_company_id" int(11) NOT NULL,
  "created_by" int(11) DEFAULT NULL,
  "updated_by" int(11) DEFAULT NULL,
  "create_time" datetime DEFAULT current_timestamp(),
  "update_time" datetime DEFAULT NULL,
  PRIMARY KEY ("id"),
  KEY "fk_payments_retailer_id" ("retailer_id"),
  KEY "fk_payments_retailer_company_id" ("retailer_company_id"),
  KEY "fk_payments_wholesaler_company_id" ("wholesaler_company_id"),
  CONSTRAINT "fk_payments_retailer_company_id" FOREIGN KEY ("retailer_company_id") REFERENCES "companies" ("id") ON DELETE CASCADE,
  CONSTRAINT "fk_payments_retailer_id" FOREIGN KEY ("retailer_id") REFERENCES "users" ("id") ON DELETE CASCADE,
  CONSTRAINT "fk_payments_wholesaler_company_id" FOREIGN KEY ("wholesaler_company_id") REFERENCES "companies" ("id") ON DELETE CASCADE
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "product_categories" (
  "id" int(11) NOT NULL AUTO_INCREMENT,
  "name" varchar(255) NOT NULL,
  "description" varchar(255) NOT NULL,
  "parent_id" int(11) DEFAULT NULL,
  "company_id" int(11) NOT NULL,
  "created_by" int(11) DEFAULT NULL,
  "updated_by" int(11) DEFAULT NULL,
  "create_time" datetime DEFAULT current_timestamp(),
  "update_time" datetime DEFAULT NULL,
  PRIMARY KEY ("id"),
  UNIQUE KEY "unique_company_name" ("company_id","name"),
  CONSTRAINT "fk_product_categories_company_id" FOREIGN KEY ("company_id") REFERENCES "companies" ("id") ON DELETE CASCADE
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "products" (
  "id" int(11) NOT NULL AUTO_INCREMENT,
  "code" varchar(255) NOT NULL,
  "description" varchar(255) NOT NULL,
  "category_id" int(11) NOT NULL,
  "pack_size" varchar(255) DEFAULT NULL,
  "item_Name" varchar(255) DEFAULT NULL,
  "current_Stock" int(11) DEFAULT 0,
  "stock_Limit" int(11) DEFAULT 10,
  "buy_Price" decimal(10,2) NOT NULL,
  "sell_Price" decimal(10,2) NOT NULL,
  "profit" decimal(10,2) NOT NULL,
  "base_unit" int(11) DEFAULT NULL,
  "tax_type" varchar(255) DEFAULT NULL,
  "token" varchar(255) DEFAULT NULL,
  "company_id" int(11) NOT NULL,
  "created_by" int(11) DEFAULT NULL,
  "updated_by" int(11) DEFAULT NULL,
  "create_time" datetime DEFAULT current_timestamp(),
  "update_time" datetime DEFAULT NULL,
  PRIMARY KEY ("id"),
  UNIQUE KEY "unique_company_code" ("company_id","code"),
  KEY "fk_products_category_id" ("category_id"),
  KEY "fk_products_base_unit" ("base_unit"),
  CONSTRAINT "fk_products_base_unit" FOREIGN KEY ("base_unit") REFERENCES "base_unit" ("id") ON DELETE CASCADE,
  CONSTRAINT "fk_products_category_id" FOREIGN KEY ("category_id") REFERENCES "product_categories" ("id") ON DELETE CASCADE,
  CONSTRAINT "fk_products_company_id" FOREIGN KEY ("company_id") REFERENCES "companies" ("id") ON DELETE CASCADE
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "user_roles" (
  "id" int(11) NOT NULL AUTO_INCREMENT,
  "user_id" int(11) NOT NULL,
  "company_id" int(11) NOT NULL,
  "role_name" enum('ADMIN','SALESMAN','STOCK_MANAGER','DELIVERY_STAFF','RETAILER_ADMIN','SUPER_ADMIN') NOT NULL DEFAULT 'SALESMAN',
  "created_by" int(11) DEFAULT NULL,
  "updated_by" int(11) DEFAULT NULL,
  "create_time" datetime DEFAULT current_timestamp(),
  "update_time" datetime DEFAULT NULL,
  PRIMARY KEY ("id"),
  UNIQUE KEY "id" ("id"),
  UNIQUE KEY "unique_user_role" ("user_id","company_id","role_name"),
  KEY "fk_user_roles_company_id" ("company_id"),
  CONSTRAINT "fk_user_roles_company_id" FOREIGN KEY ("company_id") REFERENCES "companies" ("id") ON DELETE CASCADE,
  CONSTRAINT "fk_user_roles_user_id" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "users" (
  "id" int(11) NOT NULL AUTO_INCREMENT,
  "name" varchar(255) NOT NULL,
  "username" varchar(255) NOT NULL,
  "password" varchar(255) NOT NULL,
  "email" varchar(255) NOT NULL,
  "mobile" bigint(20) DEFAULT NULL,
  "address" varchar(255) NOT NULL,
  "created_by" int(11) DEFAULT NULL,
  "updated_by" int(11) DEFAULT NULL,
  "create_time" timestamp NULL DEFAULT current_timestamp(),
  "update_time" timestamp NULL DEFAULT NULL,
  PRIMARY KEY ("id"),
  UNIQUE KEY "username" ("username"),
  UNIQUE KEY "email" ("email"),
  UNIQUE KEY "uk_username" ("username"),
  UNIQUE KEY "uk_email" ("email"),
  UNIQUE KEY "mobile" ("mobile"),
  UNIQUE KEY "uk_mobile" ("mobile")
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "users_company_map" (
  "id" int(11) NOT NULL AUTO_INCREMENT,
  "user_id" int(11) NOT NULL,
  "company_id" int(11) NOT NULL,
  "created_by" int(11) DEFAULT NULL,
  "updated_by" int(11) DEFAULT NULL,
  "create_time" datetime DEFAULT current_timestamp(),
  "update_time" datetime DEFAULT NULL,
  PRIMARY KEY ("id"),
  UNIQUE KEY "unique_company_user" ("user_id","company_id"),
  KEY "fk_user_company_map_company_id" ("company_id"),
  CONSTRAINT "fk_user_company_map_company_id" FOREIGN KEY ("company_id") REFERENCES "companies" ("id") ON DELETE CASCADE,
  CONSTRAINT "fk_user_company_map_user_id" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "users_retailer_map" (
  "id" int(11) NOT NULL AUTO_INCREMENT,
  "user_id" int(11) NOT NULL,
  "retailer_id" int(11) NOT NULL,
  "retailer_company_id" int(11) NOT NULL,
  "created_by" int(11) NOT NULL,
  "updated_by" int(11) DEFAULT NULL,
  "create_time" datetime DEFAULT current_timestamp(),
  "update_time" datetime DEFAULT NULL,
  PRIMARY KEY ("id"),
  UNIQUE KEY "unique_wholesalerUser_retailer" ("user_id","retailer_id","retailer_company_id"),
  KEY "fk_user_retailer_company_map_id" ("retailer_company_id"),
  KEY "fk_user_retailer_map_created_id" ("retailer_id"),
  CONSTRAINT "fk_user_retailer_company_map_id" FOREIGN KEY ("retailer_company_id") REFERENCES "companies" ("id") ON DELETE CASCADE,
  CONSTRAINT "fk_user_retailer_map_created_id" FOREIGN KEY ("retailer_id") REFERENCES "users" ("id") ON DELETE CASCADE,
  CONSTRAINT "fk_user_retailer_map_user_id" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE "users_wholesaler_map" (
  "id" int(11) NOT NULL AUTO_INCREMENT,
  "retailer_id" int(11) NOT NULL,
  "retailer_company_id" int(11) NOT NULL,
  "wholesaler_company_id" int(11) NOT NULL,
  "created_by" int(11) NOT NULL,
  "updated_by" int(11) DEFAULT NULL,
  "create_time" datetime DEFAULT current_timestamp(),
  "update_time" datetime DEFAULT NULL,
  PRIMARY KEY ("id"),
  UNIQUE KEY "unique_retailerUser_wholesaler" ("retailer_id","retailer_company_id","wholesaler_company_id"),
  KEY "fk_user_wholesaler_map_retailer_company_id" ("retailer_company_id"),
  KEY "fk_user_wholesaler_map_wholesaler_company_id" ("wholesaler_company_id"),
  CONSTRAINT "fk_user_wholesaler_map_retailer_company_id" FOREIGN KEY ("retailer_company_id") REFERENCES "companies" ("id") ON DELETE CASCADE,
  CONSTRAINT "fk_user_wholesaler_map_user_id" FOREIGN KEY ("retailer_id") REFERENCES "users" ("id") ON DELETE CASCADE,
  CONSTRAINT "fk_user_wholesaler_map_wholesaler_company_id" FOREIGN KEY ("wholesaler_company_id") REFERENCES "companies" ("id") ON DELETE CASCADE
);
/*!40101 SET character_set_client = @saved_cs_client */;
