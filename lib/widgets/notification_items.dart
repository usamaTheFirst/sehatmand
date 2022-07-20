import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sehatmand/models/notification.dart';
import 'package:sehatmand/utils/firebase.dart';
import 'package:sehatmand/widgets/view_notification_details.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:sehatmand/widgets/indicators.dart';

import '../pages/profile.dart';

class ActivityItems extends StatefulWidget {
  final ActivityModel activity;

  ActivityItems({required this.activity});

  @override
  _ActivityItemsState createState() => _ActivityItemsState();
}

class _ActivityItemsState extends State<ActivityItems> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey("${widget.activity}"),
      background: stackBehindDismiss(),
      direction: DismissDirection.endToStart,
      onDismissed: (v) {
        delete();
      },
      child: Column(
        children: [
          ListTile(
            onTap: () {
              // Navigator.of(context).push(CupertinoPageRoute(
              //   builder: (_) => ViewActivityDetails(activity: widget.activity),
              // ));
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) =>
                        Profile(profileId: widget.activity.userId),
                  ));
            },
            leading: CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(widget.activity.userDp),
            ),
            title: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontSize: 24.0,
                ),
                children: [
                  TextSpan(
                    text: '${widget.activity.username} ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  TextSpan(
                    text: buildTextConfiguration(),
                    style: TextStyle(fontSize: 15.0),
                  ),
                ],
              ),
            ),
            subtitle: Text(
              timeago.format(widget.activity.timestamp.toDate()),
            ),
            trailing: previewConfiguration(),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Theme.of(context).accentColor,
      child: Icon(
        CupertinoIcons.delete,
        color: Colors.white,
      ),
    );
  }

  delete() {
    notificationRef
        .doc(firebaseAuth.currentUser!.uid)
        .collection('notifications')
        .doc(widget.activity.postId)
        .get()
        .then((doc) => {
              if (doc.exists)
                {
                  doc.reference.delete(),
                }
            });
  }

  previewConfiguration() {
    if (widget.activity.type == "like" || widget.activity.type == "comment") {
      return buildPreviewImage();
    } else {
      return Text('');
    }
  }

  buildTextConfiguration() {
    if (widget.activity.type == "like") {
      return "liked your post";
    } else if (widget.activity.type == "follow") {
      return "is following you";
    } else if (widget.activity.type == "comment") {
      return "commented '${widget.activity.commentData}'";
    } else {
      return "Error: Unknown type '${widget.activity.type}'";
    }
  }

  buildPreviewImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: CachedNetworkImage(
        imageUrl: widget.activity.mediaUrl,
        placeholder: (context, url) {
          return circularProgress(context);
        },
        errorWidget: (context, url, error) {
          return Icon(Icons.error);
        },
        height: 40.0,
        fit: BoxFit.cover,
        width: 40.0,
      ),
    );
  }
}
