import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScheduleNotificationPage extends StatefulWidget {
  const ScheduleNotificationPage({super.key});

  @override
  State<ScheduleNotificationPage> createState() =>
      _ScheduleNotificationPageState();
}

enum NotificationChoice { oneTime, custom }

class _ScheduleNotificationPageState extends State<ScheduleNotificationPage> {
  final TextEditingController _minutes = TextEditingController();
  NotificationChoice notificationChoice = NotificationChoice.oneTime;

  @override
  void dispose() {
    _minutes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aggiungi notifica')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(children: [
          TextField(
              controller: _minutes,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  hintText: 'Minuti',
                  icon: Icon(CupertinoIcons.time),
                  border: OutlineInputBorder())),
          const SizedBox(height: 10),
          SegmentedButton<NotificationChoice>(
            segments: const <ButtonSegment<NotificationChoice>>[
              ButtonSegment<NotificationChoice>(
                  value: NotificationChoice.oneTime,
                  label: Text('Solo una volta'),
                  icon: Icon(Icons.abc)),
              ButtonSegment<NotificationChoice>(
                  value: NotificationChoice.custom,
                  label: Text('Personalizzato'),
                  icon: Icon(Icons.calendar_view_week)),
            ],
            selected: {notificationChoice},
            onSelectionChanged: (Set<NotificationChoice> newSelection) {
              setState(() {
                notificationChoice = newSelection.first;
              });
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
              onPressed: () {
                int.parse(_minutes.text);
              },
              icon: const Icon(CupertinoIcons.add, size: 15),
              label: const Text('Pianifica'))
        ]),
      ),
    );
  }
}
