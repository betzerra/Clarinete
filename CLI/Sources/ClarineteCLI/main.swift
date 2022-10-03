import ArgumentParser
import Foundation
import Clarinete
import ColorizeSwift

struct CLIOptions: ParsableCommand {
    @Option(name: .shortAndLong, help: "Host for Clarinete API")
    var host: String?
}

let options = CLIOptions.parseOrExit()
let apiHost = options.host ?? "https://clarinete.seppo.com.ar"
let configuration = Configuration(host: apiHost)

do {
    let client = try Clarinete(configuration: configuration)

    _ = client.getTrends { result in
        switch result {
        case .success(let trends):
            for trend in trends {
                guard let summary = trend.summary else {
                    print(trend.name.yellow())
                    print("\n")
                    return
                }

                let line = [
                    trend.name.yellow(),
                    summary.text
                ]
                    .compactMap { $0 }
                    .joined(separator: " - ")

                print(line)
                print(summary.url)
                print("\n")
            }
            exit(EXIT_SUCCESS)

        case .failure(let error):
            print("Error: \(error)")
            exit(EXIT_FAILURE)
        }
    }
} catch {
    print("Error: \(error)")
    exit(EXIT_FAILURE)
}

dispatchMain()
