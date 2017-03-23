//  ViewController.swift
//  sqLiteDB
//
//  Created by MMan on 10/19/16.
//  Copyright © 2016 MananKothari. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    var db: sqlite3?

    func filePath() -> String {
        var paths: [Any] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        var documentDir: String? = (paths[0] as? String)
        return URL(fileURLWithPath: documentDir!).appendingPathComponent("myDB.sql").absoluteString
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.openDB()
        self.createTableNamed("Faculty", withField1: "Course", withField2: "Name")
        self.insertRecord(intoTableNamed: "Faculty", field1: "Course", field1value: "CIS2840-003", field2: "Name", field2Value: "iPhone App Development")
        self.insertRecord(intoTableNamed: "Faculty", field1: "Course", field1value: "CIS2841-003", field2: "Name", field2Value: "Android App Development")
        self.getAllRows(fromTableNamed: "Faculty")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func openDB() {
        if sqlite3_open(self.filePath().utf8, db) != SQLITE_OK {
            sqlite3_close(db)
            print("myDB.sql failed to open")
        }
        else {
            print("myDB.sql successfully opened")
        }
    }

    func createTableNamed(_ tableName: String, withField1 field1: String, withField2 field2: String) {
        var err: [CChar]
        var sqlStmt: String = "CREATE TABLE IF NOT EXISTS '\(tableName)' ('\(field1)' Text PRIMARY KEY, '\(field2)' TEXT);"
        if sqlite3_exec(db, sqlStmt.utf8, nil, nil, err) != SQLITE_OK {
            sqlite3_close(db)
            print("Failed to exectue table create")
        }
    }

    func insertRecord(intoTableNamed tableName: String, field1: String, field1value field1Value: String, field2: String, field2Value: String) {
        var sqlStmt: String = "INSERT OR REPLACE INTO '\(tableName)' ('\(field1)', '\(field2)') VALUES ('\(field1Value)', '\(field2Value)');"
        var err: [CChar]
        if sqlite3_exec(db, sqlStmt.utf8, nil, nil, err) != SQLITE_OK {
            sqlite3_close(db)
            print("Error Updating Table")
        }
    }

    func getAllRows(fromTableNamed tableName: String) {
        var qryStmt: String = "SELECT * FROM \(tableName)"
        var stmt: sqlite3_stmt?
        if sqlite3_prepare_v2(db, qryStmt.utf8, -1, stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                var field1 = CChar(sqlite3_column_text(stmt, 0))
                var field2 = CChar(sqlite3_column_text(stmt, 1))
                var field1Value = String(utf8String: field1)
                var field2Value = String(utf8String: field2)
                print("\(field1Value)---\(field2Value)")
            }
                //close this will delete stmt from memory
            sqlite3_finalize(stmt)
        }
    }
}
