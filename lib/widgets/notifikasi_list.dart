import 'package:flutter/material.dart';
import '../data/data_notifikasi.dart';

class NotifikasiList extends StatefulWidget {
  const NotifikasiList({Key? key}) : super(key: key);

  @override
  State<NotifikasiList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotifikasiList> {
  late List<NotificationItem> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = List.from(notifikasi);
  }

  void _removeNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).size.width * 0.04;
    final crossSize = MediaQuery.of(context).size.width * 0.04;
    final fontTitleSize = MediaQuery.of(context).size.width * 0.042;
    final fontMessageSize = MediaQuery.of(context).size.width * 0.034;

    return ListView.builder(
      padding: EdgeInsets.all(padding),
      itemCount: _notifications.length,
      itemBuilder: (context, index) {
        final notification = _notifications[index];
        return GestureDetector(
          onTap: (){
            //TODO: navigate to detail notifikasi
          },
          child: Container(
            margin: EdgeInsets.only(bottom: padding),
            padding: EdgeInsets.only(
              bottom: padding,
              top: padding,
                left: padding * 1.7,
              right: padding * 0.5
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF0D1234),
              borderRadius: BorderRadius.circular(padding * 0.8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                          child: Text(
                          notification.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontTitleSize,
                            color: Colors.white,
                          ),
                          maxLines: null,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                            SizedBox(width: padding * 0.3,),
                          //Tulisan "Baru"
                          //TODO: Function

                          if (notification.label.isNotEmpty)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: padding * 0.5,
                                vertical: padding * 0.1,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(padding * 2),
                              ),
                              child: Text(
                                notification.label,
                                style: TextStyle(
                                  fontSize: fontMessageSize,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF1D1B41), // warna huruf hitam ke biru tua
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),

                    GestureDetector(
                      onTap: () => _removeNotification(index),
                      child: Icon(
                        Icons.close_rounded,
                        size: crossSize,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                //Pesan
                SizedBox(height: padding * 0.45),
                Text(
                  notification.message,
                  style: TextStyle(
                      fontSize: fontMessageSize, color: Colors.white, fontWeight: FontWeight.w200),
                ),
                SizedBox(height: padding * 0.35),
                //Waktu kejadian
                Text(
                  notification.dateTime,
                  style: TextStyle(
                    fontSize: fontMessageSize,
                      color: Colors.white, fontWeight: FontWeight.w200
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}