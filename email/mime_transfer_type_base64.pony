use "encode/base64"

primitive MIMETransferTypeBase64 is MIMETransferType
  fun content_transfer_encoding_header(): String => "Content-Transfer-Encoding: base64\r\n"
  fun encode(data: (String val | Array[U8] val)): String val => Base64.encode_mime(data)
