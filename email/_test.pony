use "pony_test"

actor \nodoc\ Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() => None

  fun tag tests(test: PonyTest) =>
    test(_TestDummy)

class \nodoc\ iso _TestDummy is UnitTest
  fun name(): String => "Dummy"

  fun apply(h: TestHelper) =>
    h.assert_true(true)
