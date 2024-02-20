
class SendOtpResponse {
    String? status;
    String? message;

    SendOtpResponse({
        this.status,
        this.message,
    });

    factory SendOtpResponse.fromJson(Map<String, dynamic> json) => SendOtpResponse(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
