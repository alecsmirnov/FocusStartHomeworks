//
//  FavoriteSubject.swift
//  ObserverExample
//
//  Created by Admin on 19.11.2020.
//

final class Subject {
    private var observers = [IObserver]()
}

// MARK: - ISubject

extension Subject: ISubject {
    func append(observer: IObserver) {
        observers.append(observer)
    }
    
    func remove(observer: IObserver) {
        observers = observers.filter { $0 !== observer }
    }
    
    func notifyObservers() {
        observers.forEach { $0.update() }
    }
    
    func notifyObservers(excluding object: IObserver) {
        for observer in observers where observer !== object {
            observer.update()
        }
    }
}
