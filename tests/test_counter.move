#[test_only]
module package_starter::counter_tests {
    use sui::test_scenario::{Self, next_tx, ctx};
    use sui::test_utils::assert_eq;
    use sui::clock;
    use sui::test_utils;

    use package_starter::counter::{Self, Counter};

    #[test]
    fun test_increment() {
        let addr1 = @0xA;
        let addr2 = @0xB;

        let scenario = test_scenario::begin(addr1);    
        let clock = clock::create_for_testing(ctx(scenario));

        {
            // Deploy
            counter::init(&mut scenario);
        };

        next_tx(&mut scenario, addr2);
        {
            let counter = test_scenario::take_shared<Counter>(&scenario);
            
            // Increment
            counter::increment(&mut counter, &clock, &mut scenario);
            let value = counter::get_value(&counter);
            test_utils::assert_eq(value, 2);
        };

        // Cleans up the scenario object
        test_scenario::end(scenario);


    }



    
}