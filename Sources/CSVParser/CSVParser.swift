//
//  CSVParser.swift
//
//
//  Created by hoseung Lee on 2022/05/20.
//

import Foundation

public protocol CSVParserInterface {
  func parseBundle(_ bundlePath: String) throws -> [[String]]
}

final public class CSVParser: CSVParserInterface {
  public init() {}

  func fetchBundleData(_ bundlePath: String) throws -> Data {

    let url = URL(fileURLWithPath: bundlePath)

    do {
      let data = try Data(contentsOf: url)
      return data
    } catch let error {
      throw error
    }
  }

  func parseData(_ data: Data) throws -> [[String]] {

    guard let string = String(data: data, encoding: .utf8) else {
      throw NSError(domain: "invalid encoding type, converter encoding type is utf8", code: -1)
    }

    return separatorComma(string)
  }

  public func parseBundle(_ bundlePath: String) throws -> [[String]] {
    do {
      let data = try fetchBundleData(bundlePath)
      let convertedData = try parseData(data)
      return convertedData
    } catch let error {
      throw error
    }
  }

  private func separatorComma(_ plainCsv: String) -> [[String]] {
    let replacedLineCharacter = plainCsv.replacingOccurrences(of: "\r\n", with: "\n")
    return replacedLineCharacter.components(separatedBy: "\n").map{$0.components(separatedBy: ",")}.filter { $0.count == 2 }
  }
}
