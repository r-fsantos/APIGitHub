//: [Previous](@previous)

import Foundation
import Alamofire

struct Developer: Codable {
    var id: Int
    var name: String
    var login: String
    var url: String
    var bio: String
    var avatar_url: String
}

enum APIError: Error {
    case urlInvalid
    case requestError
}


class Service {

    let url = "https://run.mocky.io/v3/6f096793-d0e2-46ac-ab99-775063b51c13"
    
    func get(completion: @escaping (Result<Developer, APIError>) -> Void) {
        guard let url = URL(string: url) else { return completion(.failure(.urlInvalid))}

        AF.request(url, method: .get).validate().responseDecodable(of: Developer.self) { response in
            print(response)
            guard let developers = response.value else { return completion(.failure(.requestError)) }
            
            completion(.success(developers))
        }
    }
}

var devs: Developer

Service().get { result in
    switch result {
    case .success(let res):
        (res)
    case .failure(let error):
        print(error)
    }
}
