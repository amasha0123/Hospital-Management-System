# Firebase Setup & Data Management — Hospital Management System

This README explains how to create collections, load sample data, and run backups.

1) Create collections in Firebase Console
- Open Firebase Console → Firestore Database → Start collection.
- Example top-level collection names: `patients`, `doctors`, `appointments`, `audit_logs`.
- To create a subcollection: open a document (or create it), then use "Start collection" from inside the document and enter e.g. `medical_records`.

2) Importing sample data
- The file `firestore_sample_data.json` contains small example documents.
- There is no direct JSON import in the console; use a small admin script or `gcloud` / Admin SDK to write them.

Node.js Admin SDK example (run from a trusted environment):

```bash
# install
npm install firebase-admin
```

```js
// seed.js
const admin = require('firebase-admin');
const data = require('./firestore_sample_data.json');
admin.initializeApp({ credential: admin.credential.applicationDefault() });
const db = admin.firestore();

async function seed() {
  for (const p of data.patients) {
    await db.collection('patients').doc(p.id).set(p);
  }
  for (const d of data.doctors) {
    await db.collection('doctors').doc(d.id).set(d);
  }
  for (const a of data.appointments) {
    await db.collection('appointments').doc(a.id).set(a);
  }
  for (const l of data.audit_logs) {
    await db.collection('audit_logs').doc(l.id).set(l);
  }
  console.log('Seed complete');
}

seed().catch(console.error);
```

3) Backup & export (gcloud)
- Install the Google Cloud SDK and authenticate: `gcloud auth login` and set project.
- Export Firestore:

```bash
gcloud firestore export gs://YOUR_BACKUP_BUCKET/firestore-backups/$(date +%F)
```

- To restore, use `gcloud firestore import` (careful, imports can overwrite).

4) Setting custom claims for RBAC
- Use Admin SDK to set custom claims for a user (role), e.g. `admin.auth().setCustomUserClaims(uid, { role: 'DOCTOR' })`.

5) Security rules
- See `firestore_rules.rules` in the project. Copy into Firestore Rules editor and adapt roles/logic as needed.

6) Flutter setup notes
- Ensure `firebase_core`, `firebase_auth`, `cloud_firestore`, and `flutter_riverpod` are in `pubspec.yaml`.
- Initialize Firebase in `main.dart` with `WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp();`.
- Use `PatientRepository` (lib/data/repositories/patient_repository.dart) as an example repository.

7) Testing
- Use test Firebase project to avoid storing real patient data.
- Use smaller datasets for emulator testing with the Firebase Emulator Suite.

