import Foundation
struct Reachability {
  let domain: String
  let verbose: Bool
  init(domain: String, verbose: Bool = false) {
    self.domain = domain
    self.verbose = verbose
  }
  func isReachable() -> Bool {
    let semaphore = DispatchSemaphore(value: 0)
    var isReachable = false
    var localResponse: HTTPURLResponse?
    var error: Error?
    let domain = self.domain.replacingOccurrences(of: "http://", with: "")
      .replacingOccurrences(of: "https://", with: "")
    let url = URL(string: "http://\(domain)")!
    let task = URLSession.shared.dataTask(with: url) { data, response, err in
      localResponse = response as? HTTPURLResponse
      if let err = err {
        error = err
      } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
        isReachable = true
      }
      semaphore.signal()
    }
    task.resume()
    semaphore.wait()
    print("\n")
    print("\u{001B}[1mURL:\u{001B}[0m \(url)")
    isReachable
      ? print("\u{001B}[1;32mREACHABLE\u{001B}[0;0m")
      : print("\u{001B}[1;31mUNREACHABLE\u{001B}[0;0m")
    if let response = localResponse {
      if verbose {
        print("\u{001B}[1mStatus Code:\u{001B}[0m \(response.statusCode)")
      }
    }
    if let error = error {
      if verbose {
        print("\u{001B}[1mReason:\u{001B}[0m \(error.localizedDescription)")
      }
    }
    return isReachable
  }
}
func executeOutput(verbose: Bool) throws {
    print("\n\u{001B}[1;32mSwiftup:\u{001B}[0;0m Check reachability of URLs in files. (v1.0.0)")

  if verbose {
    print("\n\u{001B}[1mVerbose Mode Enabled\u{001B}[0m")
  }
  let currentDirectory = FileManager.default.currentDirectoryPath
  let fileManager = FileManager.default
  let enumerator = fileManager.enumerator(atPath: currentDirectory)
  var swiftFiles: [String] = []
  while let element = enumerator?.nextObject() as? String {
    if element.hasSuffix(".swift") {
      swiftFiles.append(element)
    }
  }
  var urls: [URL] = []
  var reachableURLs: [URL] = []
  var unReachableURLs: [URL] = []
  let urlPattern =
    "https?:\\/\\/(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{1,256}\\.[a-zA-Z0-9()]{1,6}\\b([-a-zA-Z0-9()@:%_\\+.~#?&//=]*)"
  let urlRegex = try NSRegularExpression(pattern: urlPattern)
  for swiftFile in swiftFiles {
    let fileContents = try String(contentsOfFile: swiftFile)
    let matches = urlRegex.matches(
      in: fileContents, range: NSRange(location: 0, length: fileContents.utf16.count))
    for match in matches {
      let range = match.range(at: 0)
      let startIndex = fileContents.index(fileContents.startIndex, offsetBy: range.location)
      let endIndex = fileContents.index(startIndex, offsetBy: range.length)
      let urlString = String(fileContents[startIndex..<endIndex])
      guard let url = URL(string: urlString) else { continue }
      urls.append(url)
    }
  }
  for url in urls {
    let Reachability = Reachability(
      domain: url.absoluteString, verbose: verbose)
    if Reachability.isReachable() {
      reachableURLs.append(url)
    } else {
      unReachableURLs.append(url)
    }
  }
  if !verbose {
    print("\nTIP: Use -v or --verbose to see more details about the URLs.")
  }
}
func execute() throws {
  let args = CommandLine.arguments
  guard args.count == 2 else {
    try executeOutput(verbose: false)
    exit(1)
  }
  if args[1] == "-h" || args[1] == "--help" {
    print(
      """
      \n
      usage: swiftup [-s START] [-h] [-v]

      Check reachability of URLs in files.

      optional arguments:
      -s START, --start START
                          start the processing of all files in the current directory
      -h, --help            show this help message and exit
      -v, --verbose         enable verbose output

      """
    )
    exit(0)
  }

  let verbose = args.contains("-v") || args.contains("--verbose")
  do {
    try executeOutput(verbose: verbose)
  } catch {
    print(error.localizedDescription)
  }
}
try execute()
