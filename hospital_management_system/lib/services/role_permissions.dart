class RolePermissions {
  static const Map<String, List<String>> permissions = {
    'ADMIN': [
      'Manage users',
      'Manage patients',
      'Manage doctors',
      'Manage appointments',
      'Manage laboratory',
      'Manage pharmacy',
      'Manage billing',
      'View reports',
    ],
    'DOCTOR': [
      'View patients',
      'Manage medical records',
      'Manage prescriptions',
      'Request laboratory tests',
      'View appointments',
    ],
    'NURSE': [
      'View assigned patients',
      'Update nursing information',
      'View appointments',
      'View relevant medical information',
    ],
    'RECEPTIONIST': [
      'Register patients',
      'View patients',
      'Create appointments',
      'Manage appointments',
    ],
    'LAB_STAFF': [
      'View laboratory requests',
      'Update laboratory status',
      'Enter laboratory results',
      'Generate laboratory reports',
    ],
    'PHARMACIST': [
      'View prescriptions',
      'Manage medicines',
      'Manage inventory',
      'Process prescriptions',
    ],
    'ACCOUNTANT': [
      'View invoices',
      'Create invoices',
      'Record payments',
      'View financial reports',
    ],
  };

  static List<String> forRole(String role) {
    final normalized = role.toUpperCase();
    return permissions[normalized] ?? const [];
  }

  static bool canAccess(String role, String module) {
    final allowed = forRole(role);
    return allowed.contains(module) || role.toUpperCase() == 'ADMIN';
  }
}
