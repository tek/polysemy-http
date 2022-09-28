# Unreleased

# 0.8.0.0

* Add `EncodeLazy` to `EntityEncode` and `DecodeLazy` to `EntityDecode`, and make `encode`/`decode` default to the
  strict versions.
* Add `interpretEntityDecodeAesonWith`, using an effectful callback for decoding.
* Use strict `ByteString` for the request body.
* Add an optional chunk size parameter to `streamResponse`.
* Unify `Http.response` and `Http.stream`.

# 0.5.0.0
* Add `Num Port`.
* Add json interpreters that transform payloads.
* Change pure `Http` interpreter to use supplied responses for streaming requests.

# 0.4.0.0
* Use `CookieJar` in the `Response` instead of requiring users to extract them from the headers.

# 0.3.0.0
* Add support for cookies.

# 0.2.0.3
* Remove the `base-noprelude` dependency in favor of using a `hiding` mixin.

# 0.1.0.0
* Initial release.
