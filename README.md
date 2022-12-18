# swiftup
***
swiftup is a command-line tool written in Swift that allows you to check the reachability of URLs in all the Swift files and packages within a directory, including any nested directories. 

This tool is useful for verifying that the URLs referenced in your code are valid and accessible.
***


## Installation

### Prerequisites
- [Swift](https://www.swift.org/download/)

### Installation Steps
1. Clone the repository:

```
git clone https://github.com/ishaanbedi/swiftup.git
```

2. Navigate to the repository directory:

```
cd swiftup
```

3. Compile and install the tool:
```
swift build -c release
```
4. Move the binary file to a directory included in the system path:
```
mv .build/release/swiftup /usr/local/bin/swiftup
```

On macOS, the `/usr/local/bin` directory is typically included in the default system path. 

On Linux, the recommended directory for system executables is `/usr/bin`.

After moving the binary file to a directory that is included in your system path, you can use the `swiftup` command from any directory on your system. 

You may need to restart your terminal or log out and log back in for the changes to take effect.

### Install using a single command
To install `swiftup`, compile the tool, and include it in the system path in a single command, run the following:

```
git clone https://github.com/ishaanbedi/swiftup.git && cd swiftup && swift build -c release;
sudo mv .build/release/swiftup /usr/local/bin/swiftup
```
To fix the `permission denied` error when executing the mv command, I've combined it with `sudo` command to give the installation process superuser privileges. 

If prompted for a password at this step, please enter the password for your user account on the machine.

On macOS, this will clone the repository, navigate to the repository directory, compile and install the tool, and move the binary file to the `/usr/local/bin` directory, which is included in the default system path.

On Linux, the command will be similar, but the binary file will be moved to the `/usr/bin` directory instead.



## Usage
```
swiftup [-s START] [-h] [-v]
```

## Options
- `-s START, --start START`: Start the processing of all files in the current directory
- `-h, --help`: Show this help message and exit
- `-v, --verbose`: Enable verbose output

## Examples
To check the reachability of URLs in all files in the current directory:

```
swiftup
```
To check the reachability of URLs in all files in a specific directory:

```
swiftup -s /path/to/directory
```

Enabling verbose output will cause the tool to print more detailed information about the URLs it is checking and their reachability status. This can be helpful if you are trying to troubleshoot why a particular URL is not being reached, or if you simply want more insight into how the tool is functioning.

To enable verbose output, you can use the `-v` or `--verbose` flag when running the swiftup command. 

For example:

```
swiftup -v
```

### Demo
Check out this short demo of `swiftup` in action:

![My Movie (1)](https://user-images.githubusercontent.com/39641326/208293712-72221e82-9173-4d41-9004-c63d48a499cb.gif)



## Note
Please note that `swiftup` is a tool that only checks the reachability of URLs and does not validate their content or replaces any occurrences of the URL. 

It is the responsibility of the end-user developer or user to ensure that any unreachable URLs reported by the tool are corrected and points to the intended resources. 

`swiftup` simply provides a way to identify and flag any URLs with possible reasons, that are not reachable, and it is up to the user or developer to take the necessary steps to address any issues arising.

### License
This project is licensed under the MIT license.


