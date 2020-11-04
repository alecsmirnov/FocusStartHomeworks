//
//  TableViewControllerDelegate.swift
//  homework-4
//
//  Created by Admin on 04.11.2020.
//

protocol TableViewControllerDelegate: AnyObject {
    func tableViewControllerDelegate(_ viewController: AnyObject, didSelectRecord record: Record)
}
