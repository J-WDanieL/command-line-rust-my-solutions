use std::error::Error;
use clap::Parser;
use std::fs::File;
use std::io::{self, BufRead,BufReader};

#[derive(Parser, Debug)]
#[command(version, about, long_about = "Concatenate FILE(s) to standard output.")]
pub struct Config {
    /// 
    #[arg(default_value = "-")]
    files: Vec<String>,

    /// Number all output lines
    #[arg(short = 'n', long = "number", conflicts_with = "number_nonblank_lines")]
    number_lines: bool,

    /// Number nonempty output lines
    #[arg(short = 'b', long = "number-nonblank")]
    number_nonblank_lines: bool,

    /// Display $ at end of each line
    #[arg(short = 'E', long = "show-ends")]
    show_ends: bool,

    /// Display TAB characters as ^I
    #[arg(short = 'T', long = "show-tabs")]
    show_tabs: bool,
}

type MyResult<T> = Result<T, Box<dyn Error>>;


pub fn get_args() -> MyResult<Config> {
    Ok(Config::parse())
}

fn open(filename: &str) -> MyResult<Box<dyn BufRead>> {
    match filename {
        "-" => Ok(Box::new(BufReader::new(io::stdin()))),
        _ => Ok(Box::new(BufReader::new(File::open(filename)?))),
    }
}

pub fn run(config: Config) -> MyResult<()> {
    // dbg!(config);

    let mut line_num = 0;
    for filename in config.files {
        match open(&filename) {
            Err(err) => eprintln!("Failed to open {filename}: {err}"),
            Ok(file) => {
                for line in file.lines() {
                    let mut line = line?;
                    let is_blank = line.trim().is_empty();

                    // replace nonprinting
                    if config.show_ends {
                        line = format!("{line}$");
                    }

                    if config.show_tabs {
                        line = line.replace('\t', "^I");
                    }

                    // print
                    if config.number_lines {
                        line_num += 1;
                        print!("{line_num:>6}\t");

                    } else if config.number_nonblank_lines && !is_blank {
                        line_num += 1;
                        print!("{line_num:>6}\t");

                    }
                    println!("{line}");

                } // for lines
            }, // Ok file
        } // match open()
    } // for files

    Ok(())
}
