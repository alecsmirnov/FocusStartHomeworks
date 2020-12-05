//
//  TableViewUpdateType.swift
//  homework-8
//
//  Created by Admin on 05.12.2020.
//

enum TableViewUpdateType {
    case insertNewRow
    case updateRow(index: Int)
    case deleteRow(index: Int)
    case none
}
