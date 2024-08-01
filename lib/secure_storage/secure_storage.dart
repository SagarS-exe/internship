import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage
{
    static const FlutterSecureStorage storage=FlutterSecureStorage();

    Future secureWrite(String key,String value) async
    {
        var writeData=storage.write(key: key, value: value);
        return writeData;
    }

    Future secureRead(String key) async
    {
        var readData=storage.read(key: key);
        return readData;
    }

    Future secureDelete(String key) async
    {
        var deleteData=storage.delete(key: key);
        return deleteData;
    }

}
