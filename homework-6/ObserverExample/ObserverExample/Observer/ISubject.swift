//
//  Subject.swift
//  ObserverExample
//
//  Created by Admin on 19.11.2020.
//

protocol ISubject: AnyObject {
    func append(observer: IObserver)
    func remove(observer: IObserver)
    
    func notifyObservers()
    func notifyObservers(excluding: IObserver)
}
