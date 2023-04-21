use "debug"
use "collections/persistent"
use "encode/base64"
use "random"
use "time"

class EMail
  """
  This class represents a single EMail.  It contains as fields:

  * To, Cc, Bcc values.
  * Subject
  * From
  * Array[MIMEContent val] which contains all of the text/images/attachments
  """

  var contents': Array[MIMEContent val] = []
  var boundary': String = "gaUn85W5WAw5dGugOB/roH9sGDVhTmkfgB2lTWAVC6"
  var to': Set[String val] val = Set[String val]
  var cc': Set[String val] val = Set[String val]
  var bcc': Set[String val] val = Set[String val]
  var subject': String val = ""
  var from': String val = ""

  new iso create() =>
    (let s: I64, let t: I64) = Time.now()
    let random: Rand = Rand(s.u64(),t.u64())

    let a: Array[U8] trn = recover trn Array[U8].init(0, 32) end
    try
      a.update_u64(0, random.next())?   // There's actually
      a.update_u64(8, random.next())?   // no security reason
      a.update_u64(16, random.next())?  // for this to be highly
      a.update_u64(24, random.next())?  // random.
      boundary' = Base64.encode_mime(a).>rstrip().clone()
    end


  fun ref to(email: String val) => to' = to'.add(email)
  fun ref cc(email: String val) => cc' = cc'.add(email)
  fun ref bcc(email: String val) => bcc' = bcc'.add(email)
  fun ref from(f: String val) => from' = f
  fun ref subject(f: String val) => subject' = f

  fun ref clear_bodies() => contents' = []

  fun ref html_body(body: String val) =>
    let mimecontent: MIMEContent val = MIMEContent(MIMEContentTypeHTML, MIMETransferTypeBase64, body)
    contents'.push(mimecontent)





  fun render(): String =>
    render_headers() +
    render_bodies() +
    "--" + boundary' + "--\r\n"

  fun render_headers(): String =>
    "From: " + from' + "\r\n" +
    "To: " + ", ".join(to'.values()) + "\r\n" +
    "Cc: " + ", ".join(cc'.values()) + "\r\n" +
    "Subject: " + subject' + "\r\n" +
    "Content-Type: multipart/alternative; boundary=" + boundary' + "\r\n" +
    "Mime-Version: 1.0\r\n\r\n"

  fun render_bodies(): String val =>
    var bodies': String trn = recover trn String end
    for f in contents'.values() do
      bodies'.append("--" + boundary' + "\r\n")
      bodies'.append(f.render())
    end
    consume bodies'

