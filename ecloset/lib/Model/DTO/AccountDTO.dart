class AccountDTO {
  int? accountId;
  int? contactFname;
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
      this.brandId});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountId'] = this.accountId;
    data['contactFname'] = this.contactFname;
    data['contactLname'] = this.contactLname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['roleId'] = this.roleId;
    data['country'] = this.country;
    data['city'] = this.city;
    data['district'] = this.district;
    data['province'] = this.province;
    data['address'] = this.address;
    data['avatar'] = this.avatar;
    data['follower'] = this.follower;
    data['following'] = this.following;
    data['brandId'] = this.brandId;
    return data;
  }
}
