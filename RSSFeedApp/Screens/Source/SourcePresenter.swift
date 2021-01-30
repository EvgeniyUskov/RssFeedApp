import Foundation

//MARK: Protocols
public protocol SourcePresenterProtocol: AnyObject {
    func presentData(with source: RssSource)
    func saveSource(with viewModel: SourceViewModel, completionHandler: @escaping () -> ())
}

//MARK: Source prsenter
public class SourcePresenter {
    //MARK: Properties
    weak var viewController: SourceViewControllerProtocol?
    var interactor: SourceInteractorProtocol?
    
    //MARK: Init methods
    public init(viewController: SourceViewControllerProtocol) {
        self.viewController = viewController
    }
}

extension SourcePresenter: SourcePresenterProtocol {
    public func presentData(with source: RssSource) {
        viewController?.displayData(with: SourceViewModel(source: source))
    }
    
    public func saveSource(with viewModel: SourceViewModel, completionHandler: @escaping () -> ()) {
        interactor?.saveSource(with: viewModel.source, completionHandler: {
            completionHandler()
        })
    }
}
