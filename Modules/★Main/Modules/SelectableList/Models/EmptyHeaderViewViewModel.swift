import Constants
import Foundation
import UIComponents
import UIKit

public struct EmptyHeaderViewModel: Hashable, ConfigurableCollectionViewSectionModel {
    public var id: String = ""

    public var viewSectionType: String {
        NSStringFromClass(EmptyHeaderView.self)
    }
}
