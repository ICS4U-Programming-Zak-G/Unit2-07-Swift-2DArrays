//
//  2DArrays.swift
//
//  Created by Zak Goneau
//  Created on 2025-04-01
//  Version 1.0
//  Copyright (c) 2025 Zak Goneau. All rights reserved.
//
//  Generate random marks and assign them to a 2D array
//  Then write the results to a csv file.

// Import library
import Foundation

// Define main function
func main() {

    // Initialize files
    let marksFile = "marks.csv"
    let stuFile = "Unit1-08-students.txt"
    let assignFile = "Unit1-08-assignments.txt"

    // Initialize output string
    var outputStr = ""

    // Introduce program to user
    print("This program generates random marks and assigns them to a 2D array.")

    // Try to read the student name file
    guard let stuInput = FileHandle(forReadingAtPath: stuFile) else {

        // Tell user input file couldn't be opened
        print("Couldn't open the student name file")

        // Exit function
        exit(1)
    }

    // Try to read the assignment file
    guard let assignInput = FileHandle(forReadingAtPath: assignFile) else {

        // Tell user input file couldn't be opened
        print("Couldn't open the assignment file")

        // Exit function
        exit(1)
    }

    // Try to read the csv file
    guard let marksCSV = FileHandle(forWritingAtPath: marksFile) else {

        // Tell user output file couldn't be opened
        print("Couldn't open the csv file")

        // Exit function
        exit(1)
    }

    // Read lines from student file
    let stuData = stuInput.readDataToEndOfFile()

    // Convert data to string
    guard let inputString = String(data: stuData, encoding: .utf8) else {

        // Tell user couldn't convert data to string
        print("Couldn't convert data to string")

        // Exit function
        exit(1)
    }

    // Split string into lines
    let lines = inputString.components(separatedBy: "\n")

    // Create student names array
    var stuArray = [String]()

    // Loop through lines
    for line in lines {

        // Get current line and trim whitespace
        let names = line.components(separatedBy: " ")

        // Split line into names
        for name in names {

            // Trim whitespace
            let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)

            // Check if empty then add to array
            if !trimmed.isEmpty {
                stuArray.append(trimmed)
            }
        }
    }


    // Read lines from assignment file
    let assignData = assignInput.readDataToEndOfFile()

    // Convert data to string
    guard let assignString = String(data: assignData, encoding: .utf8) else {

        // Tell user couldn't convert data to string
        print("Couldn't convert data to string")

        // Exit function
        exit(1)
    }

    // Split string into lines
    let assignLines = assignString.components(separatedBy: "\n")

    // Create assignment names array
    var assignArray = [String]()

    // Loop through lines
    for line in assignLines {

        // Get current line and trim whitespace
        let assignments = line.components(separatedBy: " ")

        // Split line into assignments
        for assignment in assignments {

            // Trim whitespace
            let trimmed = assignment.trimmingCharacters(in: .whitespacesAndNewlines)

            // Check if empty then add to array
            if !trimmed.isEmpty {
                assignArray.append(trimmed)
            }
        }
    }

    // Initialize 2D array the size of the number of students and assignments
    var marksArray: [[String]] = Array(repeating: Array(repeating: "", count: assignArray.count + 1), count: stuArray.count + 1)

    // Add titles to marks array
    marksArray[0][0] = "Names"

    // Add assignment names to first row
    for counter in 0..<assignArray.count {
        marksArray[0][counter + 1] = assignArray[counter]
    }

    // Call function to generate marks
    marksArray = generateMarks(stuArray: stuArray, assignArray: assignArray, marksArray: marksArray)

    // Build CSV string
    for row in marksArray {
        outputStr += row.joined(separator: ",") + "\n"
    }

    // Write to CSV file
    if let data = outputStr.data(using: .utf8) {
        marksCSV.write(data)
    
    // Display failed conversion message
    } else {
        print("Failed to convert output string to data.")
        exit(1)
    }

    // Close files
    stuInput.closeFile()
    assignInput.closeFile()
    marksCSV.closeFile()
}

// Define function to generate marks
func generateMarks(stuArray: [String], assignArray: [String], marksArray: [[String]]) -> [[String]] {
    // Initialize marks array
    var marksArray = marksArray

    // Loop through rows
    for row in 1...stuArray.count {
        // Assign student names to first column
        marksArray[row][0] = stuArray[row - 1]

        // Loop through columns
        for column in 1...assignArray.count {
            // Generate random marks
            marksArray[row][column] = String(Int.random(in: 50...100))
        }
    }

    // Return marks array
    return marksArray
}

// Call main
main()
