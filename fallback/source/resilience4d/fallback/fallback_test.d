module resilience4d.fallback.fallback_test;

import resilience4d.fallback;

version (RESILIENCE4D_UNITTEST)
{
    import unit_threaded;
}

@("attempt with free function")
@safe pure unittest
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
@safe pure unittest
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
@safe pure unittest
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
@safe pure unittest
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
@safe pure unittest
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
@safe pure unittest
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
@safe pure unittest
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

@("recover with free function")
@safe pure unittest
{
    // given
    int foo(Exception)
    {
        return 42;
    }

    immutable val = unexpected!int(new Exception(""));

    // when
    immutable result = val.recover!foo;

    // then
    result.hasValue.should.be == true;
    result.value.should.be == 42;
}

@("recover with specific exception")
@safe pure unittest
{
    // given
    static class MyException : Exception
    {
        this()
        {
            super("");
        }
    }

    int foo(MyException)
    {
        return 42;
    }

    immutable val = unexpected!int(new MyException);

    // when
    immutable result = val.recover!foo;

    // then
    result.hasValue.should.be == true;
    result.value.should.be == 42;
}

@("recover with more generic exception than thrown")
@safe pure unittest
{
    // given
    static class MyException : Exception
    {
        this()
        {
            super("");
        }
    }

    int foo(Exception)
    {
        return 42;
    }

    immutable val = unexpected!int(new MyException);

    // when
    immutable result = val.recover!foo;

    // then
    result.hasValue.should.be == true;
    result.value.should.be == 42;
}

@("recover with non matching exception")
@safe pure unittest
{
    // given
    static class MyException : Exception
    {
        this()
        {
            super("");
        }
    }

    int foo(MyException)
    {
        return 42;
    }

    immutable val = unexpected!int(new Exception(""));

    // when
    immutable result = val.recover!foo;

    // then
    result.hasValue.should.be == false;
}

@("recover with template lambda")
@safe pure unittest
{
    // given
    static class MyException : Exception
    {
        this()
        {
            super("");
        }
    }

    immutable val = unexpected!int(new MyException);

    // when
    immutable result = val.recover!(_ => 9001);

    // then
    result.hasValue.should.be == true;
    result.value.should.be == 9001;
}

@("recover with function lambda")
@safe pure unittest
{
    // given
    static class MyException : Exception
    {
        this()
        {
            super("");
        }
    }

    immutable val = unexpected!int(new MyException);

    // when
    immutable result = val.recover!((MyException _) => 9001);

    // then
    result.hasValue.should.be == true;
    result.value.should.be == 9001;
}

@("multiple recovers")
@safe pure unittest
{
    // given
    static class MyException : Exception
    {
        this()
        {
            super("");
        }
    }

    immutable val = unexpected!int(new Exception(""));

    // when
    immutable result = val.recover!((MyException _) => 9001)
        .recover!((Exception _) => 42);

    // then
    result.hasValue.should.be == true;
    result.value.should.be == 42;
}

@("recover with exception thrown")
@safe pure unittest
{
    // given
    static class MyException : Exception
    {
        this()
        {
            super("fooo");
        }
    }

    immutable val = unexpected!int(new Exception(""));

    // when
    immutable result = val.recover!(function int(Exception _) {
        throw new MyException;
    });

    // then
    result.hasValue.should.be == false;
    result.exception.msg.should.be == "fooo";
}
