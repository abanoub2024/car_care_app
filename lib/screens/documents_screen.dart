
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

import '../services/notification_service.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  DateTime? licenseExpiry;
  DateTime? insuranceExpiry;
  DateTime? inspectionExpiry;

  Future<void> saveLicenseDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'license_expiry',
      date.toIso8601String(),
    );
  }

  Future<void> saveInsuranceDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'insurance_expiry',
      date.toIso8601String(),
    );
  }

  Future<void> saveInspectionDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'inspection_expiry',
      date.toIso8601String(),
    );
  }

  Future<void> loadLicenseDate() async {
    final prefs = await SharedPreferences.getInstance();

    final savedDate = prefs.getString('license_expiry');

    if (savedDate != null) {
      setState(() {
        licenseExpiry = DateTime.parse(savedDate);
      });
    }
  }

  Future<void> loadInsuranceDate() async {
    final prefs = await SharedPreferences.getInstance();

    final savedDate = prefs.getString('insurance_expiry');

    if (savedDate != null) {
      setState(() {
        insuranceExpiry = DateTime.parse(savedDate);
      });
    }
  }

  Future<void> loadInspectionDate() async {
    final prefs = await SharedPreferences.getInstance();

    final savedDate = prefs.getString('inspection_expiry');

    if (savedDate != null) {
      setState(() {
        inspectionExpiry = DateTime.parse(savedDate);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    loadLicenseDate();
    loadInsuranceDate();
    loadInspectionDate();
  }

  Future<void> selectLicenseDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        licenseExpiry = pickedDate;
      });

      await saveLicenseDate(pickedDate);

      final expiryDate = tz.TZDateTime(
        tz.local,
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
      );

      await NotificationService.scheduleDocumentReminders(
        baseId: 100,
        documentName: 'License',
        expiryDate: expiryDate,
      );
    }
  }

  Future<void> selectInsuranceDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        insuranceExpiry = pickedDate;
      });

      await saveInsuranceDate(pickedDate);
      final expiryDate = tz.TZDateTime(
  tz.local,
  pickedDate.year,
  pickedDate.month,
  pickedDate.day,
);

await NotificationService.scheduleDocumentReminders(
  baseId: 200,
  documentName: 'Insurance',
  expiryDate: expiryDate,
);
    }
  }

  Future<void> selectInspectionDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        inspectionExpiry = pickedDate;
      });

      await saveInspectionDate(pickedDate);
      final expiryDate = tz.TZDateTime(
  tz.local,
  pickedDate.year,
  pickedDate.month,
  pickedDate.day,
);

await NotificationService.scheduleDocumentReminders(
  baseId: 300,
  documentName: 'Technical Inspection',
  expiryDate: expiryDate,
);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documents & Reminders'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Car Documents',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: selectLicenseDate,
              child: Text(
                licenseExpiry == null
                    ? 'Select License Expiry Date'
                    : 'License: ${licenseExpiry!.day}/${licenseExpiry!.month}/${licenseExpiry!.year}',
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: selectInsuranceDate,
              child: Text(
                insuranceExpiry == null
                    ? 'Select Insurance Expiry Date'
                    : 'Insurance: ${insuranceExpiry!.day}/${insuranceExpiry!.month}/${insuranceExpiry!.year}',
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: selectInspectionDate,
              child: Text(
                inspectionExpiry == null
                    ? 'Select Technical Inspection Date'
                    : 'Inspection: ${inspectionExpiry!.day}/${inspectionExpiry!.month}/${inspectionExpiry!.year}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

