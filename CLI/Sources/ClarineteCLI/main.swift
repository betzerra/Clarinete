import ArgumentParser
import Foundation
import Clarinete
import ColorizeSwift

struct CLIOptions: ParsableCommand {
    @Option(name: .shortAndLong, help: "Host for Clarinete API")
    var host: String?
}

let options = CLIOptions.parseOrExit()
let apiHost = options.host ?? "https://clarinetecache.apps.betzerra.dev"

guard let url = URL(string: apiHost) else {
    fatalError("Invalid Host URL")
}

let configuration = Configuration(host: url)

Task.init {
    do {
        let client = try Clarinete(configuration: configuration)
        let trends = try await client.getTrends()

        for trend in trends {
            guard let summary = trend.posts.first else {
                print(trend.name.yellow())
                print("\n")
                return
            }

            let count = trend.posts.count > 1 ? "(\(trend.posts.count))" : nil

            let line = [
                trend.name.yellow(),
                count?.yellow(),
                summary.category?.rawValue.capitalized.red(),
                summary.title
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
