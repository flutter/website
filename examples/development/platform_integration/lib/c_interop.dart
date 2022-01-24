// #docregion DynamicLibrary
import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX

final DynamicLibrary nativeAddLib = Platform.isAndroid
<<<<<<< HEAD
    ? DynamicLibrary.open('libnative_add.so')
=======
    ? DynamicLibrary.open("libnative_add.so")
>>>>>>> flutter-main
    : DynamicLibrary.process();
// #enddocregion DynamicLibrary

// #docregion NativeAdd
final int Function(int x, int y) nativeAdd = nativeAddLib
<<<<<<< HEAD
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('native_add')
=======
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add")
>>>>>>> flutter-main
    .asFunction();
// #enddocregion NativeAdd
