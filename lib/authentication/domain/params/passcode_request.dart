class PasscodeRequest {
  final String passcode;

  PasscodeRequest({required this.passcode});

  Map<String, String> toJson() {
    return {
      'passcode': passcode,
    };
  }
}
