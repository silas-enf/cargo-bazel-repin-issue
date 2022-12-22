use repro::print_hello;

#[test]
fn print_hello_does_not_error() {
    assert!(print_hello().is_ok());
}
