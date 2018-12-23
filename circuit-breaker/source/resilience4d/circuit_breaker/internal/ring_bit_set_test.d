module resilience4d.circuit_breaker.internal.ring_bit_set_test;

import resilience4d.circuit_breaker.internal.ring_bit_set;

version (RESILIENCE4D_UNITTEST)
{
    import fluent.asserts;
}

// it is not possible to create a `RingBitSet` of size 0

unittest
{
    import core.exception : AssertError;

    // given
    immutable _size = 0;

    // then
    ({ RingBitSet(_size); }).should.throwException!AssertError;
}

// cardinality is correctly returned by `RingBitSet.setNextBit`

unittest
{
    // given
    auto underTest = RingBitSet(1);

    // when
    immutable cardinality = underTest.setNextBit(false);

    // then
    cardinality.should.equal(0);
}

unittest
{
    // given
    auto underTest = RingBitSet(1);

    // when
    immutable cardinality = underTest.setNextBit(true);

    // then
    cardinality.should.equal(1);
}

unittest
{
    // given
    auto underTest = RingBitSet(1);
    underTest.setNextBit(false);

    // when
    immutable cardinality = underTest.setNextBit(false);

    // then
    cardinality.should.equal(0);
}

unittest
{
    // given
    auto underTest = RingBitSet(1);
    underTest.setNextBit(false);

    // when
    immutable cardinality = underTest.setNextBit(true);

    // then
    cardinality.should.equal(1);
}

unittest
{
    // given
    auto underTest = RingBitSet(1);
    underTest.setNextBit(true);

    // when
    immutable cardinality = underTest.setNextBit(false);

    // then
    cardinality.should.equal(0);
}

unittest
{
    // given
    auto underTest = RingBitSet(1);
    underTest.setNextBit(true);

    // when
    immutable cardinality = underTest.setNextBit(true);

    // then
    cardinality.should.equal(1);
}

unittest
{
    // given
    auto underTest = RingBitSet(2);

    // when
    immutable cardinality = underTest.setNextBit(false);

    // then
    cardinality.should.equal(0);
}

unittest
{
    // given
    auto underTest = RingBitSet(2);

    // when
    immutable cardinality = underTest.setNextBit(true);

    // then
    cardinality.should.equal(1);
}

unittest
{
    // given
    auto underTest = RingBitSet(2);
    underTest.setNextBit(false);

    // when
    immutable cardinality = underTest.setNextBit(false);

    // then
    cardinality.should.equal(0);
}

unittest
{
    // given
    auto underTest = RingBitSet(2);
    underTest.setNextBit(false);

    // when
    immutable cardinality = underTest.setNextBit(true);

    // then
    cardinality.should.equal(1);
}

unittest
{
    // given
    auto underTest = RingBitSet(2);
    underTest.setNextBit(true);

    // when
    immutable cardinality = underTest.setNextBit(false);

    // then
    cardinality.should.equal(1);
}

unittest
{
    // given
    auto underTest = RingBitSet(2);
    underTest.setNextBit(true);

    // when
    immutable cardinality = underTest.setNextBit(true);

    // then
    cardinality.should.equal(2);
}

unittest
{
    // given
    auto underTest = RingBitSet(2);
    underTest.setNextBit(false);
    underTest.setNextBit(false);

    // when
    immutable cardinality = underTest.setNextBit(false);

    // then
    cardinality.should.equal(0);
}

unittest
{
    // given
    auto underTest = RingBitSet(2);
    underTest.setNextBit(false);
    underTest.setNextBit(false);

    // when
    immutable cardinality = underTest.setNextBit(true);

    // then
    cardinality.should.equal(1);
}

unittest
{
    // given
    auto underTest = RingBitSet(2);
    underTest.setNextBit(false);
    underTest.setNextBit(true);

    // when
    immutable cardinality = underTest.setNextBit(false);

    // then
    cardinality.should.equal(1);
}

unittest
{
    // given
    auto underTest = RingBitSet(2);
    underTest.setNextBit(false);
    underTest.setNextBit(true);

    // when
    immutable cardinality = underTest.setNextBit(true);

    // then
    cardinality.should.equal(2);
}

unittest
{
    // given
    auto underTest = RingBitSet(2);
    underTest.setNextBit(true);
    underTest.setNextBit(false);

    // when
    immutable cardinality = underTest.setNextBit(false);

    // then
    cardinality.should.equal(0);
}

unittest
{
    // given
    auto underTest = RingBitSet(2);
    underTest.setNextBit(true);
    underTest.setNextBit(false);

    // when
    immutable cardinality = underTest.setNextBit(true);

    // then
    cardinality.should.equal(1);
}

unittest
{
    // given
    auto underTest = RingBitSet(2);
    underTest.setNextBit(true);
    underTest.setNextBit(true);

    // when
    immutable cardinality = underTest.setNextBit(false);

    // then
    cardinality.should.equal(1);
}

unittest
{
    // given
    auto underTest = RingBitSet(2);
    underTest.setNextBit(true);
    underTest.setNextBit(true);

    // when
    immutable cardinality = underTest.setNextBit(true);

    // then
    cardinality.should.equal(2);
}

// length is correctly set by `RingBitSet.setNextBit`

unittest
{
    // given
    immutable underTest = RingBitSet(5);

    // when
    immutable length = underTest.length;

    // then
    length.should.equal(0);
}

unittest
{
    // given
    auto underTest = RingBitSet(5);
    underTest.setNextBit(true);
    underTest.setNextBit(true);
    underTest.setNextBit(true);
    underTest.setNextBit(true);

    // when
    immutable length = underTest.length;

    // then
    length.should.equal(4);
}

unittest
{
    // given
    auto underTest = RingBitSet(5);
    underTest.setNextBit(true);
    underTest.setNextBit(true);
    underTest.setNextBit(true);
    underTest.setNextBit(true);
    underTest.setNextBit(true);
    underTest.setNextBit(true);

    // when
    immutable length = underTest.length;

    // then
    length.should.equal(5);
}

// cardinality is correctly set by `RingBitSet.setNextBit`

unittest
{
    // given
    immutable underTest = RingBitSet(5);

    // when
    immutable cardinality = underTest.cardinality;

    // then
    cardinality.should.equal(0);
}

unittest
{
    // given
    auto underTest = RingBitSet(5);
    underTest.setNextBit(true);
    underTest.setNextBit(true);
    underTest.setNextBit(true);
    underTest.setNextBit(true);
    // when
    immutable cardinality = underTest.cardinality;

    // then
    cardinality.should.equal(4);
}

unittest
{
    // given
    auto underTest = RingBitSet(3);
    underTest.setNextBit(true);
    underTest.setNextBit(true);
    underTest.setNextBit(true);
    underTest.setNextBit(false);
    // when
    immutable cardinality = underTest.cardinality;

    // then
    cardinality.should.equal(2);
}
