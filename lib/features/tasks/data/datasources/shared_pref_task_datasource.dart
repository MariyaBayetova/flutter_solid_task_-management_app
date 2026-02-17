import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/task.dart';
import 'task_datasource.dart';

@Environment("prod")
@LazySingleton(as: TaskDataSource)
class SharedPrefTaskDataSource implements TaskDataSource {
  final SharedPreferences _prefs;
  static const _key = 'tasks_list';

  SharedPrefTaskDataSource(this._prefs);

  @override
  Future<List<Task>> readAll() async {
    final String? data = _prefs.getString(_key);
    if (data == null) return [];
    final List decoded = jsonDecode(data);
    return decoded.map((e) => Task(id: e['id'], title: e['title'])).toList();
  }

  @override
  Future<void> write(Task task) async {
    final tasks = await readAll();
    tasks.add(task);
    await _prefs.setString(_key, jsonEncode(tasks.map((e) => {'id': e.id, 'title': e.title}).toList()));
  }

  @override
  Future<void> delete(String id) async {
    final tasks = await readAll();
    tasks.removeWhere((t) => t.id == id);
    await _prefs.setString(_key, jsonEncode(tasks.map((e) => {'id': e.id, 'title': e.title}).toList()));
  }

  @override
  @disposeMethod
  Future<void> dispose() async {}
}