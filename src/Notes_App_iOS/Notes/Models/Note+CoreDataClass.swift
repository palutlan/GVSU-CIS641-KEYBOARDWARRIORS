//
//  Note+CoreDataClass.swift
//  MyNotes
//
//  Created by Sai Palutla on 11/17/22.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    var title: String {
        return text!.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? ""
    }
    
    var desc: String {
        var lines = text!.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        lines.removeFirst()
        return "\(lastUpdated!.format()) \(lines.first ?? "")" 
    }
}
