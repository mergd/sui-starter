module package_starter::counter{
    use sui::clock::{Self, Clock};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use sui::event;
    use sui::object::{Self, UID};


    const E_YOU_JUST_WENT: u64 = 1;

    struct Counter has key{
        id: UID,
        value: u32,
        currentIncrementer: address,
        lastIncremented: u64
    }

    struct CounterEvent has copy, drop {
        value: u32,
        currentIncrementer: address,
        lastIncremented: u64
    }

    fun init( ctx: &mut TxContext) {
        transfer::share_object(
            Counter{
                id: object::new(ctx),
                value: 1,
                currentIncrementer: tx_context::sender(ctx),
                lastIncremented: 0
            },
        )
    }


    public entry fun increment(self: &mut Counter, clock: &Clock, ctx: &mut TxContext) {
        assert!(self.currentIncrementer == tx_context::sender(ctx), E_YOU_JUST_WENT);
        self.value = self.value + 1;
        self.currentIncrementer = tx_context::sender(ctx);
        self.lastIncremented = clock::timestamp_ms(clock);

        event::emit(CounterEvent{
            value: self.value,
            currentIncrementer: self.currentIncrementer,
            lastIncremented: self.lastIncremented
        });
    }

    public fun get_value(self: &Counter): u32 {
        self.value
    }
}

