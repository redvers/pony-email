use "encode/base64"

class val MIMEContent
  var transfer_type: MIMETransferType val
  var content_type: MIMEContentType val
  var raw_data: (String val | Array[U8] val) = ""

  new val create(content_type': MIMEContentType val, transfer_type': MIMETransferType val, raw_data': (String val | Array[U8] val)) =>
    content_type = content_type'
    transfer_type = transfer_type'
    raw_data = raw_data'

  fun render(): String =>
    transfer_type.content_transfer_encoding_header() +
    content_type.content_type() +
    content_type.content_disposition() +
    "Mime-Version: 1.0\r\n\r\n" +
    transfer_type.encode(raw_data) + "\r\n"
