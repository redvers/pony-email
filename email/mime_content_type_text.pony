use "encode/base64"

class MIMEContentTypeText is MIMEContentType
  var texttype: String = "plain"
  var filename: (None | String val) = None

  fun content_type(): String val =>
    "Content-Type: text/" + texttype + "\r\n"

  fun content_disposition(): String val =>
    match filename
    | let name: None => return ""
    | let name: String val => return "Content-Disposition: attachment; filename=" + name + "\r\n"
    end
    ""

  fun ref set_content_type(data: String val): None =>
    texttype = data
