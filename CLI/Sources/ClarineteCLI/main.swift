import Foundation
import Clarinete
import ColorizeSwift

let client = Clarinete()

_ = client.getTrends { result in
    switch result {
    case .success(let posts):
        posts.forEach { post in
            let line = [post.name.yellow(), post.title]
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
