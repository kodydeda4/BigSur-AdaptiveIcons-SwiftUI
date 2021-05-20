//
//  AppleScript.swift
//  Sapphire
//
//  Created by Kody Deda on 5/19/21.
//

import Foundation

struct AppleScript {
    static func createShellCommand(command: String, sudo: Bool = false) -> String {
        return "do shell script \"\(command)\" \(sudo ? "with administrator privileges" : "")"
    }
    
    // Run a shell command with elevated priviledges (Applescript)
    static func execute(command: String, sudo: Bool = false) -> Result<Bool, Error> {
        let data: String = "do shell script \"\(command)\" \(sudo ? "with administrator privileges" : "")"
        
        var url: URL {
            try! FileManager.default.url(
                for: .applicationScriptsDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            .appendingPathComponent("AppleScript")
            .appendingPathExtension(for: .osaScript)
        }

        
        do {
            try data.write(to: url, atomically: true, encoding: .utf8)
            try NSUserScriptTask(url: url).execute()
            return .success(true)
        }
        catch {
            return .failure(error)
        }
    }
}

