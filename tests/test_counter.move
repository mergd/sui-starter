#[test_only]
module package_starter::counter_tests {
    use sui::test_scenario::{Self as test, next_tx, ctx};
    use sui::test_utils::assert_eq;
    use sui::clock;

    use package_starter::counter::{Counter, CounterState};
}