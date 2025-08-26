/*
  Warnings:

  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "public"."Sizes" AS ENUM ('XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL');

-- CreateEnum
CREATE TYPE "public"."Rol" AS ENUM ('ADMIN', 'USER');

-- CreateEnum
CREATE TYPE "public"."paymentMethods" AS ENUM ('CASH', 'CARD', 'TRANSFER');

-- DropTable
DROP TABLE "public"."User";

-- CreateTable
CREATE TABLE "public"."Tshirts" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "size" "public"."Sizes" NOT NULL,
    "stock" INTEGER NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "colorId" INTEGER NOT NULL,

    CONSTRAINT "Tshirts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Colors" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "available" BOOLEAN NOT NULL,

    CONSTRAINT "Colors_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Users" (
    "id" SERIAL NOT NULL,
    "fullName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "rol" "public"."Rol" NOT NULL,

    CONSTRAINT "Users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Contact_Info" (
    "id" SERIAL NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Contact_Info_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Orders" (
    "id" SERIAL NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "paymentMethod" "public"."paymentMethods" NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Details" (
    "id" SERIAL NOT NULL,
    "unitPrice" DOUBLE PRECISION NOT NULL,
    "amount" INTEGER NOT NULL,
    "orderId" INTEGER NOT NULL,
    "tshirtId" INTEGER NOT NULL,

    CONSTRAINT "Details_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Users_email_key" ON "public"."Users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Contact_Info_userId_key" ON "public"."Contact_Info"("userId");

-- AddForeignKey
ALTER TABLE "public"."Tshirts" ADD CONSTRAINT "Tshirts_colorId_fkey" FOREIGN KEY ("colorId") REFERENCES "public"."Colors"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Contact_Info" ADD CONSTRAINT "Contact_Info_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Orders" ADD CONSTRAINT "Orders_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Details" ADD CONSTRAINT "Details_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "public"."Orders"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Details" ADD CONSTRAINT "Details_tshirtId_fkey" FOREIGN KEY ("tshirtId") REFERENCES "public"."Tshirts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
