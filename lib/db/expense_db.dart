import 'dart:convert';
import 'package:dr_ashraf_clinic/model/expense_model.dart';
import 'package:http/http.dart' as http;

class ExpenseDB {
  final url = 'http://localhost:8080/';
  final expense = 'expenses/';
  final headers = {'Content-Type': 'application/json'};
  final encoding = Encoding.getByName('utf-8');

  ExpenseDB();

  Future<List<ExpenseModel>> makeExpenseGetRequest() async {
    http.Response response = await http.get(Uri.parse('$url$expense'));
    List<ExpenseModel> result = List<ExpenseModel>.from(
        json.decode(response.body).map((json) => ExpenseModel.fromJson(json)));
    result.sort((a, b) => a.id!.compareTo(b.id as num));
    print(response.body);
    return result;
  }

  makeExpensePostRequest(ExpenseModel record) async {
    String body = json.encode(record.toJson());
    http.Response response = await http.post(Uri.parse('$url$expense'),
        headers: headers, body: body, encoding: encoding);
    print(response.body);
  }

  makeExpensePutRequest(ExpenseModel record) async {
    String body = json.encode(record.toJson());
    http.Response response = await http.put(
        Uri.parse('$url$expense${record.id}'),
        headers: headers,
        body: body,
        encoding: encoding);
    print(response.body);
  }

  makeExpenseDeleteRequest(ExpenseModel record) async {
    http.Response response = await http
        .delete(Uri.parse('$url$expense${record.id}'), headers: headers);
    print(response.body);
  }
}
