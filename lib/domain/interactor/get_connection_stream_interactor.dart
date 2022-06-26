import 'package:firebase_database/firebase_database.dart';
import 'package:fripo/domain/use_case/get_connection_stream_use_case.dart';

class GetConnectionStreamInteractor implements GetConnectionStreamUseCase {
  @override
  Stream<bool> call() {
    return FirebaseDatabase.instance
        .ref('.info/connected')
        .onValue
        .map((event) => event.snapshot.value as bool);
  }
}
