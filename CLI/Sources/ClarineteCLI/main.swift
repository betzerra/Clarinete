import Foundation
import Clarinete
import ColorizeSwift

let client = Clarinete()

_ = client.getTrends { result in
    switch result {
    case .success(let trends):
        for trend in trends {
            let line = [trend.name.yellow(), trend.summary]
                .compactMap { $0 }
                .joined(separator: " - ")

            print(line)
        }
        exit(EXIT_SUCCESS)
        
    case .failure(let error):
        print("Error: \(error)")
        exit(EXIT_FAILURE)
    }
}

dispatchMain()
