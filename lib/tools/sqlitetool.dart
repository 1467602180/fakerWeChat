import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class SqliteTool {
  Future<String> getPath() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + 'demo.db';
    return path;
  }

  Future<Database> openBase() async {
    Database database = await openDatabase(await getPath(), version: 1,
        onCreate: (Database db, int version) async {
//      通讯录数据库
      await db.execute('''CREATE TABLE address(  
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `surname` VARCHAR(10) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `user` VARCHAR(20) NOT NULL UNIQUE,
  `aver` TEXT NOT NULL,
  `city` VARCHAR(20) NOT NULL
)''');
//      朋友圈数据库
      await db.execute('''CREATE TABLE `friendscircle`(  
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `content` TEXT NOT NULL,
  `user` INT NOT NULL,
  CONSTRAINT `friendscircle_user` FOREIGN KEY (`user`) REFERENCES `address`(`id`) ON UPDATE CASCADE ON DELETE CASCADE
)''');
      await db.execute('''CREATE TABLE `friendsimages`(  
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `image` TEXT NOT NULL,
  `content` INT NOT NULL,
  CONSTRAINT `friendsimages_content` FOREIGN KEY (`content`) REFERENCES `friendscircle`(`id`) ON UPDATE CASCADE ON DELETE CASCADE
)''');
//      聊天数据库
      await db.execute('''CREATE TABLE `chatUser`(  
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `user` INT NOT NULL UNIQUE,
  CONSTRAINT `chatUser_user` FOREIGN KEY (`user`) REFERENCES `address`(`id`) ON UPDATE CASCADE ON DELETE CASCADE
)''');
      await db.execute('''CREATE TABLE `chatContent`(  
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `chat` TEXT NOT NULL,
  `type` VARCHAR(10) NOT NULL,
  `before` VARCHAR(10) NOT NULL,
  `user` INT NOT NULL,
  CONSTRAINT `chatContent_user` FOREIGN KEY (`user`) REFERENCES `chatuser`(`id`) ON UPDATE CASCADE ON DELETE CASCADE
)''');
//      公众号数据库
      await db.execute('''CREATE TABLE `chatPublic`(  
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `publicname` VARCHAR(20) NOT NULL,
  `aver` TEXT NOT NULL,
  `autoChat` TEXT
)''');
      await db.execute('''CREATE TABLE `chatPublicContent`(  
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `chat` TEXT NOT NULL,
  `before` VARCHAR(10) NOT NULL,
  `publicId` INT NOT NULL,
  CONSTRAINT `chatPublicContent_publicId` FOREIGN KEY (`publicId`) REFERENCES `chatPublic`(`id`) ON UPDATE CASCADE ON DELETE CASCADE
)''');
    });
    return database;
  }

  Future<List<Map>> selectBase(String name) async {
    Database database = await openBase();
    List<Map> list = await database.rawQuery('SELECT * FROM $name');
    return list;
  }

  Future<List<Map>> selectBaseReverse(String name) async {
    Database database = await openBase();
    List<Map> list =
        await database.rawQuery('SELECT * FROM $name order by id desc');
    return list;
  }

  Future<List<Map>> selectFriendsCircleImages(id) async {
    Database database = await openBase();
    List<Map> list = await database
        .rawQuery('SELECT * FROM friendsimages where content=$id');
    return list;
  }

  Future<Map> selectUser(id) async {
    Database database = await openBase();
    Map list =
        (await database.rawQuery('SELECT * FROM address where id=$id'))[0];
    return list;
  }

  Future<List<Map>> getUserInfo() async {
    Database database = await openBase();
    List<Map> list =
        await database.rawQuery('SELECT * FROM address where id = 1');
    return list;
  }

  void updateAddress(id, username, user, aver, city) async {
    Database database = await openBase();
    await database.rawUpdate('''UPDATE 
  `address` 
SET
  `username` = '$username',
  `user` = '$user',
  `aver` = '$aver',
  `city` = '$city' 
WHERE `id` = $id''');
  }

  void initFriendsCircle() async {
    List<Map> userList = await selectBase('address');
    Map contentData =
        json.decode(await rootBundle.loadString('assets/json/content.json'));
    Map imagesData =
        json.decode(await rootBundle.loadString('assets/json/images.json'));
    Database database = await openBase();
    await database.transaction((txn) async {
      for (var i = 0; i < 20; i++) {
        await txn.rawInsert('''INSERT INTO `friendscircle` ( `content`, `user`) 
VALUES
  ('${contentData['data'][Random().nextInt(1000)]}', '${userList[Random().nextInt(20)]['id']}') ''');
        for (var j = 0; j < Random().nextInt(9); j++) {
          await txn
              .rawInsert('''INSERT INTO `friendsimages` (`image`, `content`) 
VALUES
  ('${imagesData['data'][Random().nextInt(1000)]}', '${i + 1}') ''');
        }
      }
      print('生成朋友圈');
    });
  }

  void initAddress() async {
    Database database = await openBase();
    Map address =
        json.decode(await rootBundle.loadString("assets/json/address.json"));
    await database.transaction((txn) async {
      int index = Random().nextInt(1000);
      await txn.rawInsert('''INSERT INTO `address` (
  `surname`,
  `username`,
  `user`,
  `aver`,
  `city`
) 
VALUES
  (
    '${address['data'][index]['surname']}',
    '${address['data'][index]['username']}',
    '${address['data'][index]['user']}',
    '${address['data'][index]['aver']}',
    '${address['data'][index]['address']}'
  )''');
    });
    for (var i = 0; i < 20; i++) {
      int index = Random().nextInt(1000);
      addAddress(
          address['data'][index]['surname'],
          address['data'][index]['username'],
          address['data'][index]['user'],
          address['data'][index]['aver'],
          address['data'][index]['address']);
    }
    print('生成通讯录');
  }

