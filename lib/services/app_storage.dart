// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum StorageKeys {
  TOKEN,
  /// :  add storage keys here
}

class AppStorage {
  static final GetStorage _storage = GetStorage('main');

  static _assert(StorageKeys? storageKey, String? key) {
    assert(storageKey != null || key != null);
    assert(!(storageKey != null && key != null));
  }

  static Future<void> saveValue<T>(
      {StorageKeys? storageKey, String? key, required T value}) async {
    _assert(storageKey, key);
    await _storage.write(storageKey?.name ?? key!, value);
  }

  static T? getValue<T>({StorageKeys? storageKey, String? key}) {
    _assert(storageKey, key);
    return _storage.read<T>(storageKey?.name ?? key!);
  }

  static void removeKey({StorageKeys? storageKey, String? key}) async {
    _assert(storageKey, key);
    await _storage.remove(storageKey?.name ?? key!);
  }

  static void clearStorage() {
    _storage.erase();
  }

  static bool hasValue({StorageKeys? storageKey, String? key}) {
    _assert(storageKey, key);
    return getValue(key: key, storageKey: storageKey) != null;
  }

  static void listenKey(ValueSetter onChange,
      {StorageKeys? storageKey, String? key}) {
    _assert(storageKey, key);
    _storage.listenKey(storageKey?.name ?? key!, onChange);
  }
}

class AppSecureStorage {
  static final _instance = AppSecureStorage._init();
  late FlutterSecureStorage _flutterSecureStorage;
  static AppSecureStorage get instance => _instance;
  AppSecureStorage._init() {
    _flutterSecureStorage = const FlutterSecureStorage();
  }

  void write(String key, String value) async =>
      await _flutterSecureStorage.write(key: key, value: value);

  Future<String> read(String key, {String defaultValue = ''}) async =>
      (await _flutterSecureStorage.read(key: key)) ?? defaultValue;

  Future<Map<String, String>> readAll() async {
    return await _flutterSecureStorage.readAll();
  }

  void removeKey(String key) async {
    if (await _flutterSecureStorage.containsKey(key: key)) {
      await _flutterSecureStorage.delete(key: key);
    }
  }

  void clearAll() async => await _flutterSecureStorage.deleteAll();
}
