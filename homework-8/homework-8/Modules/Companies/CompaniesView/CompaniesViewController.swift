//
//  CompaniesViewController.swift
//  homework-8
//
//  Created by Admin on 04.12.2020.
//

import UIKit

protocol ICompaniesViewController: AnyObject {
    func updateAddingData()
    func updateDeletedData(at index: Int)
    
    func reloadData(at index: Int)
    func reloadData()
}

final class CompaniesViewController: UIViewController {
    // MARK: Properties
    
    var presenter: ICompaniesPresenter?
    
    private var companiesView: CompaniesView {
        guard let view = view as? CompaniesView else {
            fatalError("view is not a CompaniesView instance")
        }
        
        return view
    }
    
    // MARK: Lifecycle
    
    override func loadView() {
        view = CompaniesView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        setupCompaniesView()
        setupButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.viewDidAppear()
    }
}

// MARK: - ICompaniesViewController

extension CompaniesViewController: ICompaniesViewController {
    func updateAddingData() {
        companiesView.insertNewRow()
    }
    
    func updateDeletedData(at index: Int) {
        companiesView.deleteRow(at: index)
    }
    
    func reloadData(at index: Int) {
        companiesView.reloadRow(at: index)
    }
    
    func reloadData() {
        func reloadData() {
            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: { [weak self] in
                self?.companiesView.reloadData()
            }, completion: nil)
        }
    }
}

// MARK: - Private Methods

private extension CompaniesViewController {
    func setupAppearance() {
        navigationItem.title = "Companies"
    }
    
    func setupCompaniesView() {
        companiesView.tableViewDataSource = self
        companiesView.tableViewDelegate = self
    }
}

// MARK: - Buttons

private extension CompaniesViewController {
    func setupButtons() {
        setupAddButton()
    }
    
    func setupAddButton() {
        let addBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didPressAddButton)
        )
        
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
}

// MARK: - Actions

extension CompaniesViewController {
    @objc func didPressAddButton() {
        presenter?.didPressAddButton()
    }
}

// MARK: - UITableViewDataSource

extension CompaniesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CompanyCell.reuseIdentifier,
            for: indexPath
        ) as? CompanyCell else { return UITableViewCell() }

        if let company = presenter?.get(at: indexPath.row) {
            cell.configure(with: company)
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension CompaniesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(at: indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completionHandler in
            self?.presenter?.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }

        delete.image = UIImage.init(systemName: "trash")

        return UISwipeActionsConfiguration(actions: [delete])
    }
}
