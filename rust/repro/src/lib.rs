use log::debug;

pub fn print_hello() -> Result<(), Box<dyn std::error::Error>> {
    debug!("printing hello!");
    println!("hello world!");
    Ok(())
}
