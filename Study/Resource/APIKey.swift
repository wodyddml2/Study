import Foundation

enum EndPoint {
    case Movie
    
    var tmdbURL: String {
        switch self {
        case .Movie:
            return URL.makeEndPoint("trending/movie/")
        }
    }
    
    var tmdbGenreURL: String {
        switch self {
        case .Movie:
            return URL.makeEndPoint("genre/movie/list")
        }
    }
}



struct APIKey {
    static let TMDB = "6524d71f25d128df02ba5cdc8d700c84"
}

