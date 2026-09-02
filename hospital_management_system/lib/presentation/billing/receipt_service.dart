import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReceiptService {
  static Future<void> printInvoice({
    required String invoiceNumber,
    required String patientName,
    required String doctorName,
    required String serviceName,
    required double amount,
    required DateTime createdAt,
    required String status,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Hospital Management System',
                style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 8),
              pw.Text('Official Receipt / Invoice', style: const pw.TextStyle(fontSize: 16)),
              pw.Divider(),
              pw.SizedBox(height: 12),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Invoice No: $invoiceNumber'),
                  pw.Text('Date: ${createdAt.day}/${createdAt.month}/${createdAt.year}'),
                ],
              ),
              pw.SizedBox(height: 12),
              pw.Text('Patient: $patientName'),
              pw.Text('Doctor: $doctorName'),
              pw.Text('Service: $serviceName'),
              pw.Text('Status: $status'),
              pw.SizedBox(height: 18),
              pw.Container(
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey200,
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Total Amount', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Rs.${amount.toStringAsFixed(2)}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
              ),
              pw.Spacer(),
              pw.Text('Thank you for choosing our hospital services.', style: const pw.TextStyle(fontSize: 10)),
            ],
          );
        },
      ),
    );

    final bytes = await pdf.save();
    await Printing.layoutPdf(onLayout: (_) => Future.value(bytes));
  }

  static Future<Uint8List> buildInvoicePdf({
    required String invoiceNumber,
    required String patientName,
    required String doctorName,
    required String serviceName,
    required double amount,
    required DateTime createdAt,
    required String status,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Hospital Management System',
                style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 8),
              pw.Text('Official Receipt / Invoice', style: const pw.TextStyle(fontSize: 16)),
              pw.Divider(),
              pw.SizedBox(height: 12),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Invoice No: $invoiceNumber'),
                  pw.Text('Date: ${createdAt.day}/${createdAt.month}/${createdAt.year}'),
                ],
              ),
              pw.SizedBox(height: 12),
              pw.Text('Patient: $patientName'),
              pw.Text('Doctor: $doctorName'),
              pw.Text('Service: $serviceName'),
              pw.Text('Status: $status'),
              pw.SizedBox(height: 18),
              pw.Container(
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey200,
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Total Amount', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Rs.${amount.toStringAsFixed(2)}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
              ),
              pw.Spacer(),
              pw.Text('Thank you for choosing our hospital services.', style: const pw.TextStyle(fontSize: 10)),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
