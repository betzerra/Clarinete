import Foundation
import Clarinete
import ColorizeSwift

let client = Clarinete()

_ = client.getTrends { result in
    switch result {
    case .success(let trends):
        for trend in trends {
            guard let summary = trend.summary else {
                print(trend.name.yellow())
                print("\n")
                return
            }

            let line = [trend.name.yellow(), summary.text]
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

dispatchMain()
