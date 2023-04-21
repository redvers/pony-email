use "encode/base64"

class val MIMEContentTypeApplication is MIMEContentType
  var texttype: String val
  var filename: (None | String val) = None

  new val create(texttype': String val = "binary", filename': (String val | None) = None) =>
    texttype = texttype'
    filename = filename'

  fun content_type(): String val =>
    "Content-Type: application/" + texttype + "\r\n"

  fun content_disposition(): String val =>
    match filename
    | let name: None => return ""
    | let name: String val => return "Content-Disposition: attachment; filename=" + name + "\r\n"
    end
    ""
