import "dart:typed_data";

final Uint8List kBytes = Uint8List.fromList(<int>[107, 73, 110, 116, 58, 32, 105, 110, 116, 32, 61, 32, 52, 50, 10, 107, 70, 108, 111, 97, 116, 58, 32, 102, 108, 111, 97, 116, 32, 61, 32, 51, 46, 49, 52, 10, 107, 83, 116, 114, 58, 32, 115, 116, 114, 32, 61, 32, 34, 72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 34, 10, 107, 66, 121, 116, 101, 115, 58, 32, 98, 121, 116, 101, 115, 32, 61, 32, 98, 34, 72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 34, 10, 107, 68, 105, 99, 116, 58, 32, 100, 105, 99, 116, 91, 115, 116, 114, 44, 32, 105, 110, 116, 93, 32, 61, 32, 123, 34, 111, 110, 101, 34, 58, 32, 49, 44, 32, 34, 116, 119, 111, 34, 58, 32, 50, 44, 32, 34, 116, 104, 114, 101, 101, 34, 58, 32, 51, 125, 10, 107, 76, 105, 115, 116, 58, 32, 108, 105, 115, 116, 91, 105, 110, 116, 93, 32, 61, 32, 91, 49, 44, 32, 50, 44, 32, 51, 93, 10, 107, 83, 101, 116, 58, 32, 115, 101, 116, 91, 105, 110, 116, 93, 32, 61, 32, 115, 101, 116, 40, 91, 49, 44, 32, 50, 44, 32, 51, 93, 41, 10, 10, 10, 100, 101, 102, 32, 95, 95, 97, 115, 115, 101, 114, 116, 95, 116, 121, 112, 101, 40, 118, 97, 108, 117, 101, 44, 32, 116, 58, 32, 116, 121, 112, 101, 41, 58, 10, 32, 32, 32, 32, 97, 115, 115, 101, 114, 116, 32, 105, 115, 105, 110, 115, 116, 97, 110, 99, 101, 40, 118, 97, 108, 117, 101, 44, 32, 116, 41, 44, 32, 102, 34, 101, 120, 112, 101, 99, 116, 101, 100, 32, 123, 116, 125, 44, 32, 98, 117, 116, 32, 103, 111, 116, 32, 123, 116, 121, 112, 101, 40, 118, 97, 108, 117, 101, 41, 125, 34, 10, 10, 10, 100, 101, 102, 32, 114, 101, 99, 101, 105, 118, 101, 95, 110, 111, 110, 101, 40, 118, 97, 108, 117, 101, 58, 32, 78, 111, 110, 101, 41, 58, 10, 32, 32, 32, 32, 97, 115, 115, 101, 114, 116, 32, 118, 97, 108, 117, 101, 32, 105, 115, 32, 78, 111, 110, 101, 10, 10, 10, 100, 101, 102, 32, 114, 101, 113, 117, 101, 115, 116, 95, 110, 111, 110, 101, 40, 41, 32, 45, 62, 32, 78, 111, 110, 101, 58, 10, 32, 32, 32, 32, 114, 101, 116, 117, 114, 110, 32, 78, 111, 110, 101, 10, 10, 10, 100, 101, 102, 32, 114, 101, 99, 101, 105, 118, 101, 95, 98, 111, 111, 108, 95, 116, 114, 117, 101, 40, 118, 97, 108, 117, 101, 58, 32, 98, 111, 111, 108, 41, 58, 10, 32, 32, 32, 32, 95, 95, 97, 115, 115, 101, 114, 116, 95, 116, 121, 112, 101, 40, 118, 97, 108, 117, 101, 44, 32, 98, 111, 111, 108, 41, 10, 32, 32, 32, 32, 97, 115, 115, 101, 114, 116, 32, 118, 97, 108, 117, 101, 32, 105, 115, 32, 84, 114, 117, 101, 10, 10, 10, 100, 101, 102, 32, 114, 101, 113, 117, 101, 115, 116, 95, 98, 111, 111, 108, 95, 116, 114, 117, 101, 40, 41, 32, 45, 62, 32, 98, 111, 111, 108, 58, 10, 32, 32, 32, 32, 114, 101, 116, 117, 114, 110, 32, 84, 114, 117, 101, 10, 10, 10, 100, 101, 102, 32, 114, 101, 99, 101, 105, 118, 101, 95, 98, 111, 111, 108, 95, 102, 97, 108, 115, 101, 40, 118, 97, 108, 117, 101, 58, 32, 98, 111, 111, 108, 41, 58, 10, 32, 32, 32, 32, 95, 95, 97, 115, 115, 101, 114, 116, 95, 116, 121, 112, 101, 40, 118, 97, 108, 117, 101, 44, 32, 98, 111, 111, 108, 41, 10, 32, 32, 32, 32, 97, 115, 115, 101, 114, 116, 32, 118, 97, 108, 117, 101, 32, 105, 115, 32, 70, 97, 108, 115, 101, 10, 10, 10, 100, 101, 102, 32, 114, 101, 113, 117, 101, 115, 116, 95, 98, 111, 111, 108, 95, 102, 97, 108, 115, 101, 40, 41, 32, 45, 62, 32, 98, 111, 111, 108, 58, 10, 32, 32, 32, 32, 114, 101, 116, 117, 114, 110, 32, 70, 97, 108, 115, 101, 10, 10, 10, 100, 101, 102, 32, 114, 101, 99, 101, 105, 118, 101, 95, 105, 110, 116, 40, 118, 97, 108, 117, 101, 58, 32, 105, 110, 116, 41, 58, 10, 32, 32, 32, 32, 95, 95, 97, 115, 115, 101, 114, 116, 95, 116, 121, 112, 101, 40, 118, 97, 108, 117, 101, 44, 32, 105, 110, 116, 41, 10, 32, 32, 32, 32, 97, 115, 115, 101, 114, 116, 32, 118, 97, 108, 117, 101, 32, 61, 61, 32, 107, 73, 110, 116, 10, 10, 10, 100, 101, 102, 32, 114, 101, 113, 117, 101, 115, 116, 95, 105, 110, 116, 40, 41, 32, 45, 62, 32, 105, 110, 116, 58, 10, 32, 32, 32, 32, 114, 101, 116, 117, 114, 110, 32, 107, 73, 110, 116, 10, 10, 10, 100, 101, 102, 32, 114, 101, 99, 101, 105, 118, 101, 95, 102, 108, 111, 97, 116, 40, 118, 97, 108, 117, 101, 58, 32, 102, 108, 111, 97, 116, 41, 58, 10, 32, 32, 32, 32, 95, 95, 97, 115, 115, 101, 114, 116, 95, 116, 121, 112, 101, 40, 118, 97, 108, 117, 101, 44, 32, 102, 108, 111, 97, 116, 41, 10, 32, 32, 32, 32, 97, 115, 115, 101, 114, 116, 32, 118, 97, 108, 117, 101, 32, 61, 61, 32, 107, 70, 108, 111, 97, 116, 10, 10, 10, 100, 101, 102, 32, 114, 101, 113, 117, 101, 115, 116, 95, 102, 108, 111, 97, 116, 40, 41, 32, 45, 62, 32, 102, 108, 111, 97, 116, 58, 10, 32, 32, 32, 32, 114, 101, 116, 117, 114, 110, 32, 107, 70, 108, 111, 97, 116, 10, 10, 10, 100, 101, 102, 32, 114, 101, 99, 101, 105, 118, 101, 95, 115, 116, 114, 40, 118, 97, 108, 117, 101, 58, 32, 115, 116, 114, 41, 58, 10, 32, 32, 32, 32, 95, 95, 97, 115, 115, 101, 114, 116, 95, 116, 121, 112, 101, 40, 118, 97, 108, 117, 101, 44, 32, 115, 116, 114, 41, 10, 32, 32, 32, 32, 97, 115, 115, 101, 114, 116, 32, 118, 97, 108, 117, 101, 32, 61, 61, 32, 107, 83, 116, 114, 10, 10, 10, 100, 101, 102, 32, 114, 101, 113, 117, 101, 115, 116, 95, 115, 116, 114, 40, 41, 32, 45, 62, 32, 115, 116, 114, 58, 10, 32, 32, 32, 32, 114, 101, 116, 117, 114, 110, 32, 107, 83, 116, 114, 10, 10, 10, 100, 101, 102, 32, 114, 101, 99, 101, 105, 118, 101, 95, 98, 121, 116, 101, 115, 40, 118, 97, 108, 117, 101, 58, 32, 98, 121, 116, 101, 115, 41, 58, 10, 32, 32, 32, 32, 95, 95, 97, 115, 115, 101, 114, 116, 95, 116, 121, 112, 101, 40, 118, 97, 108, 117, 101, 44, 32, 98, 121, 116, 101, 115, 41, 10, 32, 32, 32, 32, 97, 115, 115, 101, 114, 116, 32, 118, 97, 108, 117, 101, 32, 61, 61, 32, 107, 66, 121, 116, 101, 115, 10, 10, 10, 100, 101, 102, 32, 114, 101, 113, 117, 101, 115, 116, 95, 98, 121, 116, 101, 115, 40, 41, 32, 45, 62, 32, 98, 121, 116, 101, 115, 58, 10, 32, 32, 32, 32, 114, 101, 116, 117, 114, 110, 32, 107, 66, 121, 116, 101, 115, 10, 10, 10, 100, 101, 102, 32, 114, 101, 99, 101, 105, 118, 101, 95, 100, 105, 99, 116, 40, 118, 97, 108, 117, 101, 58, 32, 100, 105, 99, 116, 91, 115, 116, 114, 44, 32, 105, 110, 116, 93, 41, 58, 10, 32, 32, 32, 32, 95, 95, 97, 115, 115, 101, 114, 116, 95, 116, 121, 112, 101, 40, 118, 97, 108, 117, 101, 44, 32, 100, 105, 99, 116, 41, 10, 32, 32, 32, 32, 97, 115, 115, 101, 114, 116, 32, 118, 97, 108, 117, 101, 32, 61, 61, 32, 107, 68, 105, 99, 116, 10, 10, 10, 100, 101, 102, 32, 114, 101, 113, 117, 101, 115, 116, 95, 100, 105, 99, 116, 40, 41, 32, 45, 62, 32, 100, 105, 99, 116, 91, 115, 116, 114, 44, 32, 105, 110, 116, 93, 58, 10, 32, 32, 32, 32, 114, 101, 116, 117, 114, 110, 32, 107, 68, 105, 99, 116, 10, 10, 10, 100, 101, 102, 32, 114, 101, 99, 101, 105, 118, 101, 95, 108, 105, 115, 116, 40, 118, 97, 108, 117, 101, 58, 32, 108, 105, 115, 116, 91, 105, 110, 116, 93, 41, 58, 10, 32, 32, 32, 32, 95, 95, 97, 115, 115, 101, 114, 116, 95, 116, 121, 112, 101, 40, 118, 97, 108, 117, 101, 44, 32, 108, 105, 115, 116, 41, 10, 32, 32, 32, 32, 97, 115, 115, 101, 114, 116, 32, 118, 97, 108, 117, 101, 32, 61, 61, 32, 107, 76, 105, 115, 116, 10, 10, 10, 100, 101, 102, 32, 114, 101, 113, 117, 101, 115, 116, 95, 108, 105, 115, 116, 40, 41, 32, 45, 62, 32, 108, 105, 115, 116, 91, 105, 110, 116, 93, 58, 10, 32, 32, 32, 32, 114, 101, 116, 117, 114, 110, 32, 107, 76, 105, 115, 116, 10, 10, 10, 100, 101, 102, 32, 114, 101, 99, 101, 105, 118, 101, 95, 115, 101, 116, 40, 118, 97, 108, 117, 101, 58, 32, 115, 101, 116, 91, 105, 110, 116, 93, 41, 58, 10, 32, 32, 32, 32, 95, 95, 97, 115, 115, 101, 114, 116, 95, 116, 121, 112, 101, 40, 118, 97, 108, 117, 101, 44, 32, 115, 101, 116, 41, 10, 32, 32, 32, 32, 97, 115, 115, 101, 114, 116, 32, 118, 97, 108, 117, 101, 32, 61, 61, 32, 107, 83, 101, 116, 10, 10, 10, 100, 101, 102, 32, 114, 101, 113, 117, 101, 115, 116, 95, 115, 101, 116, 40, 41, 32, 45, 62, 32, 115, 101, 116, 91, 105, 110, 116, 93, 58, 10, 32, 32, 32, 32, 114, 101, 116, 117, 114, 110, 32, 107, 83, 101, 116, 10]);

