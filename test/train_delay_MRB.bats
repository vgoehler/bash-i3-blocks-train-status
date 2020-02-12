#!/usr/bin/env bats

SUT="$BATS_TEST_DIRNAME/../train_delay_MRB.sh"
EXAMPLE_DIR="$BATS_TEST_DIRNAME/example"

@test "do not accept only one parameter" {
    run "$SUT" -h
    [ "$status" -eq 255 ]
}

@test "do not accept more then two parameters" {
    run "$SUT" -fu -bar -kaching
    [ "$status" -eq 255 ]
}

@test "if not a correct input file is given echo error" {
    run "$SUT" -fu -bar
    [ "$status" -eq 25 ]
    [ "$output" = "FILE -fu NOT FOUND" ]
}

@test "parse from akutmeldungen files correctly" {
    run "$SUT" "$EXAMPLE_DIR/re3_akut" "$EXAMPLE_DIR/rb30_akut"
    echo "$output"
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "<span weight='bold'>RE3:</span><span font='FontAwesome' color='#FF0080'></span> <span weight='bold'>RB30:</span><span font='FontAwesome' color='#FF0080'></span>" ]
    [ "${lines[1]}" = "<span font='FontAwesome' color='#FF0080'></span> <span font='FontAwesome' color='#FF0080'></span>" ]
}

@test "parse from okay files correctly" {
    run "$SUT" "$EXAMPLE_DIR/re3_okay_12.02.20" "$EXAMPLE_DIR/rb30_okay"
    echo "$output"
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "<span weight='bold'>RE3:</span><span font='FontAwesome' color='#0080FF'></span> <span weight='bold'>RB30:</span><span font='FontAwesome' color='#0080FF'></span>" ]
    [ "${lines[1]}" = "<span font='FontAwesome' color='#0080FF'></span> <span font='FontAwesome' color='#0080FF'></span>" ]
}
