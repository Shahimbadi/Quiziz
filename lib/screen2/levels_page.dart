import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'questions_page.dart';

class LevelsPage extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  const LevelsPage({super.key, required this.categoryId, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final CollectionReference levels = FirebaseFirestore.instance.collection('categories').doc(categoryId).collection('levels');

    return Scaffold(

      backgroundColor: Colors.black,
      appBar: AppBar(
          toolbarHeight: 120.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.lightGreen,
          title: Text(categoryName,style: const TextStyle(fontSize: 40,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "genos"),)),
      body: StreamBuilder(
        stream: levels.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final totalLevels=snapshot.data!.docs.length;
          return Padding(
            padding: const EdgeInsets.only(top: 30,right: 20,left: 20),
            child: ListView.builder(
              itemCount:totalLevels,
              itemBuilder: (context, index) {
                var level = snapshot.data!.docs[index];

                return Container(
                  margin: const EdgeInsets.all(6),
                  height: 60,
                  width: 300,
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(color: Colors.lightGreen)
                  ),
                  child: ListTile(
                    title: Text('Level ${index + 1}',style: const TextStyle(
                        color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "genos",
                        fontSize: 25
                    ),),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionsPage(
                            categoryId: categoryId,
                            levelId: level.id, currentLevel: index+1, totalLevels: totalLevels,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}