import Foundation

public typealias Completion<ResponseType> = (Result<ResponseType>) -> Void

public typealias UICompletionResult<ResponseType> = (UIResult<ResponseType>) -> Void
public typealias UICompletion<ResponseType> = (ResponseType) -> Void

public typealias ProgressCompletion = (_ progress: Float) -> Void
