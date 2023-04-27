import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

Future<MqttServerClient> connect() async {
  MqttServerClient client =
      MqttServerClient.withPort('broker.emqx.io', 'flutter_client', 1883);
  client.logging(on: true);
  client.onConnected = onConnected;
  client.onDisconnected = onDisconnected;
  client.onUnsubscribed = onUnsubscribed;
  client.onSubscribed = onSubscribed;
  client.onSubscribeFail = onSubscribeFail;
  client.pongCallback = pong;

  final connMessage = MqttConnectMessage()
      .authenticateAs('user', 'pass')
      .keepAliveFor(60)
      .withWillTopic('mqttproesp02')
      .withWillMessage('Will message')
      .startClean()
      .withWillQos(MqttQos.atLeastOnce);
  client.connectionMessage = connMessage;
  try {
    await client.connect();
  } catch (e) {
    print('Exception: $e');
    client.disconnect();
  }

  client.updates!.listen((List<MqttReceivedMessage<MqttMessage>>? c) {
    final recMess = c![0].payload as MqttPublishMessage;
    final pt =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    print('Received message:$pt from topic: ${c[0].topic}>');
  });

  client.published!.listen((MqttPublishMessage message) {
    print(
        'EXAMPLE::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
  });

  /// Lets publish to our topic
  /// Use the payload builder rather than a raw buffer
  /// Our known topic to publish to
  const pubTopic = 'mqttproesp02';
  final builder = MqttClientPayloadBuilder();
  builder.addString('1');

  /// Subscribe to it
  print('EXAMPLE::Subscribing to the Dart/Mqtt_client/testtopic topic');
  client.subscribe(pubTopic, MqttQos.exactlyOnce);

  /// Publish it
  print('EXAMPLE::Publishing our topic');
  client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);

  /// Ok, we will now sleep a while, in this gap you will see ping request/response
  /// messages being exchanged by the keep alive mechanism.
  print('EXAMPLE::Sleeping....');
  await MqttUtilities.asyncSleep(60);

  /// Finally, unsubscribe and exit gracefully

  /// Wait for the unsubscribe message from the broker if you wish.
  await MqttUtilities.asyncSleep(2);
  print('EXAMPLE::Disconnecting');
  client.disconnect();
  print('EXAMPLE::Exiting normally');
  return client;
}

Future<MqttServerClient> connecttwo() async {
  MqttServerClient client =
      MqttServerClient.withPort('broker.emqx.io', 'flutter_client', 1883);
  client.logging(on: true);
  client.onConnected = onConnected;
  client.onDisconnected = onDisconnected;
  client.onUnsubscribed = onUnsubscribed;
  client.onSubscribed = onSubscribed;
  client.onSubscribeFail = onSubscribeFail;
  client.pongCallback = pong;

  final connMessage = MqttConnectMessage()
      .authenticateAs('user', 'pass')
      .keepAliveFor(60)
      .withWillTopic('mqttproesp02')
      .withWillMessage('Will message')
      .startClean()
      .withWillQos(MqttQos.atLeastOnce);
  client.connectionMessage = connMessage;
  try {
    await client.connect();
  } catch (e) {
    print('Exception: $e');
    client.disconnect();
  }

  client.updates!.listen((List<MqttReceivedMessage<MqttMessage>>? c) {
    final recMess = c![0].payload as MqttPublishMessage;
    final pt =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    print('Received message:$pt from topic: ${c[0].topic}>');
  });

  client.published!.listen((MqttPublishMessage message) {
    print(
        'EXAMPLE::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
  });

  /// Lets publish to our topic
  /// Use the payload builder rather than a raw buffer
  /// Our known topic to publish to
  const pubTopic = 'mqttproesp02';
  final builder = MqttClientPayloadBuilder();
  builder.addString('0');

  /// Subscribe to it
  print('EXAMPLE::Subscribing to the Dart/Mqtt_client/testtopic topic');
  client.subscribe(pubTopic, MqttQos.exactlyOnce);

  /// Publish it
  print('EXAMPLE::Publishing our topic');
  client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);

  /// Ok, we will now sleep a while, in this gap you will see ping request/response
  /// messages being exchanged by the keep alive mechanism.
  print('EXAMPLE::Sleeping....');
  await MqttUtilities.asyncSleep(60);

  /// Finally, unsubscribe and exit gracefully

  /// Wait for the unsubscribe message from the broker if you wish.
  await MqttUtilities.asyncSleep(2);
  print('EXAMPLE::Disconnecting');
  client.disconnect();
  print('EXAMPLE::Exiting normally');
  return client;
}

void onConnected() {
  print("conectado");
}

void onDisconnected() {
  print("desconectado");
}

void onUnsubscribed(String? topic) {
  print('Subscribed topic: $topic');
}

void onSubscribed(String topic) {
  print('Unsubscribed topic: $topic');
}

void onSubscribeFail(String topic) {
  print('Failed to subscribe $topic');
}

void pong() {
  print('Ping response client callback invoked');
}
