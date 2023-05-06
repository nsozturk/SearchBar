//
//  SearhViewController.swift
//  SearchBar
//
//  Created by enes ozturk on 6.05.2023.
//

import UIKit

class SearhViewController: UIViewController {
    private var Movies = [Title]()

    private var SearchBar: UISearchController = {
        let sb = UISearchController()
        sb.searchBar.placeholder = "Enter the movie name"
        sb.searchBar.searchBarStyle = .minimal
        return sb
    }()

    private var MovieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.ID)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray

        navigationItem.title = "Movie Search"
        view.backgroundColor = .systemBackground
        SearchBar.searchResultsUpdater = self
        navigationItem.searchController = SearchBar
        view.addSubview(MovieCollectionView)
        MovieCollectionView.delegate = self
        MovieCollectionView.dataSource = self
        configureUI()
        navigationItem.hidesSearchBarWhenScrolling = true
    }

    func configureUI() {
        MovieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        MovieCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        MovieCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        MovieCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        MovieCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension SearhViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        APIService.shared.getMovies(for: query.trimmingCharacters(in: .whitespaces)) { titles, _ in
            if let titles = titles {
                self.Movies = titles
                DispatchQueue.main.async {
                    self.MovieCollectionView.reloadData()
                }
            }
        }
    }
}

extension SearhViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.ID, for: indexPath) as? MovieCell {
            cell.updateCell(posterURL: Movies[indexPath.row].poster_path)
            return cell
        }
        return UICollectionViewCell()
    }
}
