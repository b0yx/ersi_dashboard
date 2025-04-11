import 'package:ersei/app/applinks.dart';
import '../../../core/class/crudjson.dart';

class SendReportData {
  final CrudJson crudJson;

  SendReportData(this.crudJson);

  Future<dynamic> postData(Map<String, dynamic> reportData) async {
    var response = await crudJson.postData(AppLink.sendReportData, reportData);
    return response.fold((l) => l, (r) => r);
  }
}
