class ActivityIdGenerator {
  generateId() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}
