module resilience4d.fallback;

public import expectations;

version (RESILIENCE4D_UNITTEST)
{
    import fluent.asserts;
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
    auto succesfulResult = attemptDivide(10, 2);
    auto failedResult = attemptDivide(1, 0);

    // then
    succesfulResult.hasValue.should.equal(true);
    succesfulResult.value.should.equal(5);
    failedResult.hasValue.should.equal(false);
    failedResult.exception.msg.should.equal("Division by zero");

}
