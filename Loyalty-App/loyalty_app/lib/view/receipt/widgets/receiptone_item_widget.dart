

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:loyalty_app/controller/invoice.dart';
import 'package:loyalty_app/model/invoice.dart';

class ReceiptoneItemWidget extends StatefulWidget {
  const ReceiptoneItemWidget({Key? key}) : super(key: key);

  @override
  _ReceiptoneItemWidgetState createState() => _ReceiptoneItemWidgetState();
}

class _ReceiptoneItemWidgetState extends State<ReceiptoneItemWidget> {
  final InvoiceController _invoiceController = InvoiceController();
  late Future<List<Invoice>> _invoicesFuture;

  @override
  void initState() {
    super.initState();
    _invoicesFuture = _invoiceController.getUserInvoice();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Invoice>>(
      future: _invoicesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No invoices available'));
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemExtent: 150,
                  itemBuilder: (context, index) {
                    Invoice invoice = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        width: 317,
                        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            if (invoice.imageBytesList != null && index < invoice.imageBytesList!.length)
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(6)),
                                  child: Image.memory(
                                    invoice.imageBytesList![index],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Text('Error loading image');
                                    },
                                  ),
                                ),
                              ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Upload Date: ${invoice.uploadDate}',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
