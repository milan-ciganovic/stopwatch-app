abstract class TimerService {
  Stream<int> periodic(Duration period);
}
class StreamPeriodicTimerService implements TimerService {
  @override
  Stream<int> periodic(Duration period) {
    return Stream.periodic(period, (i) => i);
  }
}