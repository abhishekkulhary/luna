// Selects the platform-appropriate database connection at compile time:
// native (SQLCipher-encrypted file) on mobile/desktop, WASM (browser-sandboxed)
// on web.
export 'connection_native.dart'
    if (dart.library.js_interop) 'connection_web.dart';
