import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:nebula/configs/constants/Spaces.dart';
import 'package:nebula/features/Data/DataSource/LocalDataSource/SqlQuerys/Sqllocaldatasource.dart';
import 'package:nebula/features/Data/Models/MusicModels/usermodel.dart';
import 'package:nebula/features/Domain/Entity/MusicEntity/SongsDetailsEntity/SongsEntity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../../../../configs/Error/Errors.dart';

class Sqldatasourcerepositoryimp extends Sqldatasourcerepository {
  @override
  Future<Database> intializedatabase() async {
    try {
      final directory = await getDatabasesPath();
      String path = join(directory, 'nebula.db');

      const fav = '''
        CREATE TABLE fav (
        key INTEGER PRIMARY KEY AUTOINCREMENT,
        id varchar[150],
        title varchar[150],
        artist varchar[150],
        uri varchar[150]
      );
    ''';

      const recent = '''
        CREATE TABLE recent (
        key INTEGER PRIMARY KEY AUTOINCREMENT,
        id varchar[150],
        title varchar[150],
        artist varchar[150],
        imageurl varchar[150],
        downloadurl varchar[150]
      );
    ''';

      const playlist = '''
        CREATE TABLE playlists (
        key INTEGER PRIMARY KEY AUTOINCREMENT,
        id varchar[50],
        title varchar[150],
        date varchar[150]
      );
    ''';

    const userquery = '''
      CREATE TABLE user (
        key INTEGER PRIMARY KEY AUTOINCREMENT,
        name varchar[150],
        date varchar[150]
       );
    ''';

      const query = '''
      CREATE TABLE downloads (
        key INTEGER PRIMARY KEY AUTOINCREMENT,
        id varchar[150],
        title varchar[150],
        artist varchar[150],
        imageurl varchar[150],
        downloadurl varchar[150],
        albumname varchar[150]
      );
    ''';

      const create = '''
      CREATE TABLE usersearch (
        key INTEGER PRIMARY KEY AUTOINCREMENT,
        search varchar[150]
      );
      ''';

      const librarysong = '''
       CREATE TABLE librarysong (
       key INTEGER PRIMARY KEY AUTOINCREMENT,
       id varchar[150],
       name varchar[150],
       image varchar[150],
       artist varchar[150],
       uri varchar[150]
      );
               ''';

      const libraryalbum = '''
       CREATE TABLE libraryalbum (
       key INTEGER PRIMARY KEY AUTOINCREMENT,
       id varchar[150],
       name varchar[150],
       image varchar[150],
       url varchar[150]
      );
      ''';

      const libraryplaylist = '''
       CREATE TABLE libraryplaylist (
       key INTEGER PRIMARY KEY AUTOINCREMENT,
       id varchar[150],
       name varchar[150],
       image varchar[150],
       url varchar[150]
      );
      ''';

      return await openDatabase(
        path,
        version: 2,
        onCreate: (db, version) async {
          await db.execute(query);
          await db.execute(recent);
          await db.execute(fav);
          await db.execute(playlist);
          await db.execute(librarysong);
          await db.execute(libraryalbum);
          await db.execute(libraryplaylist);
          await db.execute(userquery);
          await db.execute(create);
        },
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> addtodownloads(AlbumElements song) async {
    try {
      final db = await intializedatabase();
      const query = ('''
          INSERT INTO downloads (id,title,artist,imageurl,downloadurl,albumname) VALUES (?,?,?,?,?,?)
       ''');
      const search = (''' 
          SELECT * FROM downloads WHERE id = ?;
       ''');
      final exist = await db.rawQuery(search, [song.id]);
      if (exist.isNotEmpty) {
        Spaces.showtoast('Added Already');
        return false;
      } else {
        final id = await db.rawInsert(
            query, [song.id, song.name, song.Artist, song.image, song.url,song.type]);
        if (id > 0) {
          Spaces.showtoast('Added to Downloads');
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, List<Map<String, dynamic>>>>
      QueryDownloaddata() async {
    try {
      final db = await intializedatabase();
      const String query = "SELECT * FROM downloads";
      List<Map<String, dynamic>> data = await db.rawQuery(query);
      if (data.isNotEmpty) {
        return right(data);
      } else {
        return left(const Failures.clientfailure());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, bool>> removefromdownloads(String id) async {
    try {
      final db = await intializedatabase();
      int integer =
          await db.delete('downloads', where: 'id = ?', whereArgs: [id]);
      if (integer != 0) {
        return left(const Failures.clientfailure());
      }
      return right(true);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, bool>> addtorecent(AlbumElements song) async {
    try {
      final db = await intializedatabase();

      const sear = '''
         SELECT * FROM recent WHERE id = ?;
       ''';
      final existing = await db.rawQuery(sear, [song.id]);
      if (existing.isEmpty) {
        const insertquery = '''
        INSERT INTO recent (id,title,artist,imageurl,downloadurl) VALUES (?,?,?,?,?)
       ''';
        await db.rawInsert(insertquery,
            [song.id, song.name, song.Artist, song.image, song.url]);
        return right(true);
      } else {
        await db.delete('recent', where: 'id = ?', whereArgs: [song.id]);
        const insertquery = '''
        INSERT INTO recent (id,title,artist,imageurl,downloadurl) VALUES (?,?,?,?,?)
       ''';
        await db.rawInsert(insertquery,
            [song.id, song.name, song.Artist, song.image, song.url]);
        return right(true);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, List<Map<String, dynamic>>>> getallrecent() async {
    try {
      final db = await intializedatabase();
      const query = '''
     SELECT * FROM recent ORDER BY key DESC;
     ''';
      final list = await db.rawQuery(query);
      if (list.isNotEmpty) {
        return right(list);
      } else {
        return left(const Failures.clientfailure());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, bool>> removefromRecents(String id) async {
    try {
      final db = await intializedatabase();
      final ef = await db.delete('recent', where: 'id = ?', whereArgs: [id]);
      if (ef != 0) {
        return right(true);
      }
      return left(const Failures.clientfailure());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, String>> addtofav(
      AlbumElements song, bool isadded) async {
    try {
      final db = await intializedatabase();
      const serachQuery = '''
      SELECT * FROM fav where id = ?;
      ''';
      const insertquery = '''
      INSERT INTO fav(id,title,artist,uri) VALUES (?,?,?,?);
      ''';
      final existing = await db.rawQuery(serachQuery, [song.id]);
      if (existing.isNotEmpty) {
        await removefromfav(existing[0]['id'].toString());
        return right('removed');
      } else {
        await db
            .rawQuery(insertquery, [song.id, song.name, song.Artist, song.url]);
        return right('added');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, bool>> removefromfav(String id) async {
    try {
      final db = await intializedatabase();
      int res = await db.delete('fav', where: 'id = ?', whereArgs: [id]);
      if (res == 0) {
      return left(const Failures.clientfailure());
      }
      return right(true);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, List<Map<String, dynamic>>>> getallfavs() async {
    try {
      final db = await intializedatabase();
      final favsongs = await db.query('fav');
      if (favsongs.isNotEmpty) {
        return right(favsongs);
      } else {
        return left(const Failures.clientfailure());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, List<Map<String, dynamic>>>> updateplaylist(
      String table, List<Map<String, dynamic>> newitems) async {
    try {
      final db = await intializedatabase();
      final items = await db.query(table);
      if (items.isEmpty) {
        throw Exception('items empty');
      } else {
        await db.delete(table);
        for (Map<String, dynamic> item in newitems) {
          await db.insert(table, {
            "id": item['id'],
            "title": item['title'],
            "artist": item['artist'],
            "uri": item['uri']
          });
        }
        final newlist = await db.query(table);
        if (newlist.isNotEmpty) {
          return right(newlist);
        }
        throw Exception('playlist null');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // ignore: non_constant_identifier_names
  @override
  Future<Either<Failures, bool>> Addtoplaylist(
      String tbname, AlbumElements song) async {
    final db = await intializedatabase();

    String tb = tbname.replaceRange(0, 1, '');

    String table = tb.replaceAll(' ', '');

    String insert = '''
      INSERT INTO $table (id,title,artist,uri) VALUES (?,?,?,?);
    ''';

    final data = await db.query(table, where: 'id = ?', whereArgs: [song.id]);
    if (data.isEmpty) {
      int inserted = await db
          .rawInsert(insert, [song.id, song.name, song.Artist, song.url]);
      if (inserted != 0) {
        return right(true);
      } else {
        return left(const Failures.clientfailure());
      }
    } else {
      return right(false);
    }
  }

  @override
  Future<Either<Failures, bool>> createplaylist(String playlistname) async {
    try {
      Random random = Random();
      int id = random.nextInt(100000) + 1000;
      Database db = await intializedatabase();
      String date = DateTime.now().toString();
      const insert = '''
           INSERT INTO playlists (id,title,date) VALUES (?,?,?);
        ''';
      int data =
          await db.rawInsert(insert, [id.toString(), playlistname, date]);
      if (data != 0) {
        final tb = playlistname.replaceRange(0, 1, '');
        final table = tb.replaceAll(' ', '');
        final db = await intializedatabase();

        String create = '''
      CREATE TABLE $table (
         key INTEGER PRIMARY KEY AUTOINCREMENT,
         id varchar[50],
         title varchar[150],
         artist varchar[150],
         uri varchar[200]
      );
    ''';
        await db.execute(create);
        return right(true);
      }
      return left(const Failures.clientfailure());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, bool>> deleteplaylist(
      String playlistid, String playlistname) async {
    try {
      String tb = playlistname.replaceRange(0, 1, '');
      String table = tb.replaceAll(' ', '');
      Database db = await intializedatabase();
      int removed = await db
          .delete('playlists', where: 'id = ?', whereArgs: [playlistid]);
      if (removed != 0) {
        String del = '''
             DROP TABLE $table;
          ''';
        await db.execute(del);
        return right(true);
      } else {
        return left(const Failures.clientfailure());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, List<Map<String, dynamic>>>> getallplaylist() async {
    try {
      Database db = await intializedatabase();
      String selectquery = '''
      SELECT * FROM playlists;
      ''';
      List<Map<String, dynamic>> allplaylists = await db.rawQuery(selectquery);
      if (allplaylists.isNotEmpty) {
        return right(allplaylists);
      } else {
        return left(const Failures.clientfailure());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, List<Map<String, dynamic>>>> getallsongsfromplaylists(
      String playlistid) async {
    try {
      final tb = playlistid.replaceRange(0, 1, '');
      final table = tb.replaceAll(' ', '');
      Database db = await intializedatabase();
      String query = '''
      SELECT * FROM $table;
    ''';
      List<Map<String, dynamic>> res = await db.rawQuery(query);

      if (res.isNotEmpty) {
        return right(res);
      } else {
        return left(const Failures.clientfailure());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, bool>> deletesongfromplaylist(
      String playlistname, String songid) async {
    try {
      final tb = playlistname.replaceRange(0, 1, '');
      final table = tb.replaceAll(' ', '');
      Database db = await intializedatabase();
      int removed =
          await db.delete(table, where: 'id = ?', whereArgs: [songid]);
      if (removed != 0) {
        return right(true);
      } else {
        return left(const Failures.clientfailure());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, bool>> updateuserplaylist(
      String playlistname, List<Map<String, dynamic>> newform) async {
    try {
      Database db = await intializedatabase();
      String tb = playlistname.replaceRange(0, 1, '');
      String table = tb.replaceAll(' ', '');
      List<Map<String, dynamic>> getall = await db.query(table);
      if (getall.isEmpty) {
        throw Exception('list empty');
      } else {
        await db.delete(table);
        for (Map<String, dynamic> item in newform) {
          await db.insert(table, {
            'id': item['id'],
            'title': item['title'],
            'artist': item['artist'],
            'uri': item['uri']
          });
        }
        List<Map<String, dynamic>> newlist = await db.query(table);
        if (newlist.isNotEmpty) {
          return right(true);
        } else {
          return const Left(Failures.clientfailure());
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, bool>> favsong(String songid) async {
    try {
      Database db = await intializedatabase();
      List<Map<String, dynamic>> allsongs = await db.query('fav');
      bool ispresent = allsongs.any((element) => element['id'] == songid);
      if (ispresent) {
        return right(ispresent);
      }
      return right(false);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, bool>> clearecentsongs() async {
    try {
      Database db = await intializedatabase();
      int deleted = await db.delete('recent');
      if (deleted != 0) {
        return right(true);
      }
      return left(const Failures.clientfailure());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failures, bool>> cleardownloads() async {
    try {
      Database db = await intializedatabase();
      String query = '''
         DELETE FROM downloads;
    ''';
     await db.execute(query);
      return right(true);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<Either<Failures, String>> addtolibrary(String type,AlbumElements song) async{
    try {
       Database db = await intializedatabase();
       if (type == "song") {
          String insert = '''
            INSERT INTO librarysong (id,name,image,artist,uri) VALUES (?,?,?,?,?);
          ''';
          String getquery = '''
            SELECT * FROM librarysong;
          ''';
        List<Map<String, Object?>> allsongs = await db.rawQuery(getquery);
        bool alreadyexists = allsongs.any((element) => element['id']==song.id);
        if (alreadyexists) {
         int item = await db.delete('librarysong',where: "id = ?",whereArgs: [song.id]);
         if (item != 0) {
           return right('song removed');
         }
          return right("Removefailed");
        }else{
           int isnull = await db.rawInsert(insert, [song.id,song.name,song.image,song.Artist,song.url]);
        if (isnull == 0) {
          return right('not added');
        }
        return right("added Succesfully");
        }
       }else if(type =="album"){
        Database db = await intializedatabase();
        String insert = '''
          INSERT INTO libraryalbum (id,name,image,url) VALUES (?,?,?,?);
        ''';
        List<Map<String, Object?>> alldata = await db.query('libraryalbum');
        bool isexists = alldata.any((element) => element['id'] == song.id);
        if (isexists) {
         int isdeleted = await db.delete('libraryalbum',where: "id=?",whereArgs: [song.id]);
         if (isdeleted != 0) {
           return right('Removed albu,');
         } else {
           return right("Removed failed");
         }
        }else{
          int isadded = await db.rawInsert(insert,[song.id,song.name,song.image,song.url]);
        if(isadded != 0){
          return right('Added album');
        }
        return right("Adding failed");
        }
       }else if(type == "playlist"){
        Database db = await intializedatabase();
        String insert = '''
          INSERT INTO libraryplaylist (id,name,image,url) VALUES (?,?,?,?);
        ''';
        List<Map<String, Object?>> alldata = await db.query('libraryplaylist');
        bool isexists = alldata.any((element) => element['id'] == song.id);
        if (isexists) {
         int isdeleted = await db.delete('libraryplaylist',where: "id=?",whereArgs: [song.id]);
         if (isdeleted != 0) {
           return right('Removed playlist,');
         } else {
           return right("Removed failed");
         }
        }else{
          int isadded = await db.rawInsert(insert,[song.id,song.name,song.image,song.url]);
        if(isadded != 0){
          return right('Added playlist');
        }
        return right("Adding failed");
        }
       }else{
        return left(const Failures.clientfailure());
       }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<Either<Failures, List<Map<String, dynamic>>>> getlibrarysongs() async{
    try {
      Database db = await intializedatabase();
      String getquery = '''
       SELECT * FROM librarysong;
      ''';
      List<Map<String,dynamic>> songs = await db.rawQuery(getquery);
      if (songs.isNotEmpty) {
         return right(songs);
      } else {
        return left(const Failures.clientfailure());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<bool> Checkifpresent(String id) async{
    try {
      Database db = await intializedatabase();
      final data = await db.rawQuery('SELECT * FROM librarysong');
      bool ispresnet = data.any((element) => element['id']==id);
      return ispresnet;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<Either<Failures, List<Map<String, dynamic>>>> getlibraryalbums() async{
   try {
     Database db = await intializedatabase();
     List<Map<String,dynamic>> albums = await db.query('libraryalbum');
     if (albums.isNotEmpty) {
       return right(albums);
     } else {
       return left(const Failures.clientfailure());
     }
   } catch (e) {
     throw Exception(e.toString());
   }
  }
  
  @override
  Future<bool> checkforalbumpresent(String id) async{
    try {
      Database db = await intializedatabase();
      final allalbums = await db.query('libraryalbum');
      bool ispresent = allalbums.any((element) => element['id']==id);
      if (ispresent) {
        return ispresent;
      }
      return false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<Either<Failures, List<Map<String, dynamic>>>> getlibraryplaylist() async{
    try {
      Database db = await intializedatabase();
      List<Map<String,dynamic>> playlists = await db.query('libraryplaylist');
      if (playlists.isNotEmpty) {
        return right(playlists);
      }
      return left(const Failures.clientfailure());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<bool> checkifplaylistpresent(String id) async{
    try {
      Database db = await intializedatabase();
      final data = await db.rawQuery('SELECT * FROM libraryplaylist');
      bool ispresnet = data.any((element) => element['id']==id);
      return ispresnet;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<bool> userdetails(String mode,Usermodel user) async{
    try {
      Database db = await intializedatabase();
      if (mode == 'initial') {

       int data = await db.insert('user',
       {
       'name':user.name,
       'date':user.date
       });

        if (data!=0) {
           return true;
        }
        throw Exception('User insertion Failed');
      }else if(mode == 'update'){

       List<Map<String,dynamic>> res = await db.query('user');

       int isupdated = await db.update('user',{'name':user.name,'date':user.date},where: "key = ?",whereArgs: [res[0]['key']]);

       if (isupdated!=0) {
         return true;
       }
       throw Exception('user update failed');
      }
      throw Exception('Invalid mode');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<Map<String,dynamic>> getuserdetails() async{
    try {
      Database db = await intializedatabase();
      List<Map<String, Object?>> res = await db.query('user');
      if (res.isNotEmpty) {
        return res[0];
      }
      throw Exception('user details failed');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<Either<bool, List<Map<String,dynamic>>>> getsearchsuggestions(String mode,String search) async{
    try {
      Database db = await intializedatabase();
      if (mode == 'insert') {
       List<Map<String,dynamic>> res = await db.query('usersearch');

      bool isfound = res.any((element) => element['search'] == search);


      if (isfound) {
        return left(false);
      } else {
      String insert = '''
         INSERT INTO usersearch (search) VALUES (?);
      ''';

      await db.rawInsert(insert,[search]);

      return left(true);
      }
    }else if(mode == 'get') {
     List<Map<String,dynamic>> res = await db.query('usersearch');
     if (res.isNotEmpty) {
       return right(res);
     } else {
       return left(false);
     }
    }else{
      await db.delete('usersearch',where: "search = ?",whereArgs: [search]);
      return left(true);
    }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
