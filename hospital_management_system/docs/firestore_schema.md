# Firestore Schema — Hospital Management System

This document describes the recommended Firestore collections and field schemas for the HMS project.

Top-level collections

- `users` (auth-linked users)
  - id: auto
  - name: string
  - email: string
  - role: string (ADMIN, DOCTOR, NURSE, RECEPTIONIST, PHARMACIST, ACCOUNTANT, LAB_STAFF)
  - employeeId: string
  - departmentId: string
  - isActive: bool
  - createdAt: timestamp
  - lastLogin: timestamp

- `patients`
  - patientNumber: string (e.g. "P001")
  - firstName: string
  - lastName: string
  - dateOfBirth: timestamp
  - gender: string
  - nic: string
  - phone: string
  - email: string
  - address: string
  - bloodGroup: string
  - emergencyContact: map { name, phone, relation }
  - createdAt: timestamp
  - updatedAt: timestamp

- `doctors`
  - employeeId: string
  - name: string
  - specialization: string
  - departmentId: string
  - phone: string
  - email: string
  - availability: array of strings
  - status: string
  - createdAt: timestamp

- `departments`
  - name: string
  - description: string
  - location: string
  - status: string

- `appointments`
  - patientId: string (ref/id)
  - doctorId: string (ref/id)
  - departmentId: string
  - appointmentDate: timestamp
  - reason: string
  - status: string (Scheduled, Confirmed, Completed, Cancelled, Rescheduled, No Show)
  - createdBy: string
  - createdAt: timestamp

- `medical_records` (option: top-level or patient subcollection)
  - patientId: string
  - doctorId: string
  - appointmentId: string
  - diagnosis: string
  - symptoms: string
  - treatment: string
  - notes: string
  - recordDate: timestamp
  - createdAt: timestamp

- `prescriptions`
  - patientId
  - doctorId
  - medicalRecordId
  - medicines: array of maps { medicineId, name, quantity, dosage }
  - instructions
  - date
  - status

- `laboratory_tests`
  - patientId
  - doctorId
  - testName
  - requestedDate
  - sampleCollected: bool
  - result: string
  - remarks: string
  - status
  - reportUrl

- `medicines`
  - name
  - category
  - quantity
  - unitPrice
  - expiryDate
  - supplier
  - reorderLevel
  - status

- `invoices`
  - patientId
  - items: array of maps { description, qty, unitPrice }
  - subtotal
  - discount
  - total
  - status
  - createdBy
  - createdAt

- `payments`
  - invoiceId
  - amount
  - paymentMethod
  - paymentDate
  - receivedBy

- `admissions`
  - patientId
  - doctorId
  - ward
  - bedNumber
  - admissionDate
  - dischargeDate
  - reason
  - status

- `employees`, `attendance`, `leave_records`

- `audit_logs`
  - userId
  - userName
  - action
  - module
  - recordId
  - timestamp
  - description

- `notifications`
  - userId
  - title
  - body
  - data
  - read: bool
  - createdAt: timestamp

Notes
- For sensitive documents (medical records, patient documents) prefer patient subcollections: `patients/{patientId}/medical_records`.
- Use Firestore `serverTimestamp()` for `createdAt` and `updatedAt` fields where appropriate.
- Where possible, store references using document IDs (string) and avoid duplicating large objects.

Security considerations
- Restrict read/write by role using custom claims and Firestore security rules.
- Protect file URLs in Firebase Storage using security rules and signed access (if needed).

Example path usages
- `patients` (top-level collection)
- `patients/{patientId}/medical_records` (subcollection)
- `appointments` (top-level collection)
- `audit_logs` (top-level collection)

