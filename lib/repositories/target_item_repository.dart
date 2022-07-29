import 'package:berhentikok/model/target_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TargetItemRepository {
  final Box<TargetItem> targetItemsBox;

  TargetItemRepository(this.targetItemsBox);

  List<TargetItem> loadAll() {
    return targetItemsBox.values.toList();
  }

  bool add(TargetItem targetItem) {
    try {
      targetItemsBox.add(targetItem);
      return true;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteAll() async {
    await targetItemsBox.deleteAll(targetItemsBox.keys);
  }
}
