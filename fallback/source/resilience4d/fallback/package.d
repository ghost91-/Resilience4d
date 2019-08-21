module resilience4d.fallback;

public import expectations;
import std.traits : isSomeFunction, Parameters, ReturnType;

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
@safe pure unittest
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

private enum isTemplateCallableWith(alias func, U, V) = __traits(isTemplate, func)
    && __traits(compiles, { U u = func(V.init); });

private enum isInSameClassHierarchyAs(T, U) = is(T : U) || is(U : T);

auto recover(alias func, T)(Expected!T self)
        if (isTemplateCallableWith!(func, T, Exception) || (isSomeFunction!func
            && is(ReturnType!func : T) && isInSameClassHierarchyAs!(Parameters!func, Exception)))
{
    if (self.hasValue)
    {
        return self;
    }
    else
    {
        static if (isTemplateCallableWith!(func, T, Exception))
        {
            return attempt!func(self.exception);
        }
        else
        {
            alias Param = Parameters!func[0];
            auto castedException = cast(Param) self.exception;
            if (castedException !is null)
            {
                return attempt!func(castedException);
            }
            else
            {
                return self;
            }
        }
    }
}

///
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

    static class AnotherException : Exception
    {
        this()
        {
            super("");
        }
    }

    immutable val = unexpected!int(new MyException);

    // when
    immutable result = val.recover!(function int(MyException _) {
        throw new AnotherException;
    })
        .recover!((AnotherException _) => 1)
        .recover!((Exception _) => 2);

    // then
    result.hasValue.should.be == true;
    result.value.should.be == 1;
}
