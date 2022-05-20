// #docregion FFI
import 'dart:ffi';
import 'package:ffi/ffi.dart'; // contains .toNativeUtf16() extension method

typedef MessageBoxNative = Int32 Function(
  IntPtr hWnd,
  Pointer<Utf16> lpText,
  Pointer<Utf16> lpCaption,
  Int32 uType,
);

typedef MessageBoxDart = int Function(
  int hWnd,
  Pointer<Utf16> lpText,
  Pointer<Utf16> lpCaption,
  int uType,
);

void exampleFfi() {
  final user32 = DynamicLibrary.open('user32.dll');
  final messageBox =
      user32.lookupFunction<MessageBoxNative, MessageBoxDart>('MessageBoxW');

  final result = messageBox(
    0, // No owner window
    'Test message'.toNativeUtf16(), // Message
    'Window caption'.toNativeUtf16(), // Window title
    0, // OK button only
  );
}
// #enddocregion FFI