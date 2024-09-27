import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../common/app_colors.dart';

class PDFScreen extends StatefulWidget {
  final String? url;  // Made the URL nullable

  const PDFScreen({super.key, this.url}); // URL is optional now

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  late Future<String> _pdfPath;
  String? localPath;

  @override
  void initState() {
    super.initState();
    if (widget.url != null && widget.url!.isNotEmpty) {
      // If URL is provided, download PDF from URL
      _pdfPath = downloadPDF(widget.url!);
    } else {
      // If no URL, load PDF from assets
      _pdfPath = loadPDF();
    }
  }

  Future<String> downloadPDF(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/downloaded.pdf';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } else {
      throw Exception('Failed to download PDF');
    }
  }

  Future<void> _handleDownload() async {
    try {
      final filePath = await downloadPDF(widget.url!);  // Download from URL
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF downloaded to $filePath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<String> loadPDF() async {
    final byteData = await rootBundle.load('assets/sample.pdf'); // Load the PDF from assets
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/sample.pdf');

    await file.writeAsBytes(byteData.buffer.asUint8List(), flush: true);
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          '',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 18,
              letterSpacing: 0.2,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        actions: widget.url != null && widget.url!.isNotEmpty
            ? [
          IconButton(
            icon: const Icon(
              Icons.download,
              color: AppColors.primaryDark,
              size: 25,
            ),
            onPressed: _handleDownload,
          ),
        ]
            : [],  // No download button if loading from assets
      ),
      body: FutureBuilder<String>(
        future: _pdfPath,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return PDFView(
              filePath: snapshot.data,
            );
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}