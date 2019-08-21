module resilience4d.circuit_breaker.internal.ring_bit_set;

version (RESILIENCE4D_UNITTEST)
{
    import fluent.asserts;
}

/**
 * A ring bit set which stores bits up to a maximum size of bits.
 */
struct RingBitSet
{
private:
    immutable size_t _size;
    size_t _length;
    bool[] _bitSet;
    size_t _index;
    size_t _cardinality;

public:

    /**
     * Creates a new `RingBitSet` which stores up to `size` bits.
     * Params:
     * size = The size of the created `RingBitSet`.
     */
    this(const size_t size) const nothrow pure @safe
    in(size > 0)
    {
        this._size = size;
        this._bitSet = new bool[size];
    }

    @disable this(this);

    /**
     * Sets the next bit of this `RingBitSet` to `value`.
     * Params:
     * value = The value to set the next bit to.
     *
     * Returns: The number bits in this `RingBitSet` which are set to `true`.
     */
    size_t setNextBit(const bool value) nothrow pure @nogc @safe
    {
        if (_length < _size)
            _length++;
        immutable previous = _bitSet[_index];
        _bitSet[_index] = value;
        _index = (_index + 1) % _size;
        _cardinality = _cardinality + value - previous;
        return _cardinality;
    }

    ///
    unittest
    {
        // given
        auto underTest = RingBitSet(5);
        underTest.setNextBit(true);
        underTest.setNextBit(false);
        underTest.setNextBit(false);
        underTest.setNextBit(true);
        underTest.setNextBit(true);
        underTest.setNextBit(true);

        // when
        immutable cardinality = underTest.setNextBit(true);

        // then
        cardinality.should.equal(4);
    }

    /**
     * Returns the number of different bits this `RingBitSet` can hold.
     * 
     * Returns: the number of different bits this `RingBitSet` can hold.
     */
    size_t size() const nothrow pure @safe @property
    {
        return _size;
    }

    ///
    unittest
    {
        // given
        immutable underTest = RingBitSet(5);

        // when
        immutable size = underTest.size;

        // then
        size.should.equal(5);
    }

    /**
     * Returns the number of bits in this `RingBitSet` which are already used.
     * 
     * Returns: the number of bits in this `RingBitSet` which are already used.
     */
    size_t length() const nothrow pure @nogc @safe
    {
        return _length;
    }

    ///
    unittest
    {
        // given
        auto underTest = RingBitSet(5);
        underTest.setNextBit(false);
        underTest.setNextBit(true);
        underTest.setNextBit(true);

        // when
        immutable length = underTest.length;

        // then
        length.should.equal(3);
    }

    /**
     * Returns the number of bits in this `RingBitSet` which are set to `true`.
     * 
     * Returns: the number of bits in this `RingBitSet` which are set to `true`.
     */
    size_t cardinality() const nothrow pure @nogc @safe
    {
        return _cardinality;
    }

    ///
    unittest
    {
        // given
        auto underTest = RingBitSet(5);
        underTest.setNextBit(false);
        underTest.setNextBit(true);
        underTest.setNextBit(true);

        // when
        immutable cardinality = underTest.cardinality;

        // then
        cardinality.should.equal(2);
    }
}
