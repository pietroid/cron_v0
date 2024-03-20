class NoteIdGenerator {
  generateId() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}
