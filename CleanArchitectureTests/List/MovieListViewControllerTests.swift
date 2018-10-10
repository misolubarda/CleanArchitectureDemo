//
//  ListViewControllerTests.swift
//  CleanArchitectureTests
//
//  Created by Lubarda, Miso on 9/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import XCTest
import Nimble
@testable import CleanArchitecture
import DomainLayer

class MovieListViewControllerTests: XCTestCase {
    private var viewController: MovieListViewController!
    private var searchUseCaseFake = MovieSearchUseCaseFake()
    private var posterUseCaseFake = PosterUseCaseFake()

    override func setUp() {
        let dependencies = AppDependenciesFake()
        searchUseCaseFake.movies = (0...10).map { return Movie(number: $0) }
        dependencies.searchUseCase = searchUseCaseFake
        dependencies.posterUseCase = posterUseCaseFake
        viewController = MovieListViewController(searchTerm: "", dependencies: dependencies)
    }

    // MARK: Initialization

    func test_initWithEncoder_returnsNil() {
        let vc = MovieListViewController(coder: NSCoder())

        expect(vc).to(beNil())
    }

    func test_init_returnsAnInstance() {
        expect(self.viewController).notTo(beNil())
    }

    func test_viewDidLoad_tableViewSourceIsOfCorrectType() {
        _ = viewController.view

        expect(self.viewController.tableView.dataSource).to(beAnInstanceOf(MovieListTableDataSource.self))
    }

    // MARK: Search use case

    func test_viewDidLoad_onSearchResults_cellCountIsAccurate() {
        _ = viewController.view

        expect(self.viewController.tableView.numberOfRows(inSection: 0)).to(equal(searchUseCaseFake.movies.count))
    }

    func test_viewDidLoad_onSearchResults_firstCellHasCorrectTitle() {
        _ = viewController.view

        expect(self.firstCell.titleLabel?.text).to(equal(searchUseCaseFake.movies.first?.title))
    }

    func test_viewDidLoad_onSearchResults_firstCellHasDescription() {
        _ = viewController.view

        expect(self.firstCell.descriptionLabel?.text).to(equal(searchUseCaseFake.movies.first?.overview))
    }

    func test_viewDidLoad_onSearchResults_firstCellHasReleaseDate() {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        let expectedDateString = formatter.string(from: currentDate)
        searchUseCaseFake.movies = [Movie(posterPath: nil, title: "", release: currentDate, overview: "")]

        _ = viewController.view

        expect(self.firstCell.releaseDateLabel?.text).to(equal(expectedDateString))
    }

    // MARK: Poster use case

    func test_onSearchResults_postersAreRequested() {
        _ = viewController.view

        expect(self.posterUseCaseFake.requestCount).to(equal(1))
    }

    func test_onSearchResults_postersAreRequestedForVisibleCells() {
        _ = viewController.view

        expect(self.posterUseCaseFake.requestedPaths).to(equal(viewController.posterPathsForVisibleCells()))
    }

    func test_onSearchResults_firstCellHasPosterImageSet() {
        let firstPosterPath = searchUseCaseFake.movies.first!.posterPath!
        let imageData = Data.testImage
        posterUseCaseFake.poster = Poster(path: firstPosterPath, image: imageData)
        let expectedImage = UIImage(data: imageData)!

        _ = viewController.view

        expect(self.firstCell.posterImageView.image?.size).to(equal(expectedImage.size))
    }

    func test_scrollViewDidEndDecelerating_postersAreRequestedForVisibleCells() {
        _ = viewController.view
        posterUseCaseFake.requestedPaths = []

        viewController.scrollViewDidEndDecelerating(UIScrollView())

        expect(self.posterUseCaseFake.requestedPaths).to(equal(viewController.posterPathsForVisibleCells()))
    }

    func test_scrollViewDidEndDragging_postersAreRequestedForVisibleCells() {
        _ = viewController.view
        posterUseCaseFake.requestedPaths = []

        viewController.scrollViewDidEndDragging(UIScrollView(), willDecelerate: false)

        expect(self.posterUseCaseFake.requestedPaths).to(equal(viewController.posterPathsForVisibleCells()))
    }
}

extension MovieListViewControllerTests {
    var firstCell: MovieCell {
        return viewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MovieCell
    }
}

private extension MovieListViewController {
    func posterPathsForVisibleCells() -> [String] {
        let visibleCells = tableView.visibleCells as! [MovieCell]
        return visibleCells.compactMap { $0.posterPath }
    }
}

private extension Data {
    static var testImage: Data {
        let url = Bundle(for: PosterUseCaseFake.self).url(forResource: "testImage", withExtension: "png")!
        return try! Data(contentsOf: url)
    }
}
