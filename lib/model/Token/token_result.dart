class TokenResult {
    String? expireTime;
    String? token;

    TokenResult({this.expireTime, this.token});

    factory TokenResult.fromJson(Map<String, dynamic> json) {
        return TokenResult(
            expireTime: json['expireTime'] ?? "",
            token: json['token'] ?? "",
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['expireTime'] = expireTime;
        data['token'] = token;
        return data;
    }
}