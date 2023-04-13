use "encode/base64"

class MIMEContent
  var transfer_type: MIMETransferType
  var content_type: MIMEContentType
  var raw_data: (String val | Array[U8] val) = ""
  var separator: String val = ""

  new create(content_type': MIMEContentType, transfer_type': MIMETransferType) =>
    content_type = content_type'
    transfer_type = transfer_type'

  fun render(): String =>
    transfer_type.content_transfer_encoding_header() +
    content_type.content_type() +
    content_type.content_disposition() +
    "Mime-Version: 1.0\r\n\r\n" +
    transfer_type.encode(raw_data) + "\r\n"
