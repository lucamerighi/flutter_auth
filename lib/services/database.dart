import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_firebase/models/brew.dart';
import 'package:hello_firebase/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({'sugars': sugars, 'name': name, 'strength': strength});
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((doc) =>
            Brew(name: doc.data['name'] ?? '', sugars: doc.data['sugars'] ?? '0', strength: doc.data['strength'] ?? 0))
        .toList();
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid, name: snapshot.data['name'], sugars: snapshot.data['sugars'], strength: snapshot.data['strength']);
  }

  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