const String kBase64 = "a0ludDogaW50ID0gNDIKa0Zsb2F0OiBmbG9hdCA9IDMuMTQKa1N0cjogc3RyID0gIkhlbGxvIFdvcmxkIgprQnl0ZXM6IGJ5dGVzID0gYiJIZWxsbyBXb3JsZCIKa0RpY3Q6IGRpY3Rbc3RyLCBpbnRdID0geyJvbmUiOiAxLCAidHdvIjogMiwgInRocmVlIjogM30Ka0xpc3Q6IGxpc3RbaW50XSA9IFsxLCAyLCAzXQprU2V0OiBzZXRbaW50XSA9IHNldChbMSwgMiwgM10pCgoKZGVmIF9fYXNzZXJ0X3R5cGUodmFsdWUsIHQ6IHR5cGUpOgogICAgYXNzZXJ0IGlzaW5zdGFuY2UodmFsdWUsIHQpLCBmImV4cGVjdGVkIHt0fSwgYnV0IGdvdCB7dHlwZSh2YWx1ZSl9IgoKCmRlZiByZWNlaXZlX25vbmUodmFsdWU6IE5vbmUpOgogICAgYXNzZXJ0IHZhbHVlIGlzIE5vbmUKCgpkZWYgcmVxdWVzdF9ub25lKCkgLT4gTm9uZToKICAgIHJldHVybiBOb25lCgoKZGVmIHJlY2VpdmVfYm9vbF90cnVlKHZhbHVlOiBib29sKToKICAgIF9fYXNzZXJ0X3R5cGUodmFsdWUsIGJvb2wpCiAgICBhc3NlcnQgdmFsdWUgaXMgVHJ1ZQoKCmRlZiByZXF1ZXN0X2Jvb2xfdHJ1ZSgpIC0+IGJvb2w6CiAgICByZXR1cm4gVHJ1ZQoKCmRlZiByZWNlaXZlX2Jvb2xfZmFsc2UodmFsdWU6IGJvb2wpOgogICAgX19hc3NlcnRfdHlwZSh2YWx1ZSwgYm9vbCkKICAgIGFzc2VydCB2YWx1ZSBpcyBGYWxzZQoKCmRlZiByZXF1ZXN0X2Jvb2xfZmFsc2UoKSAtPiBib29sOgogICAgcmV0dXJuIEZhbHNlCgoKZGVmIHJlY2VpdmVfaW50KHZhbHVlOiBpbnQpOgogICAgX19hc3NlcnRfdHlwZSh2YWx1ZSwgaW50KQogICAgYXNzZXJ0IHZhbHVlID09IGtJbnQKCgpkZWYgcmVxdWVzdF9pbnQoKSAtPiBpbnQ6CiAgICByZXR1cm4ga0ludAoKCmRlZiByZWNlaXZlX2Zsb2F0KHZhbHVlOiBmbG9hdCk6CiAgICBfX2Fzc2VydF90eXBlKHZhbHVlLCBmbG9hdCkKICAgIGFzc2VydCB2YWx1ZSA9PSBrRmxvYXQKCgpkZWYgcmVxdWVzdF9mbG9hdCgpIC0+IGZsb2F0OgogICAgcmV0dXJuIGtGbG9hdAoKCmRlZiByZWNlaXZlX3N0cih2YWx1ZTogc3RyKToKICAgIF9fYXNzZXJ0X3R5cGUodmFsdWUsIHN0cikKICAgIGFzc2VydCB2YWx1ZSA9PSBrU3RyCgoKZGVmIHJlcXVlc3Rfc3RyKCkgLT4gc3RyOgogICAgcmV0dXJuIGtTdHIKCgpkZWYgcmVjZWl2ZV9ieXRlcyh2YWx1ZTogYnl0ZXMpOgogICAgX19hc3NlcnRfdHlwZSh2YWx1ZSwgYnl0ZXMpCiAgICBhc3NlcnQgdmFsdWUgPT0ga0J5dGVzCgoKZGVmIHJlcXVlc3RfYnl0ZXMoKSAtPiBieXRlczoKICAgIHJldHVybiBrQnl0ZXMKCgpkZWYgcmVjZWl2ZV9kaWN0KHZhbHVlOiBkaWN0W3N0ciwgaW50XSk6CiAgICBfX2Fzc2VydF90eXBlKHZhbHVlLCBkaWN0KQogICAgYXNzZXJ0IHZhbHVlID09IGtEaWN0CgoKZGVmIHJlcXVlc3RfZGljdCgpIC0+IGRpY3Rbc3RyLCBpbnRdOgogICAgcmV0dXJuIGtEaWN0CgoKZGVmIHJlY2VpdmVfbGlzdCh2YWx1ZTogbGlzdFtpbnRdKToKICAgIF9fYXNzZXJ0X3R5cGUodmFsdWUsIGxpc3QpCiAgICBhc3NlcnQgdmFsdWUgPT0ga0xpc3QKCgpkZWYgcmVxdWVzdF9saXN0KCkgLT4gbGlzdFtpbnRdOgogICAgcmV0dXJuIGtMaXN0CgoKZGVmIHJlY2VpdmVfc2V0KHZhbHVlOiBzZXRbaW50XSk6CiAgICBfX2Fzc2VydF90eXBlKHZhbHVlLCBzZXQpCiAgICBhc3NlcnQgdmFsdWUgPT0ga1NldAoKCmRlZiByZXF1ZXN0X3NldCgpIC0+IHNldFtpbnRdOgogICAgcmV0dXJuIGtTZXQK";
