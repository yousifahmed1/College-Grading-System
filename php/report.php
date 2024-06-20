<?php
// Include PhpSpreadsheet classes
require_once __DIR__ . '/../PhpSpreadsheet/vendor/autoload.php';

use PhpOffice\PhpSpreadsheet\IOFactory;

// Check if form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Sanitize and validate input
    $CourseId = $_POST['groupCourse'];
    $groupId = $_POST['groupid'];

    // Your SQL query
    $sql = "SELECT A.*, S.std_name
    FROM assignment A
    JOIN Student S ON A.std_id = S.std_id
    WHERE A.std_id IN (
                SELECT S.std_id
                FROM Student S
                WHERE S.g_id = '$groupId'
            )
    AND A.crs_id = '$CourseId'";

    // Replace the database connection details with your own
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "cgs";

    // Execute the query
    $conn = new mysqli($servername, $username, $password, $dbname);
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    $result = $conn->query($sql);

    // Create a new Spreadsheet object
    $spreadsheet = new \PhpOffice\PhpSpreadsheet\Spreadsheet();
    $sheet = $spreadsheet->getActiveSheet();

    // Write headers
    $columnIndex = 1;
    $headers = ['std_id', 'std_name','w1','w2','w3','w4','w5','w6','w7','w8','w9','w10','w11','w12','w13','w14','w16','total attemps' , 'total asends', 'Student Name']; // add more column headers as needed
    foreach ($headers as $header) {
        $cell = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($columnIndex) . '1';
        $sheet->setCellValue($cell, $header);
        $columnIndex++;
    }

    // Write data
    $rowIndex = 2;
    while ($row = $result->fetch_assoc()) {
        $columnIndex = 1;
        foreach ($row as $value) {
            $cell = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($columnIndex) . $rowIndex;
            $sheet->setCellValue($cell, $value);
            $columnIndex++;
        }
        $rowIndex++;
    }

    // Save the spreadsheet as an Excel file
    $writer = \PhpOffice\PhpSpreadsheet\IOFactory::createWriter($spreadsheet, 'Xlsx');
    $writer->save('assignment.xlsx');

    // Close the database connection
    $conn->close();
}
?>
---
<br />
