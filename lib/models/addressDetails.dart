class AddressDetails {
  String? address;
  String? postcode;

  AddressDetails({required this.address, required this.postcode});

  String get flatten {
    return '${address!.replaceAll('\n', ' ')}, $postcode'
        .replaceAll(', , ', ', ');
  }

  Map toJson() => {
        'address': address,
        'postcode': postcode,
      };

  AddressDetails.clone(AddressDetails adr) {
    address = adr.address;
    postcode = adr.postcode;
  }
}