//  生成公众号
  void initChatPublic() async {
    Database database = await openBase();
    Map address =
        json.decode(await rootBundle.loadString("assets/json/address.json"));
    await database.transaction((txn) async {
      for (var i = 0; i < 5; i++) {
        try{
          int index = Random().nextInt(1000);
          await txn.rawInsert('''INSERT INTO `chatPublic` (
  `publicname`,
  `aver`,
  `autoChat`
) 
VALUES
  (
    '${address['data'][index]['username']}',
    '${address['data'][index]['aver']}',
    ''
  )''');
        }catch(e){
          int index = Random().nextInt(1000);
          await txn.rawInsert('''INSERT INTO `chatPublic` (
  `publicname`,
  `aver`,
  `autoChat`
) 
VALUES
  (
    '${address['data'][index]['username']}',
    '${address['data'][index]['aver']}',
    ''
  )''');
          print('公众号重复，重新生成');
        }
      }
    });
    print('生成公众号');
  }

//  获取全部公众号
  Future<List<Map>> getChatPublic() async {
    Database database = await openBase();
    List<Map> list = await database.rawQuery('SELECT * FROM chatPublic');
    return list;
  }

//  获取公众号聊天信息
  Future<List<Map>> getChatPublicContent(chatPublicId)async{
    Database database = await openBase();
    List<Map> list = await database.rawQuery('SELECT * FROM chatPublicContent where publicId = $chatPublicId');
    return list;
  }

//  获取公众号信息
  Future<Map> getChatPublicInfo(id)async{
    Database database = await openBase();
    List<Map> list = await database.rawQuery('SELECT * FROM chatPublic where id = $id');
    return list[0];
  }
//  更改公众号信息
  void editChatPublicInfo(chatPublicId,publicName,aver,autoChat)async{
    Database database = await openBase();
    await database.rawUpdate(
        'UPDATE chatPublic SET publicname = ?, aver = ?, autoChat = ? WHERE id = ?',
        [publicName, aver,autoChat,chatPublicId]);
    print('更改成功');
  }
//  发消息给公众号
  void sendMessage(chatPublicId,chat)async{
    Database database = await openBase();
    await database.transaction((txn) async {
      await txn.rawInsert('''INSERT INTO `chatPublicContent` (
  `chat`,
  `before`,
  `publicId`
) 
VALUES
  (
    '$chat',
    'my',
    '$chatPublicId'
  )''');
    });
    print('发送成功');
  }
//  自动回复
  void autoMessage(chatPublicId)async{
    Map map = await getChatPublicInfo(chatPublicId);
//    判断是否自动回复
    if(map['autoChat']!=''){
      Database database = await openBase();
      await database.transaction((txn) async {
        await txn.rawInsert('''INSERT INTO `chatPublicContent` (
  `chat`,
  `before`,
  `publicId`
) 
VALUES
  (
    '${map['autoChat']}',
    'other',
    '$chatPublicId'
  )''');
      });
      print('自动回复成功');
    }
  }

//  搜索通讯录
  Future<List<Map>> searchAddress(name)async{
    Database database = await openBase();
    List<Map> list = await database.rawQuery("SELECT * FROM address where username like '%$name%'");
    return list;
  }
//  搜索公众号
  Future<List<Map>> searchChatPublic(name)async{
    Database database = await openBase();
    List<Map> list = await database.rawQuery("SELECT * FROM chatPublic where publicname like '%$name%'");
    return list;
  }
