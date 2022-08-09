import UIKit

import Alamofire
import SwiftyJSON


class RequestAPIManager {
    static let shared = RequestAPIManager()
    
    private init() { }
    
    func requestTMDB(completionHandler: @escaping ([MovieInfo]) -> Void) {
        let url = "\(EndPoint.Movie.tmdbURL)day?api_key=\(APIKey.TMDB)&page=1"
        
        AF.request(url, method: .get).validate(statusCode: 200...400).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                 print("JSON: \(json)")
                
                let movieData = json["results"].arrayValue.map {
                    MovieInfo(moviePoster: URL(string: "https://image.tmdb.org/t/p/w500\($0["poster_path"].stringValue)")!, movieBack: URL(string: "https://image.tmdb.org/t/p/w500\($0["backdrop_path"].stringValue)")!)
                    }
                
                completionHandler(movieData)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestGenre(completionHandler: @escaping ([Int: String], [String]) -> Void) {
        let url = "\(EndPoint.Movie.tmdbGenreURL)?api_key=\(APIKey.TMDB)"
        
        AF.request(url, method: .get).validate(statusCode: 200...400).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                 print("JSON: \(json)")
                var genreList: [Int: String] = [:]
                
                
                for i in json["genres"].arrayValue {
                    genreList.updateValue(i["name"].stringValue, forKey: i["id"].intValue)
                }
                let genreName: [String] = json["genres"].arrayValue.map {$0["name"].stringValue}
                
                completionHandler(genreList,genreName)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
