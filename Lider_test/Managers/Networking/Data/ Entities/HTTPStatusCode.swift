//
//  HTTPStatusCode.swift
//  Trip
//
//  Created by rodoolfo gonzalez on 04-01-24.
//

import Foundation

public enum HTTPStatusCode: Int{
    case switchingProtocols = 101
    case processing = 102
    case oK = 200
    case created = 201
    case accepted = 202
    case nonAuthoritativeInformation = 203
    case noContent = 204
    case resetContent = 205
    case partialContennt = 206
    case multiStatus = 207
    case alreadyReported = 208
    case imUsed = 226
    case multipleChoices = 300
    case movedPermanently = 301
    case found = 302
    case seeOther = 303
    case notModified = 304
    case useProxy = 305
    case switchProxy = 306
    case temporaryRedirect = 307
    case permanentRedirect = 308
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case notAcceptable = 406
    case proxyAuthenticationRequired = 407
    case requestTimeout = 408
    case conflict = 409
    case gone = 410
    case lenghtRequired = 411
    case preconditionFailed = 412
    case requestEntityTooLarge = 413
    case requestUrlTooLong = 414
    case unsuppportedMediaType = 415
    case requestedRangeNotSatisfiable = 416
    case expectationFailed = 417
    case imATeapot = 418
    case enhanceYourCalm = 420
    case unprocessableEntity = 422
    case locked = 423
    case failedDependency = 424
    case unorderedCollection = 425
    case upgradeRequired = 426
    case preconditionRequired = 428
    case tooManyRequest = 429
    case requestHeaderFieldsTooLarge = 431
    case noResponse = 444
    case retryWith = 449
    case blockedByWindowsParentalControls = 450
    case clientClosedRequest = 499
    case internalServerError = 500
    case notImplemented = 501
    case badGetaway = 502
    case serviceUnavailable = 503
    case getawayTimeout = 504
    case httpVersionNotSupported = 505
    case variantAlsoNegotiates = 506
    case insuficientStorage = 507
    case bandWidthLimitExceeded = 509
    case notExtended = 510
}
