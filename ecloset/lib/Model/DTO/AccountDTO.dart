class AccountDTO {
  int? accountId;
  String? contactFname;
  String? contactLname;
  String? email;
  int? phone;
  String? password;
  int? roleId;
  String? country;
  String? city;
  String? district;
  String? province;
  String? address;
  String? avatar;
  String? follower;
  String? following;
  int? brandId;
  String? jwtToken;

  AccountDTO(
      {this.accountId,
      this.contactFname,
      this.contactLname,
      this.email,
      this.phone,
      this.password,
      this.roleId,
      this.country,
      this.city,
      this.district,
      this.province,
      this.address,
      this.avatar,
      this.follower,
      this.following,
      this.brandId,
      this.jwtToken});

  AccountDTO.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    contactFname = json['contactFname'];
    contactLname = json['contactLname'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    roleId = json['roleId'];
    country = json['country'];
    city = json['city'];
    district = json['district'];
    province = json['province'];
    address = json['address'];
    avatar = json['avatar'];
    follower = json['follower'];
    following = json['following'];
    brandId = json['brandId'];
    jwtToken = json['jwtToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['accountId'] = accountId;
    data['contactFname'] = contactFname;
    data['contactLname'] = contactLname;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['roleId'] = roleId;
    data['country'] = country;
    data['city'] = city;
    data['district'] = district;
    data['province'] = province;
    data['address'] = address;
    data['avatar'] = avatar;
    data['follower'] = follower;
    data['following'] = following;
    data['brandId'] = brandId;
    data['jwtToken'] = jwtToken;
    return data;
  }
}
