//
//  File.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import Foundation

final class Client {
    
    enum Endpoints {
        static let apiKey = "?key=e0fcafafefb247c8b8ab3f5dd5d8d3ae"
        static let base = "https://api.rawg.io/api/"
        static let selectedGameBaseUrl = Endpoints.base + "games/"
        static let gamesBaseUrl = Endpoints.base + "games\(Endpoints.apiKey)"
        
        case allGames
        case orderingGamesNames //Bu case'de bir sayfa sayısı bekliyorum.
        case orderingGamesRelaesed
        case orderingGamesRating
        case gamesPage(String)
        case selectedGame(Int)
        
        var stringValue: String {
            switch self {
            case .allGames:
                return Endpoints.gamesBaseUrl
            case .orderingGamesNames:
                return Endpoints.gamesBaseUrl
            case .orderingGamesRelaesed:
                return Endpoints.gamesBaseUrl + "&ordering=released"
            case .orderingGamesRating:
                return Endpoints.gamesBaseUrl + "&ordering=-rating"
            case .gamesPage(let page):
                return Endpoints.gamesBaseUrl + "&ordering=name&page_size=\(page)"
            case .selectedGame(let id):
                return Endpoints.selectedGameBaseUrl + "\(id)" + Endpoints.apiKey
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    @discardableResult
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(BaseResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        return task
    }
    
    class func getGames(completion: @escaping ([GameModel]?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.orderingGamesNames.url, responseType: GetGamesResponseModel.self) { response, error in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    
    class func getGamesOrderingReleased(completion: @escaping ([GameModel]?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.orderingGamesRelaesed.url, responseType: GetGamesResponseModel.self) { response, error in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func getGamesOrderingRating(completion: @escaping ([GameModel]?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.orderingGamesRating.url, responseType: GetGamesResponseModel.self) { response, error in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}

