import 'package:dr_ashraf_clinic/model/consultation_model.dart';
import 'package:dr_ashraf_clinic/utils/constants/sizes.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> printRouchete(List<PrescriptionModel> list) async {
  var pageFormat = PdfPageFormat.a5;
  final font = await PdfGoogleFonts.nunitoRegular();

  final doc = pw.Document();
  // Split content if necessary
  String content = list.map((name) => name.medicine).join('\n');

  await Printing.layoutPdf(
      format: pageFormat,
      onLayout: (pageFormat) async {
        final pageContent = splitContent(content, pageFormat);

        for (var page in pageContent) {
          doc.addPage(pw.Page(
            margin: const pw.EdgeInsets.only(
              left: HSizes.defaultSpace,
              top: 7 * (72 / 2.54),
            ),
            pageFormat: pageFormat,
            build: (pw.Context context) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // pw.SizedBox(height: 7 * (72 / 2.54)),
                pw.Text(page,
                    style: pw.TextStyle(
                      fontSize: 14,
                      font: font,
                      lineSpacing: 4,
                    )),
              ],
            ),
          ));
        }
        return doc.save();
      });
}

List<String> splitContent(String content, PdfPageFormat format) {
  // Split the content into pages based on the available height
  final List<String> pages = [];

  final double availableHeight = format.height - 440; // Adjust for margins
  double currentHeight = 0.0;
  // Initialize the first page
  pages.add('');
  for (var paragraph in content.split('\n')) {
    final paragraphHeight =
        measureTextHeight(paragraph, 14); // Adjust font size if needed
    if (currentHeight + paragraphHeight > availableHeight) {
      pages.add(''); // Add a new page
      currentHeight = 0.0;
    }
    pages.last += '$paragraph\n';
    currentHeight += paragraphHeight;
  }
  return pages;
}

double measureTextHeight(String text, double fontSize) {
  // Dummy function for height calculation; you may need to adjust this logic
  return text.split(' ').length * fontSize * 0.25; // Rough estimate
}
