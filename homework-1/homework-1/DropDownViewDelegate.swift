//
//  DropDownViewDelegate.swift
//  homework-1
//
//  Created by Admin on 15.10.2020.
//

import Foundation

protocol DropDownViewDelegate: AnyObject {
    func dropDownViewDelegate(_ view: DropDownView, itemPressedAt row: Int)
}
