use "encode/base64"

interface MIMEContentType
  fun content_type(): String val
  fun content_disposition(): String val
  fun ref set_content_type(data: String val): None
