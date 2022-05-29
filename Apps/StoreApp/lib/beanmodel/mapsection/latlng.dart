class BackLatLng{
  dynamic lat;
  dynamic lng;
  dynamic address;

  BackLatLng(this.lat, this.lng, this.address);

  @override
  String toString() {
    return 'BackLatLng{lat: $lat, lng: $lng, address: $address}';
  }
}