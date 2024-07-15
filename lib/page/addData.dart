import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Tambahkan ini untuk Firestore

final TextEditingController noteController = TextEditingController();

void addData(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  "Buatlah Catatanmu",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                controller: noteController,
                decoration: const InputDecoration(
                    labelText: "Note", hintText: "Masukkan Data Notes"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    // Menyimpan data ke Firestore tanpa field id
                    FirebaseFirestore.instance.collection('note').add({
                      'note': noteController.text.toString(),
                    });

                    noteController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Tambah"))
            ],
          ),
        );
      });
}
