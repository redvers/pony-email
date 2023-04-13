use "collections"
use "encode/base64"

class EMail
  """
  This class represents a single EMail.  It contains as fields:

  * To, Cc, Bcc values.
  * Subject
  * From
  * Array[MIMEContent val] which contains all of the text/images/attachments
  """

  var contents: Array[MIMEContent val] = []
  var boundary: String = "lqwkejhdlkjqewhdlhdlkjhqewdljkqwgfvedyugqewukdgqewklugqwFIXME"
  var to: Map[String val, String val] val = Map[String val, String val]
  var cc: Map[String val, String val] val = Map[String val, String val]
  var bcc: Map[String val, String val] val = Map[String val, String val]
  var subject: String val = ""
  var from: String val = ""

  new iso create() => None

  fun render(): String =>
    render_headers() +
    render_bodies() +
    "--" + boundary + "--\r\n"

  fun render_headers(): String =>
    "To: " + ", ".join(to.keys()) + "\r\n" +
    "Cc: " + ", ".join(cc.keys()) + "\r\n" +
    "Subject: " + subject + "\r\n" +
    "Content-Type: multipart/alternative; boundary=" + boundary + "\r\n" +
    "Mime-Version: 1.0\r\n\r\n"

  fun render_bodies(): String val =>
    var bodies: String trn = recover trn "--" + boundary + "\r\n" end
    for f in contents.values() do
      bodies.append(f.render())
    end
    consume bodies

