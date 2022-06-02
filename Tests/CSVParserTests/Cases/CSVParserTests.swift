//
//  CSVParser.swift
//
//
//  Created by hoseung Lee on 2022/05/20.
//

import Foundation
import XCTest
@testable import CSVParser

final class CSVParserTests: XCTestCase {

  var sut: CSVParser!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = CSVParser()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func validPath() -> String {
    guard let mockCSVURL = Bundle.module.path(forResource: "NewlyCoinedWords", ofType: "csv") else {
      fatalError()
    }
    return mockCSVURL
  }

  func invalidData() -> String {
    guard let mockCSVURL = Bundle.module.path(forResource: "NewlyCoinedWordsInvalidEncoding", ofType: "csv") else {
      fatalError()
    }
    return mockCSVURL
  }

  func test_parserInit_exsit() {
    let _ = CSVParser()
  }

  func testParser_whenLoadBundlePath_makeDataOrError() {
    // Given

    // When
    do {
      let _ = try sut.fetchBundleData("")
      // Then
      XCTAssert(true)
    } catch let error {
      XCTAssert(true, error.localizedDescription)
    }
  }

  func testParser_whenValidBundlePath_makeData() {

    // Given
    let mockCSVURL = validPath()
    // When

    do {
      let _ = try sut.fetchBundleData(mockCSVURL)
      // Then
      XCTAssert(true)
    } catch let error {
      XCTAssert(false, error.localizedDescription)
    }
  }

  func testParser_whenInvalidBundlePath_throwError() {
    // Given
    let invaliePath = ""
    // When
    do {
      let _ = try sut.fetchBundleData(invaliePath)
      XCTAssert(false, "get error")
    } catch let error {
      print(error)
      XCTAssertEqual(!error.localizedDescription.isEmpty, true)
    }
    // Then
  }

  func testParserBundle_whenInvalidBundlePath_throwError() {
    // Given
    let invalidPath = ""
    // When
    do {
      let _ = try sut.parseBundle(invalidPath)
      // Then
      XCTAssert(false, "get error")
    } catch let error {
      print(error)
      XCTAssertEqual(!error.localizedDescription.isEmpty, true)
    }
  }

  func testParser_whenParsedData_resultIsString2dArray() {
    // Given
    let validPath = validPath()

    do {
      // When
      let data = try sut.fetchBundleData(validPath)
      let parsedData = try sut.parseData(data)
      if let firstResult = parsedData.first,
         firstResult.count == 2,
         firstResult[0] == "주불", firstResult[1] == "주소 불러의 줄임말"
      {
        XCTAssert(true)
      }
      // Then
    } catch let error {
      XCTAssert(false, error.localizedDescription)
    }
  }

  func testParser_whenInvalidEncodingData_throwError() {
    // Given
    let invalidData = invalidData()
    // When
    do {
      let data = try sut.fetchBundleData(invalidData)
      let _ = try sut.parseData(data)
      // Then
      XCTAssert(false)
    } catch let error as NSError {
      XCTAssert(error.domain == "invalid encoding type, converter encoding type is utf8")
    }
  }

  func testParser_whenInputBudnle_resultIsString2dArray() {
    // Given
    let validPath = validPath()
    do {
      // When
      let parsedData = try sut.parseBundle(validPath)
      // Then
      if let firstResult = parsedData.first,
         firstResult.count == 2,
         firstResult[0] == "주불", firstResult[1] == "주소 불러의 줄임말"
      {
        XCTAssert(true)
      } else {
        XCTAssert(false, "parsedData mush [[String]]type")
      }
    } catch let error {
      XCTAssert(false, error.localizedDescription)
    }
  }
}
