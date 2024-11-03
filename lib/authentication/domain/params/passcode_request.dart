class PasscodeRequest {
  final String passcode;

  PasscodeRequest({required this.passcode});

  Map<String, dynamic> toJson() {
    return {
      'passcode': passcode,
    };
  }
}
