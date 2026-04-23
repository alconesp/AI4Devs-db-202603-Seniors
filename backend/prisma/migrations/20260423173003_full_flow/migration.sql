/*
  Warnings:

  - Added the required column `updatedAt` to the `Candidate` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Candidate" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- CreateTable
CREATE TABLE "position_status" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,

    CONSTRAINT "position_status_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "application_status" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,

    CONSTRAINT "application_status_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "interview_result" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,

    CONSTRAINT "interview_result_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "employment_type" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,

    CONSTRAINT "employment_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "company" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "company_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "employee" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "role" VARCHAR(100) NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "employee_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "interview_flow" (
    "id" SERIAL NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "interview_flow_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "interview_type" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "interview_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "interview_step" (
    "id" SERIAL NOT NULL,
    "interviewFlowId" INTEGER NOT NULL,
    "interviewTypeId" INTEGER NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "orderIndex" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "interview_step_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "position" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "interviewFlowId" INTEGER NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "statusId" INTEGER NOT NULL,
    "isVisible" BOOLEAN NOT NULL DEFAULT false,
    "location" VARCHAR(255),
    "jobDescription" TEXT,
    "requirements" TEXT,
    "responsibilities" TEXT,
    "salaryMin" DECIMAL(10,2),
    "salaryMax" DECIMAL(10,2),
    "employmentTypeId" INTEGER,
    "benefits" TEXT,
    "applicationDeadline" TIMESTAMP(3),
    "contactInfo" VARCHAR(255),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "position_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "application" (
    "id" SERIAL NOT NULL,
    "positionId" INTEGER NOT NULL,
    "candidateId" INTEGER NOT NULL,
    "applicationDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "statusId" INTEGER NOT NULL,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "application_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "interview" (
    "id" SERIAL NOT NULL,
    "applicationId" INTEGER NOT NULL,
    "interviewStepId" INTEGER NOT NULL,
    "employeeId" INTEGER NOT NULL,
    "interviewDate" TIMESTAMP(3) NOT NULL,
    "resultId" INTEGER,
    "score" INTEGER,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "interview_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "position_status_name_key" ON "position_status"("name");

-- CreateIndex
CREATE UNIQUE INDEX "application_status_name_key" ON "application_status"("name");

-- CreateIndex
CREATE UNIQUE INDEX "interview_result_name_key" ON "interview_result"("name");

-- CreateIndex
CREATE UNIQUE INDEX "employment_type_name_key" ON "employment_type"("name");

-- CreateIndex
CREATE UNIQUE INDEX "company_name_key" ON "company"("name");

-- CreateIndex
CREATE UNIQUE INDEX "employee_email_key" ON "employee"("email");

-- CreateIndex
CREATE INDEX "employee_companyId_idx" ON "employee"("companyId");

-- CreateIndex
CREATE INDEX "employee_isActive_idx" ON "employee"("isActive");

-- CreateIndex
CREATE UNIQUE INDEX "interview_type_name_key" ON "interview_type"("name");

-- CreateIndex
CREATE INDEX "interview_step_interviewFlowId_idx" ON "interview_step"("interviewFlowId");

-- CreateIndex
CREATE INDEX "interview_step_interviewTypeId_idx" ON "interview_step"("interviewTypeId");

-- CreateIndex
CREATE UNIQUE INDEX "interview_step_interviewFlowId_orderIndex_key" ON "interview_step"("interviewFlowId", "orderIndex");

-- CreateIndex
CREATE INDEX "position_companyId_idx" ON "position"("companyId");

-- CreateIndex
CREATE INDEX "position_interviewFlowId_idx" ON "position"("interviewFlowId");

-- CreateIndex
CREATE INDEX "position_statusId_idx" ON "position"("statusId");

-- CreateIndex
CREATE INDEX "position_employmentTypeId_idx" ON "position"("employmentTypeId");

-- CreateIndex
CREATE INDEX "position_isVisible_idx" ON "position"("isVisible");

-- CreateIndex
CREATE INDEX "application_positionId_idx" ON "application"("positionId");

-- CreateIndex
CREATE INDEX "application_candidateId_idx" ON "application"("candidateId");

-- CreateIndex
CREATE INDEX "application_statusId_idx" ON "application"("statusId");

-- CreateIndex
CREATE INDEX "application_applicationDate_idx" ON "application"("applicationDate");

-- CreateIndex
CREATE UNIQUE INDEX "application_positionId_candidateId_key" ON "application"("positionId", "candidateId");

-- CreateIndex
CREATE INDEX "interview_applicationId_idx" ON "interview"("applicationId");

-- CreateIndex
CREATE INDEX "interview_interviewStepId_idx" ON "interview"("interviewStepId");

-- CreateIndex
CREATE INDEX "interview_employeeId_idx" ON "interview"("employeeId");

-- CreateIndex
CREATE INDEX "interview_interviewDate_idx" ON "interview"("interviewDate");

-- CreateIndex
CREATE INDEX "interview_resultId_idx" ON "interview"("resultId");

-- CreateIndex
CREATE INDEX "Education_candidateId_idx" ON "Education"("candidateId");

-- CreateIndex
CREATE INDEX "Resume_candidateId_idx" ON "Resume"("candidateId");

-- CreateIndex
CREATE INDEX "WorkExperience_candidateId_idx" ON "WorkExperience"("candidateId");

-- AddForeignKey
ALTER TABLE "employee" ADD CONSTRAINT "employee_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "interview_step" ADD CONSTRAINT "interview_step_interviewFlowId_fkey" FOREIGN KEY ("interviewFlowId") REFERENCES "interview_flow"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "interview_step" ADD CONSTRAINT "interview_step_interviewTypeId_fkey" FOREIGN KEY ("interviewTypeId") REFERENCES "interview_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "position" ADD CONSTRAINT "position_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "position" ADD CONSTRAINT "position_interviewFlowId_fkey" FOREIGN KEY ("interviewFlowId") REFERENCES "interview_flow"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "position" ADD CONSTRAINT "position_statusId_fkey" FOREIGN KEY ("statusId") REFERENCES "position_status"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "position" ADD CONSTRAINT "position_employmentTypeId_fkey" FOREIGN KEY ("employmentTypeId") REFERENCES "employment_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "application" ADD CONSTRAINT "application_positionId_fkey" FOREIGN KEY ("positionId") REFERENCES "position"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "application" ADD CONSTRAINT "application_candidateId_fkey" FOREIGN KEY ("candidateId") REFERENCES "Candidate"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "application" ADD CONSTRAINT "application_statusId_fkey" FOREIGN KEY ("statusId") REFERENCES "application_status"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "interview" ADD CONSTRAINT "interview_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "application"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "interview" ADD CONSTRAINT "interview_interviewStepId_fkey" FOREIGN KEY ("interviewStepId") REFERENCES "interview_step"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "interview" ADD CONSTRAINT "interview_employeeId_fkey" FOREIGN KEY ("employeeId") REFERENCES "employee"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "interview" ADD CONSTRAINT "interview_resultId_fkey" FOREIGN KEY ("resultId") REFERENCES "interview_result"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
