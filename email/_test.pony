use "pony_test"

actor \nodoc\ Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() => None

  fun tag tests(test: PonyTest) =>
    test(_TestHeaders)
    test(_TestHTMLEmail)

class \nodoc\ iso _TestHeaders is UnitTest
  fun name(): String => "Headers"

  fun apply(h: TestHelper)? =>
    let email: EMail = EMail
    email.to("red@example.com")
    h.assert_true(true)
    h.assert_true((",".join(email.to'.keys())) == "red@example.com")

    email.to("notreallyred@example.com")
    h.assert_true((",".join(email.to'.keys())) == "notreallyred@example.com,red@example.com")

    email
    .>cc("red@example.com")
    .>cc("notreallyred@example.com")
    .>from("fromred@example.com")
    .>subject("This is a random subject")

    h.env.out.print(email.render_headers())

    h.assert_true((",".join(email.cc'.keys())) == "notreallyred@example.com,red@example.com")

    let headers: Array[String] = email.render_headers().split_by("\r\n")
    h.assert_eq[USize](headers.size(), 9)
    h.assert_eq[String](headers(0)?, "From: fromred@example.com")
    h.assert_eq[String](headers(1)?, "To: notreallyred@example.com, red@example.com")
    h.assert_eq[String](headers(2)?, "Cc: notreallyred@example.com, red@example.com")
    h.assert_eq[String](headers(3)?, "Subject: This is a random subject")
    h.assert_eq[String](headers(4)?.substring(0,46), "Content-Type: multipart/alternative; boundary=")
    h.assert_eq[String](headers(5)?, "")
    h.assert_eq[String](headers(6)?, "Mime-Version: 1.0")
    h.assert_eq[String](headers(7)?, "")


class \nodoc\ iso _TestHTMLEmail is UnitTest
  fun name(): String => "HTML Email"

  fun apply(h: TestHelper) =>
    let email: EMail = EMail
    email
    .>to("red@example.com")
    .>from("fromred@example.com")
    .>subject("This is a text HTML Email")
    .>html_body("<h1>Hello World</h1>")

    h.env.out.print(email.render())

    email.clear_bodies()

    h.env.out.print(email.render())
