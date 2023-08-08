import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String? aboutme;
  final Timestamp? birthday;
  final String? email;
  final List<dynamic>? gender;
  final List<dynamic>? imgUrlList;
  final bool? isSetUp;
  final List<dynamic>? likedUsers;
  final List<dynamic>? matches;
  final List<dynamic>? myDislikes;
  final List<dynamic>? myLikes;
  final String? name;
  final List<dynamic>? seeking;
  final List<dynamic>? seen;
  final List<dynamic>? theirDislikes;
  final List<dynamic>? theirLikes;
  final String? uid;

  UserData({
    this.aboutme,
    this.birthday,
    this.email,
    this.gender,
    this.imgUrlList,
    this.isSetUp,
    this.likedUsers,
    this.matches,
    this.myDislikes,
    this.myLikes,
    this.name,
    this.seeking,
    this.seen,
    this.theirDislikes,
    this.theirLikes,
    this.uid,
  });

  factory UserData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserData(
      aboutme: data?['aboutme'],
      birthday: data?['birthday'],
      email: data?['email'],
      gender: data?['gender'],
      imgUrlList: data?['imgUrlList'],
      isSetUp: data?['isSetUp'],
      likedUsers: data?['likedUsers'],
      matches: data?['matches'],
      myDislikes: data?['myDislikes'],
      myLikes: data?['myLikes'],
      name: data?['name'],
      seeking: data?['seeking'],
      seen: data?['seen'],
      theirDislikes: data?['theirDislikes'],
      theirLikes: data?['theirLikes'],
      uid: data?['uid'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (aboutme != null) 'aboutme': aboutme,
      if (birthday != null) 'birthday': birthday,
      if (email != null) 'email': email,
      if (gender != null) 'gender': gender,
      if (imgUrlList != null) 'imgUrlList': imgUrlList,
      if (isSetUp != null) 'isSetUp': isSetUp,
      if (likedUsers != null) 'likedUsers': likedUsers,
      if (matches != null) 'matches': matches,
      if (myDislikes != null) 'myDislikes': myDislikes,
      if (myLikes != null) 'myLikes': myLikes,
      if (name != null) 'name': name,
      if (seeking != null) 'seeking': seeking,
      if (seen != null) 'seen': seen,
      if (theirDislikes != null) 'theirDislikes': theirDislikes,
      if (theirLikes != null) 'theirLikes': theirLikes,
      if (uid != null) 'uid': uid,
    };
  }

  int getAge() {
    // Convert the birthDate Timestamp to a DateTime object
    DateTime birthDateTime = birthday?.toDate() ?? DateTime.now();

    // Get the current date as a DateTime object
    DateTime currentDate = DateTime.now();

    // Calculate the difference between the current date and the birth date in years
    int ageInYears = currentDate.year - birthDateTime.year;

    // Check if the birth date hasn't occurred yet this year
    if (currentDate.month < birthDateTime.month ||
        (currentDate.month == birthDateTime.month &&
            currentDate.day < birthDateTime.day)) {
      ageInYears--;
    }

    return ageInYears;
  }
}

class MatchData {
  final Map<String, UserInfo>? users;
  final String? newestMessage;
  final Timestamp? timestamp;
  final String? matchID;

  MatchData({
    this.users,
    this.newestMessage,
    this.timestamp,
    this.matchID,
  });

  factory MatchData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    final usersData = (data?['users'] as Map<String, dynamic>).map(
      (uid, MatchData) => MapEntry(
        uid,
        UserInfo(
          name: MatchData['name'],
          photo: MatchData['photo'],
        ),
      ),
    );

    return MatchData(
      users: usersData,
      newestMessage: data?['newestMessage'],
      timestamp: data?['timestamp'],
      matchID: snapshot.id,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'users': users?.map((uid, MatchData) => MapEntry(uid, {
            'name': MatchData.name,
            'photo': MatchData.photo,
          })),
      'newestMessage': newestMessage,
      'timestamp': timestamp,
      'matchID': matchID,
    };
  }
}

class UserInfo {
  final String name;
  final String photo;

  UserInfo({
    required this.name,
    required this.photo,
  });
}

class ChatData {
  final String? matchID;
  final String? message;
  final Timestamp? timestamp;
  final String? sender;

  ChatData({
    this.matchID,
    this.message,
    this.timestamp,
    this.sender,
  });

  factory ChatData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ChatData(
      matchID: data?['matchID'],
      message: data?['message'],
      timestamp: data?['timestamp'],
      sender: data?['sender'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (matchID != null) 'matchID': matchID,
      if (message != null) 'message': message,
      if (timestamp != null) 'timestamp': timestamp,
      if (sender != null) 'sender': sender,
    };
  }

  String formatChatTimestamp() {
  DateTime sentTime = timestamp!.toDate();
  final now = DateTime.now();
  final difference = now.difference(sentTime);

  if (difference.inMinutes < 1) {
    return 'just now';
  } else if (difference.inHours < 1) {
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
  } else if (difference.inDays < 30) {
    return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
  } else {
    return '${sentTime.month}/${sentTime.day}/${sentTime.year} ${sentTime.hour}:${sentTime.minute}';
  }
}

}
