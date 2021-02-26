//
//  Created by Ricardo Santos on 19/08/2020.
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

public extension Publisher {
    var genericError: AnyPublisher<Self.Output, Error> {
        mapError({ (error: Self.Failure) -> Error in return error }).eraseToAnyPublisher()
    }
    
    var underlyingError: Publishers.MapError<Self, Failure> {
        mapError {
            ($0.underlyingError as? Failure) ?? $0
        }
    }
}
