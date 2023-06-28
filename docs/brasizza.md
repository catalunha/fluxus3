Stream<NotificationModel> init({required ClientModel client}) {
    QueryBuilder<ParseObject> queryUser = QueryBuilder<ParseObject>(ParseObject('_User'))..whereEqualTo('objectId', client.id);
    queryUser.query().then((response) {
      ParseObject? user;
      if (response.count > 0) {
        user = response.results?.first as ParseObject;
      }
      final LiveQuery liveQuery = LiveQuery(debug: true);
      QueryBuilder<ParseObject> query = QueryBuilder<ParseObject>(ParseObject('Notification'))..whereEqualTo('user', user);
      query.query().then((response) {
        if (response.count > 0) {
          if (response.results != null) {
            for (var parseValue in response.results!) {
              controller.add(NotificationModel.fromParse(parseValue));
            }
          }
        }
      });
      liveQuery.client.subscribe(query).then((subscription) {
        subscription.on(LiveQueryEvent.create, (value) {
          controller.add(NotificationModel.fromParse(value));
        });

        subscription.on(LiveQueryEvent.update, (value) {
          controller.add(NotificationModel.fromParse(value));
        });

        subscription.on(LiveQueryEvent.enter, (value) {
          controller.add(NotificationModel.fromParse(value));
        });

        subscription.on(LiveQueryEvent.delete, (value) {
          controller.add(NotificationModel.fromParse(value, 'delete'));
        });
      });
    });

    return controller.stream;
  }