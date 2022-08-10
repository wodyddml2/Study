import UIKit

import Alamofire
import SwiftyJSON


class RequestAPIManager {
    static let shared = RequestAPIManager()
    
    private init() { }
    
    func requestTMDB(genre: [GenreInfo],completionHandler: @escaping ([MovieInfo], [[URL]]) -> Void) {
        let url = "\(EndPoint.Movie.tmdbURL)day?api_key=\(APIKey.TMDB)&page=1"
        
        AF.request(url, method: .get).validate(statusCode: 200...400).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                 print("JSON: \(json)")
                var genreList:[[URL]] = []
                let movieData = json["results"].arrayValue.map {
                    MovieInfo(moviePoster: URL(string: "https://image.tmdb.org/t/p/w500\($0["poster_path"].stringValue)")!, movieBack: URL(string: "https://image.tmdb.org/t/p/w500\($0["backdrop_path"].stringValue)")!,
                              movieGenre: $0["genre_ids"].arrayValue.map {$0.intValue}
                    )
                    }
                
                for i in genre {
                    var list: [URL] = []
                    for s in movieData {
                        if s.movieGenre.contains(i.genreID) {
                            list.append(s.moviePoster)
                        }
                    }
                    genreList.append(list)
                    list.removeAll()
                }
                
                completionHandler(movieData, genreList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestGenre(completionHandler: @escaping ([GenreInfo]) -> Void) {
        let url = "\(EndPoint.Movie.tmdbGenreURL)?api_key=\(APIKey.TMDB)"
        
        AF.request(url, method: .get).validate(statusCode: 200...400).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                 print("JSON: \(json)")
                
                let genreList = json["genres"].arrayValue.map {
                    GenreInfo(genreID: $0["id"].intValue, genreName: $0["name"].stringValue)
                    }
                
                completionHandler(genreList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
   
  
}
