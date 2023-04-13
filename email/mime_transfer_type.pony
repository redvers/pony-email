use "encode/base64"

interface val MIMETransferType
  fun content_transfer_encoding_header(): String
  fun encode(data: (String val | Array[U8] val)): String val
