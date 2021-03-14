//
//  LineReader.swift
//
//  Copied from stackoverflow
//  https://stackoverflow.com/questions/24581517/read-a-file-url-line-by-line-in-swift/24648951#24648951
//
//  Credit: https://github.com/andrewwoz/LineReader
//

import Foundation

/// Read text file line by line in efficient way
public class LineReader {
   public let path: String

   fileprivate let file: UnsafeMutablePointer<FILE>!

   init?(path: String) {
        self.path = path
        file = fopen(path, "r")
        guard file != nil else { return nil }
   }

   public var nextLine: String? {
        var line:UnsafeMutablePointer<CChar>? = nil
        var linecap:Int = 0
        defer { free(line) }
    let word =  getline(&line, &linecap, file) > 0 ? String(cString: line!) : nil
    
        if word?.hasSuffix("\n") ?? false {
            return String(word!.dropLast())
        } else {
            return word
        }
   }

   deinit {
        fclose(file)
   }
}

extension LineReader: Sequence {
    public func  makeIterator() -> AnyIterator<String> {
        return AnyIterator<String> {
            return self.nextLine
        }
    }
}
