import 'package:flutter/material.dart';

class BuildInvoiceUpload extends StatelessWidget {
  const BuildInvoiceUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.upload_file, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 10),
          const Text(
            "قم برفع الفاتورة هنا",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: () {}, child: const Text("حدد الفاتورة")),
        ],
      ),
    );
  }
}
