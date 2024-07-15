import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Tambahkan ini untuk Firestore

final TextEditingController noteController = TextEditingController();

void updateData(BuildContext context, String note, String id) {
  noteController.text = note;
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
                  "Edit Catatanmu",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                controller: noteController,
                decoration: const InputDecoration(
                    labelText: "Note", hintText: "Masukkan Data"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    // Mengupdate data di Firestore
                    FirebaseFirestore.instance
                        .collection('note')
                        .doc(id)
                        .update({
                      'note': noteController.text.toString(),
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Edit"))
            ],
          ),
        );
      });
}
