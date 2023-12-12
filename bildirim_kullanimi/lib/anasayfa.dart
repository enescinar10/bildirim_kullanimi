import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  var flp = FlutterLocalNotificationsPlugin();

  Future<void> kurulum() async {
    var iosAyari = const DarwinInitializationSettings();
    var androidAyari = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var kurulumAyari = InitializationSettings(android: androidAyari , iOS: iosAyari);
    await flp.initialize(kurulumAyari,onDidReceiveBackgroundNotificationResponse: bildirimSecilme);
  }

  Future<void> bildirimSecilme(NotificationResponse notificationResponse) async {
    var payload = notificationResponse.payload;
    if(payload != null){
      print("Bildirim Seçildi : $payload");
    }
  }

  Future<void> bildirimGoster() async {
    var iosBildirimDetay = const DarwinNotificationDetails();
    var androidBildirimDetay = const AndroidNotificationDetails("id", "name",channelDescription: "aciklama",priority: Priority.high,importance: Importance.max);
    var bildirimDetay = NotificationDetails(android: androidBildirimDetay, iOS: iosBildirimDetay);
    await flp.show(0, "Başlık", "İçerik", bildirimDetay,payload: "Merhaba");
  }

  @override
  void initState() {
    super.initState();
    kurulum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bildirim Kullanımı"),
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){
          bildirimGoster();
        }, child: const Text("Bilidirim Göster")),
      ),
    );
  }
}
