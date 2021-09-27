//
//  HomeViewModel.Swift
//  Nerdflix
//
//  Created by Natália Carolina Dos Santos on 25/09/21.
//

import Foundation
import Alamofire

class HomeViewModel {
    
    private var movies: [MovieItemModel] = []
    
    var updateLayout: (() -> Void)?
    var shoulShowErrorMessage: ((String) -> Void)?
    
    func getMoviesQuantity() -> Int {
        return movies.count
    }
    
    func getMovieAt(_ index: Int) -> MovieItemModel {
        return movies[index]
    }
    
    func getPopularMovies() {
        AF.request("https://imdb-api.com/en/API/MostPopularMovies/k_gq5a0s1w", method: .get).responseJSON { (response) in
            debugPrint("==> RESPONSE: ", response)
            guard let data = response.data else {return}
            do {
                let moviesModel = try JSONDecoder().decode(MoviesModel.self, from: data)
                self.movies = moviesModel.items ?? []
                self.updateLayout?()
            }catch (let error) {
                self.shoulShowErrorMessage?(error.localizedDescription)
            }
        }
    }
    func getTopMovies() {
        AF.request("https://imdb-api.com/en/API/Top250Movies/k_svd5ajeg", method: .get).responseJSON { (response) in }
    }
    
}
