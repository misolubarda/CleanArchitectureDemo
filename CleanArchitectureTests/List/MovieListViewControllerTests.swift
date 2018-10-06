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

    override func setUp() {
        let dependencies = AppDependenciesFake()
        dependencies.searchUseCase = searchUseCaseFake
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

    // MARK: Search

    func test_viewDidLoad_onSearchResults_cellCountIsAccurate() {
        let moviesRange = (0...10)
        searchUseCaseFake.movies = moviesRange.map { return Movie(number: $0) }

        _ = viewController.view

        expect(self.viewController.tableView.numberOfRows(inSection: 0)).to(equal(moviesRange.count))
    }

    func test_viewDidLoad_onSearchResults_firstCellHasCorrectTitle() {
        let moviesRange = (0...10)
        searchUseCaseFake.movies = moviesRange.map { return Movie(number: $0) }

        _ = viewController.view

        expect(self.firstCell.titleLabel?.text).to(equal(searchUseCaseFake.movies.first?.title))
    }

    func test_viewDidLoad_onSearchResults_firstCellHasDescription() {
        let moviesRange = (0...10)
        searchUseCaseFake.movies = moviesRange.map { return Movie(number: $0) }

        _ = viewController.view

        expect(self.firstCell.descriptionLabel?.text).to(equal(searchUseCaseFake.movies.first?.overview))
    }
}

extension MovieListViewControllerTests {
    var firstCell: MovieCell {
        return viewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MovieCell
    }
}
