import 'package:projeto/models/numeros.dart';
import 'package:projeto/events/numeros_events.dart';

class ComandasEvent implements NumerosEvent {
  Numeros numeros;

  ComandasEvent({required this.numeros});
}
