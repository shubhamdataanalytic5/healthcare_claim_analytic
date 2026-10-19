-- SQL Server DDL
CREATE DATABASE HealthcareClaimsAnalytics;
GO
USE HealthcareClaimsAnalytics;
GO

CREATE TABLE Patients (
 patient_id VARCHAR(20) PRIMARY KEY, first_name VARCHAR(50), last_name VARCHAR(50),
 gender CHAR(1), date_of_birth DATE, state CHAR(2), insurance_type VARCHAR(30)
);
CREATE TABLE Providers (
 provider_id VARCHAR(20) PRIMARY KEY, provider_name VARCHAR(100), provider_type VARCHAR(50),
 state CHAR(2), network_status VARCHAR(30)
);
CREATE TABLE Payers (
 payer_id VARCHAR(20) PRIMARY KEY, payer_name VARCHAR(100), payer_type VARCHAR(30)
);
CREATE TABLE Diagnoses (
 diagnosis_code VARCHAR(20) PRIMARY KEY, diagnosis_description VARCHAR(200)
);
CREATE TABLE Procedures (
 cpt_code VARCHAR(10) PRIMARY KEY, procedure_description VARCHAR(200), service_category VARCHAR(50)
);
CREATE TABLE Claims (
 claim_id VARCHAR(20) PRIMARY KEY, patient_id VARCHAR(20), provider_id VARCHAR(20), payer_id VARCHAR(20),
 diagnosis_code VARCHAR(20), cpt_code VARCHAR(10), service_date DATE, submission_date DATE,
 payment_date DATE, claim_status VARCHAR(30), denial_reason VARCHAR(100),
 billed_amount DECIMAL(12,2), allowed_amount DECIMAL(12,2), deductible DECIMAL(12,2),
 copay DECIMAL(12,2), coinsurance DECIMAL(12,2), patient_responsibility DECIMAL(12,2),
 paid_amount DECIMAL(12,2), adjustment_amount DECIMAL(12,2),
 FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
 FOREIGN KEY (provider_id) REFERENCES Providers(provider_id),
 FOREIGN KEY (payer_id) REFERENCES Payers(payer_id),
 FOREIGN KEY (diagnosis_code) REFERENCES Diagnoses(diagnosis_code),
 FOREIGN KEY (cpt_code) REFERENCES Procedures(cpt_code)
);
GO
