import 'package:http/http.dart' as http;

class DirectionsProvider {
  Future<dynamic> getDirections(data) async {
    var url = Uri.parse(
        'https://router.project-osrm.org/route/v1/driving/$data?steps=true&annotations=true&geometries=geojson&overview=full');
    var response = await http.get(url);

    return response;
  }
}
