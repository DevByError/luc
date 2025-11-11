// lib/pages/student_pages/fees_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luc/utils/app_theme.dart'; // Using your app's theme
import 'dart:math';

class FeesPage extends StatefulWidget {
  const FeesPage({super.key});

  @override
  State<FeesPage> createState() => _FeesPageState();
}

class _FeesPageState extends State<FeesPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  String _selectedPaymentMethod = 'Credit/Debit Card';
  bool _isProcessing = false;

  void _processPayment() async {
    // This is a simulation, no real payment is processed.
    if (_formKey.currentState!.validate()) {
      setState(() => _isProcessing = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isProcessing = false);

      final transactionId =
          "TXN${Random().nextInt(999999).toString().padLeft(6, '0')}";

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentReceiptPage(
              amount: _amountController.text,
              method: _selectedPaymentMethod,
              transactionId: transactionId,
            ),
          ),
        );
      }
    }
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.payment, color: AppTheme.primaryColor),
        filled: true,
        fillColor: AppTheme.backgroundColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Fee Payment'),
        // AppBar styling is already handled by AppTheme
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // University Bank Info Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("University Bank Account",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor)),
                    const SizedBox(height: 10),
                    const Text("Bank Name: RHB Bank",
                        style: TextStyle(fontSize: 16)),
                    const Text("Account Number: 01234567890",
                        style: TextStyle(fontSize: 16)),
                    const Text("Account Name: Lincoln University College",
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Clipboard.setData(
                              const ClipboardData(text: "01234567890"));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Account number copied!")),
                          );
                        },
                        icon: const Icon(Icons.copy, size: 18),
                        label: const Text("Copy Account Number"),
                        // Button styling is already handled by AppTheme
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Payment Form
            Form(
              key: _formKey,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Student Fee Payment",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Amount
                      _buildTextField(
                        label: "Amount (RM)",
                        icon: Icons.attach_money,
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Enter amount";
                          if (double.tryParse(value) == null)
                            return "Enter valid number";
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      // Payment Method
                      DropdownButtonFormField<String>(
                        value: _selectedPaymentMethod,
                        items: [
                          'Credit/Debit Card',
                          'Online Banking',
                          'E-Wallet (GrabPay, Touch n Go)',
                          'Bank Transfer (Manual)',
                        ].map((method) {
                          return DropdownMenuItem(
                              value: method, child: Text(method));
                        }).toList(),
                        onChanged: (value) =>
                            setState(() => _selectedPaymentMethod = value!),
                        decoration: InputDecoration(
                          labelText: "Payment Method",
                          prefixIcon: const Icon(Icons.payment,
                              color: AppTheme.primaryColor),
                          filled: true,
                          fillColor: AppTheme.backgroundColor,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Card Details (only if card selected)
                      if (_selectedPaymentMethod == "Credit/Debit Card") ...[
                        _buildTextField(
                          label: "Card Number",
                          icon: Icons.credit_card,
                          controller: _cardNumberController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(16),
                          ],
                          validator: (value) {
                            if (value == null || value.length != 16) {
                              return "Enter 16-digit card number";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                label: "Expiry (MM/YY)",
                                icon: Icons.date_range,
                                controller: _expiryController,
                                keyboardType: TextInputType.datetime,
                                validator: (value) =>
                                    (value == null || value.isEmpty)
                                        ? "Enter expiry"
                                        : null,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _buildTextField(
                                label: "CVV",
                                icon: Icons.lock,
                                controller: _cvvController,
                                keyboardType: TextInputType.number,
                                obscure: true,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(3),
                                ],
                                validator: (value) =>
                                    (value == null || value.length < 3)
                                        ? "Invalid CVV"
                                        : null,
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 25),

                      // Pay Button
                      ElevatedButton(
                        onPressed: _isProcessing ? null : _processPayment,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: _isProcessing
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2),
                              )
                            : const Text("Proceed to Pay",
                                style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Payment Receipt Page
class PaymentReceiptPage extends StatelessWidget {
  final String amount;
  final String method;
  final String transactionId;

  const PaymentReceiptPage({
    super.key,
    required this.amount,
    required this.method,
    required this.transactionId,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text("Receipt"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Icon(Icons.receipt_long,
                      size: 70, color: AppTheme.primaryColor),
                ),
                const SizedBox(height: 20),
                Text("Transaction ID: $transactionId",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),
                Text("Amount Paid: RM $amount",
                    style: const TextStyle(fontSize: 16)),
                Text("Payment Method: $method",
                    style: const TextStyle(fontSize: 16)),
                Text("Date: ${date.day}/${date.month}/${date.year}",
                    style: const TextStyle(fontSize: 16)),
                Text(
                    "Time: ${date.hour}:${date.minute.toString().padLeft(2, '0')}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 25),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.check_circle),
                    label: const Text("Done", style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
