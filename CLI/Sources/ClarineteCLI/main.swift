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

guard let url = URL(string: apiHost) else {
    fatalError("Invalid Host URL")
}

let configuration = Configuration(host: url)

Task.init {
    do {
        let client = try Clarinete(configuration: configuration)
        let trends = try await client.getTrends()

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

    } catch {
        print("ERROR: \(error.localizedDescription)")
        exit(EXIT_FAILURE)
    }
}

dispatchMain()