//  获取通讯录
  Future<List<Map>> getAddressList()async{
    Database database = await openBase();
    List<Map> list = await database.rawQuery("SELECT * FROM address");
    return list;
  }

  void initChat() async {
    Database database = await openBase();
    List before = ['other', 'my'];
    List type = ['content', 'image', 'location'];
    Map contentData =
        json.decode(await rootBundle.loadString('assets/json/content.json'));
    Map imagesData =
        json.decode(await rootBundle.loadString('assets/json/images.json'));
    for (var i = 2; i < 7; i++) {
      await database.transaction((txn) async {
        await txn.rawInsert('''INSERT INTO `chatuser` (`user`) 
VALUES
  ('$i') ''');
        for (var j = 1; j < 10; j++) {
          String typeValue = type[Random().nextInt(2)];
          await txn.rawInsert('''INSERT INTO `chatcontent` (
  `chat`,
  `type`,
  `before`,
  `user`
) 
VALUES
  (
    '${typeValue == 'content' ? contentData['data'][Random().nextInt(1000)] : typeValue == 'image' ? imagesData['data'][Random().nextInt(1000)] : ''}',
    '$typeValue',
    '${before[Random().nextInt(2)]}',
    '$i'
  ) ''');
        }
      });
    }
    print('生成聊天信息');
  }

  sendLocation(int id, Map map) async {
    Database database = await openBase();
    await database.transaction((txn) async {
      await txn.rawInsert('''INSERT INTO `chatcontent` (
  `chat`,
  `type`,
  `before`,
  `user`
)
VALUES
  (
    '${json.encode(map)}',
    'location',
    'my',
    '$id'
  ) ''');
    });
    print('发送定位');
    print(map);
  }

  Future<Map> getAddressInfo(id) async {
    Database database = await openBase();
    Map data =
        (await database.rawQuery('SELECT * FROM address where id = $id'))[0];
    return data;
  }

  Future<List<Map>> getChatContent(id) async {
    Database database = await openBase();
    List<Map> list =
        await database.rawQuery('SELECT * FROM chatcontent where user = $id');
    return list;
  }

  Future<List<Map>> getChatContentRever(id) async {
    Database database = await openBase();
    List<Map> list =
        await database.rawQuery('SELECT * FROM chatcontent where user = $id');
    return list;
  }

  Future sendChatContent(content, id) async {
    Database database = await openBase();
    await database.transaction((txn) async {
      await txn.rawInsert('''INSERT INTO `chatcontent` (
  `chat`,
  `type`,
  `before`,
  `user`
) 
VALUES
  (
    '$content',
    'content',
    'my',
    '$id'
  ) ''');
    });
  }

  Future sendChatImage(content, id) async {
    Database database = await openBase();
    await database.transaction((txn) async {
      await txn.rawInsert('''INSERT INTO `chatcontent` (
  `chat`,
  `type`,
  `before`,
  `user`
) 
VALUES
  (
    '$content',
    'image',
    'my',
    '$id'
  ) ''');
    });
  }

  Future<bool> vChatUser(addressId) async {
    Database database = await openBase();
    List<Map> list = await database
        .rawQuery('SELECT * FROM chatuser where user = $addressId');
    if (list.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<int> addChatUser(addressId) async {
    Database database = await openBase();
    await database.transaction((txn) async {
      int state = await txn.rawInsert('''INSERT INTO `chatuser` (`user`) 
VALUES
  ('$addressId') ''');
      return state;
    });
  }

  Future<List<Map>> getChatUser() async {
    Database database = await openBase();
    List<Map> dataList = [];
    List<Map> list = await database.rawQuery('SELECT * FROM chatuser');
    for (var i in list) {
      Map userDataMap = await getAddressInfo(i['user']);
      List<Map> chatContentList = await getChatContentRever(i['user']);
      Map dataMap = Map.from(userDataMap);
      dataMap['chat'] = chatContentList;
      dataList.add(dataMap);
    }
    return dataList;
  }

  Future pushFriendsCircle(String content, List imageList) async {
    Database database = await openBase();
    await database.transaction((txn) async {
      await txn.rawInsert('''INSERT INTO `friendscircle` (`content`, `user`) 
VALUES
  ('$content', '1') ''');
    });
    Map contentData = (await database.rawQuery('''SELECT 
  `id`,
  `content`,
  `user` 
FROM
  `friendscircle` where content='$content' order by id desc '''))[0];
    await database.transaction((txn) async {
      for (var i in imageList) {
        await txn.rawInsert('''INSERT INTO `friendsimages` (`image`, `content`) 
VALUES
  ('$i', '${contentData['id']}') ''');
      }
    });
  }

  void deleteBase() async {
    await deleteDatabase(await getPath());
  }

  void addAddress(surname, username, user, aver, address) async {
    Database database = await openBase();
    try {
      await database.transaction((txn) async {
        await txn.rawInsert('''INSERT INTO `address` (
  `surname`,
  `username`,
  `user`,
  `aver`,
  `city`
) 
VALUES
  (
    '${surname}',
    '${username}',
    '${user}',
    '${aver}',
    '${address}'
  )''');
      });
    } catch (e) {
      print('user重复，随机生成');
      refAddAddress();
    }
  }

  void refAddAddress() async {
    Map address =
        json.decode(await rootBundle.loadString("assets/json/address.json"));
    int index = Random().nextInt(1000);
    addAddress(
        address['data'][index]['surname'],
        address['data'][index]['username'],
        address['data'][index]['user'],
        address['data'][index]['aver'],
        address['data'][index]['address']);
  }

  void updateUserInfo(username, aver) async {
    Database database = await openBase();
    int count = await database.rawUpdate(
        'UPDATE address SET username = ?, aver = ? WHERE id = ?',
        [username, aver, 1]);
    print(count == 1 ? '修改成功' : '修改失败');
  }
}
