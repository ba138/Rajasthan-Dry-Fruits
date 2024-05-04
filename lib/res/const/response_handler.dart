import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rjfruits/utils/routes/utils.dart';

void handleApiError(dynamic error, BuildContext context) {
  if (error is SocketException) {
    Utils.flushBarErrorMessage(
        "Network error. Check your internet connection.", context);
  } else if (error is FormatException) {
    Utils.flushBarErrorMessage("Invalid response format", context);
  } else {
    Utils.flushBarErrorMessage("Unexpected error occurred", context);
  }
}
