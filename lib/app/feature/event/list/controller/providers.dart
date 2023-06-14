

// part 'providers.g.dart';

// // @Riverpod(keepAlive: true)
// @riverpod
// FutureOr<List<EventModel>> eventList(EventListRef ref) async {
//   QueryBuilder<ParseObject> query =
//       QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
//   query.orderByAscending(EventEntity.day);
//   return await ref.read(eventRepositoryProvider).list(query, cols: {
//     "${EventEntity.className}.cols": [
//       EventEntity.day,
//       EventEntity.hour,
//       EventEntity.room,
//       EventEntity.status,
//       EventEntity.attendances,
//       EventEntity.history,
//     ],
//     "${EventEntity.className}.pointers": [
//       EventEntity.hour,
//       EventEntity.room,
//       EventEntity.status,
//     ]
//   });
// }
