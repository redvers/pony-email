use "encode/base64"

class val MIMEContentTypeHTML is MIMEContentType
  var filename: (None | String val)

  new val create(filename': (String val | None) = None) =>
    filename = filename'

  fun content_type(): String val =>
    "Content-Type: text/html\r\n"

  fun content_disposition(): String val =>
    match filename
    | let name: None => return ""
    | let name: String val => return "Content-Disposition: attachment; filename=" + name + "\r\n"
    end
    ""

