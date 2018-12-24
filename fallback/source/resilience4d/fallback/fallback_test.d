module resilience4d.fallback.fallback_test;

import resilience4d.fallback;

version (RESILIENCE4D_UNITTEST)
{
    import fluent.asserts;
}

unittest
{
    // given
    int foo()
    {
        return 0;
    }

    alias underTest = attempt!foo;

    // when
    auto result = underTest();

    // then
    result.hasValue.should.equal(true);
    result.value.should.equal(0);
}

unittest
{
    // given
    alias underTest = attempt!(() => 0);

    // when
    auto result = underTest();

    // then
    result.hasValue.should.equal(true);
    result.value.should.equal(0);
}

unittest
{
    // given
    alias underTest = attempt!(x => x);

    // when
    auto result = underTest(42);

    // then
    result.hasValue.should.equal(true);
    result.value.should.equal(42);
}

unittest
{
    // given
    alias underTest = attempt!(function int() { throw new Exception("foo"); });

    // when
    auto result = underTest();

    // then
    result.hasValue.should.equal(false);
    result.exception.msg.should.equal("foo");
}

unittest
{
    // given
    auto x = 42;
    alias underTest = attempt!(() => x);

    // when
    auto result = underTest();

    // then
    result.hasValue.should.equal(true);
    result.value.should.equal(42);
}

unittest
{
    // given
    struct SomeStruct
    {
        int foo()
        {
            return 0;
        }
    }

    SomeStruct someStruct;
    alias underTest = attempt!(() => someStruct.foo());

    // when
    auto result = underTest();

    // then
    result.hasValue.should.equal(true);
    result.value.should.equal(0);
}

unittest
{
    // given
    struct SomeStruct
    {
        static int foo()
        {
            return 0;
        }
    }

    alias underTest = attempt!(SomeStruct.foo);

    // when
    auto result = underTest();

    // then
    result.hasValue.should.equal(true);
    result.value.should.equal(0);
}
