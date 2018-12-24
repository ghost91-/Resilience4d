module resilience4d.fallback.fallback_test;

import resilience4d.fallback;

version (RESILIENCE4D_UNITTEST)
{
    import unit_threaded;
}

@("attempt with free function")
unittest
{
    // given
    int foo()
    {
        return 0;
    }

    alias underTest = attempt!foo;

    // when
    immutable result = underTest();

    // then
    result.hasValue.should.be == true;
    result.value.should.be == 0;
}

@("attempt with lambda")
unittest
{
    // given
    alias underTest = attempt!(() => 0);

    // when
    immutable result = underTest();

    // then
    result.hasValue.should.be == true;
    result.value.should.be == 0;
}

@("attempt with lambda with parameter")
unittest
{
    // given
    alias underTest = attempt!(x => x);

    // when
    immutable result = underTest(42);

    // then
    result.hasValue.should.be == true;
    result.value.should.be == 42;
}

@("failed attempt")
unittest
{
    // given
    alias underTest = attempt!(function int() { throw new Exception("foo"); });

    // when
    immutable result = underTest();

    // then
    result.hasValue.should.be == false;
    result.exception.msg.should.be == "foo";
}

@("attempt with closure")
unittest
{
    // given
    auto x = 42;
    alias underTest = attempt!(() => x);

    // when
    immutable result = underTest();

    // then
    result.hasValue.should.be == true;
    result.value.should.be == 42;
}

@("attempt with closure referencing a member function")
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
    immutable result = underTest();

    // then
    result.hasValue.should.be == true;
    result.value.should.be == 0;
}

@("attempt with static member function")
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
    immutable result = underTest();

    // then
    result.hasValue.should.be == true;
    result.value.should.be == 0;
}
