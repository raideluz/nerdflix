//
//  ViewController.swift
//  Nerdflix
//
//  Created by Natália Carolina Dos Santos on 25/09/21.
//

import UIKit

class ViewController: UIViewController {
    private var viewModel: HomeViewModel = HomeViewModel()
    
    @IBOutlet weak var collectionViewRealease: UICollectionView!
    @IBOutlet weak var collectionViewForYou: UICollectionView!
    @IBOutlet weak var collectionViewTop250: UICollectionView!
    @IBOutlet weak var collectionViewTopTVs: UICollectionView!
    
    @IBAction func handlerButtonSeeMore(_ sender: Any) {
        showSeeMore()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupCollections()
        bindEvents()
        viewModel.getPopularMovies()
        viewModel.getTopMovies()
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]

    }
   
    func setupCollections() {
        collectionViewForYou.dataSource = self
        collectionViewForYou.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/2)-40, height: 260)
        collectionViewForYou.setCollectionViewLayout(layout, animated: true)
        collectionViewForYou.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
    }
    func bindEvents() {
        viewModel.updateLayout = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionViewForYou.reloadData()
            }
        }
        
    }
    
    private func showSeeMore() {
        let controller = MoviesSeeMoreViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showDetails() {
        let controller = MoviesDetailsViewController()
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
}
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.getMovieAt(indexPath.item)
        let movieId = item.id
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getMoviesQuantity()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.getMovieAt(indexPath.item)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell.init(frame: .zero)
        }
        cell.setupModel(item)
        return cell
    }
}

