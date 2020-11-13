//
//  CarsViewProtocol.swift
//  homework-5
//
//  Created by Admin on 13.11.2020.
//

import UIKit

protocol CarsViewProtocol: AnyObject {
    var dataSource: UITableViewDataSource? { get set }
    var delegate: UITableViewDelegate? { get set }
 
    func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String)
    
    func selectRow(at indexPath: IndexPath?, animated: Bool, scrollPosition: UITableView.ScrollPosition)
    func deselectRow(at indexPath: IndexPath, animated: Bool)
    
    func insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation)
    func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation)
    func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation)
    
    func reloadData()
}
