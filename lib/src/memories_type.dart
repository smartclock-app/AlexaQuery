part of 'alexaquery_types.dart';

class Memories {
  final Links links;
  final List<Memory> memories;
  final int totalCount;

  Memories({
    required this.links,
    required this.memories,
    required this.totalCount,
  });
}

class Links {
  final dynamic next;

  Links({
    required this.next,
  });
}

class Memory {
  final DateTime createdDateTime;
  final String id;
  final bool isPrivate;
  final List<dynamic> mediaList;
  final String noteType;
  final String originalSource;
  final List<dynamic> pinnedDevices;
  final dynamic stickyNoteAttributes;
  final DateTime updatedDateTime;
  final String value;
  final int version;

  Memory({
    required this.createdDateTime,
    required this.id,
    required this.isPrivate,
    required this.mediaList,
    required this.noteType,
    required this.originalSource,
    required this.pinnedDevices,
    required this.stickyNoteAttributes,
    required this.updatedDateTime,
    required this.value,
    required this.version,
  });
}
