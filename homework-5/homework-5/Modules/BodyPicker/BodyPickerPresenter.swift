//
//  BodyPickerPresenter.swift
//  homework-5
//
//  Created by Admin on 12.11.2020.
//

protocol IBodyPickerPresenter: AnyObject {
    func viewDidLoad(view: IBodyPickerView)
    
    func didPressResetButton()
}

final class BodyPickerPresenter {
    weak var view: IBodyPickerViewController?
    var interactor: IBodyPickerInteractor?
    var router: IBodyPickerRouter?
    
    weak var delegate: BodyPickerViewControllerDelegate?
    
    private var selectedBody: Body?
}

// MARK: - IBodyPickerPresenter

extension BodyPickerPresenter: IBodyPickerPresenter {
    // MARK: Lifecycle
    
    func viewDidLoad(view: IBodyPickerView) {
        view.selectedBody = selectedBody
        
        view.didSelectBody = { [weak self] body in
            self?.didSelectBody(body)
        }
    }
    
    // MARK: Actions
    
    func didPressResetButton() {
        delegate?.bodyPickerViewControllerDelegate(self, didSelect: nil)
        
        router?.closeBodyPickerView()
    }
}

// MARK: - Private Methods

private extension BodyPickerPresenter {
    func didSelectBody(_ body: Body?) {
        delegate?.bodyPickerViewControllerDelegate(self, didSelect: body)
        
        router?.closeBodyPickerView()
    }
}

// MARK: - IBodyPickerInteractorOutput

extension BodyPickerPresenter: IBodyPickerInteractorOutput {
    func bodyReceived(_ body: Body?) {
        selectedBody = body
    }
}
