import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  CollectionReference tasksReference =
      FirebaseFirestore.instance.collection('tasks');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Firestore"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                tasksReference.get().then((QuerySnapshot value) {
                  //QuerySnapshot collection = value;
                  //List<QueryDocumentSnapshot> docs = collection.docs;
                  //QueryDocumentSnapshot doc = docs[1];
                  //print(doc.id);
                  //print(doc.data());

                  QuerySnapshot collection = value;
                  collection.docs.forEach((QueryDocumentSnapshot element) {
                    Map<String, dynamic> myMap =
                        element.data() as Map<String, dynamic>;
                    print(myMap["title"]);
                  });
                });
              },
              child: Text(
                "Obtener La Data",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                tasksReference.add(
                  {
                    "title": "Ir De Compras Al Super 3",
                    "description": "Debemos De Comprar Comida Para Todo El Mes",
                  },
                ).then((DocumentReference value) {
                  print(value.id);
                }).catchError((error) {
                  print("Ocorrio Un Error En El Registro");
                }).whenComplete(() {
                  print("El Registro Ha Terminado");
                });
              },
              child: Text(
                "Agregar Documento",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                tasksReference.doc("INhzxEewM4hL4UXezMyO").update(
                  {
                    "title": " Ir De Paseo al Campo",
                    "description": "Tenemos Que Salir Muy Temprano",
                  },
                ).catchError(
                  (error) {
                    print(error);
                  },
                ).whenComplete(
                  () {
                    print("Actualizacion Terminada");
                  },
                );
              },
              child: Text(
                "Actualizar Documento",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                tasksReference
                    .doc(" CyHLFleY5tzH2W21JUjQ ")
                    .delete()
                    .catchError(
                  (error) {
                    print(error);
                  },
                ).whenComplete(
                        () {
                  print("La Eliminacion Esta Completada");
                });
              },
              child: Text(
                "Eliminar Documento",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
