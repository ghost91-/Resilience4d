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
