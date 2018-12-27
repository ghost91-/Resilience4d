module resilience4d.fallback;

public import expectations;

version (RESILIENCE4D_UNITTEST)
{
    import unit_threaded;
}

template attempt(alias func)
{
    auto attempt(Args...)(Args args) if (__traits(compiles, { func(args); }))
    {
        try
        {
            return expected(func(args));
        }
        catch (Exception e)
        {
            return unexpected!(typeof(func(args)))(e);
        }
    }
}

///
unittest
{
    // given
    alias attemptDivide = attempt!((x, y) {
        if (y == 0)
            throw new Exception("Division by zero");
        return x / y;
    });

    // when
    immutable succesfulResult = attemptDivide(10, 2);
    immutable failedResult = attemptDivide(1, 0);

    // then
    succesfulResult.hasValue.should.be == true;
    succesfulResult.value.should.be == 5;
    failedResult.hasValue.should.be == false;
    failedResult.exception.msg.should.be == "Division by zero";

}

private template isImplicitlyConvertableInSomeDirection(T, U)
{
    enum isImplicitlyConvertableInSomeDirection = is(T : U) || is(U : T);
}

private template isCallableWith(alias func, U, V)
{
    enum isCallableWith = __traits(compiles, { U u = func(V.init); });
}

template recover(alias func)
{
    import std.traits : isSomeFunction, Parameters, ReturnType;

    auto recover(T)(Expected!T self)
            if ((isSomeFunction!func && is(ReturnType!func : T)
                && isImplicitlyConvertableInSomeDirection!(Exception, Parameters!func))
                || isCallableWith!(func, T, Exception))
    {

        if (!self.hasValue)
        {
            static if (isSomeFunction!func)
            {
                alias Param = Parameters!func[0];
                static if (is(Exception : Param))
                {
                    return expected(func(self.exception));
                }
                else
                {
                    if (typeid(self.exception) == typeid(Param))
                    {
                        return expected(func(cast(Param) self.exception));
                    }
                }
            }
            else
            {
                return expected(func(self.exception));
            }
        }

        return self;
    }
}

///
unittest
{
    // given
    class MyException : Exception
    {
        this()
        {
            super("");
        }
    }

    class AnotherException : Exception
    {
        this()
        {
            super("");
        }
    }

    immutable val = unexpected!int(new AnotherException);

    // when
    immutable result = val.recover!((MyException x) => 0)
        .recover!((AnotherException x) => 1)
        .recover!((Exception x) => 2);

    // then
    result.hasValue.should.be == true;
    result.value.should.be == 1;
}
