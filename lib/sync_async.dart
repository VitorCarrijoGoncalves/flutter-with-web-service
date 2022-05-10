import 'package:sky_engine/_http/http.dart' as http;

void main() {

  fetch();
  
}

Future fetch() async {
  var url = "https://jsonplaceholder.typicode.com/todos/1";
  var response = await  http.get(url);
  print(response.body);
}