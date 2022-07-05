import 'package:projeto/models/numeros.dart';
import 'package:projeto/events/numeros_events.dart';

class ComandasEvent implements NumerosEvent {
  Numeros numeros;
  int now;

  ComandasEvent({required this.numeros, required this.now});
}
