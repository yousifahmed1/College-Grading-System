<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "cgs";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$studentId = $_POST['student_id'];
$selectedWeek = $_POST['week'];
$CourseId  = $_POST['groupCourse'];


// Assume your table is named 'attendance'
$tableName = 'assignment';

// Check if the student ID exists in the table
$checkStudentQuery = "SELECT COUNT(*) as count FROM $tableName WHERE std_id = '$studentId'";
$checkStudentResult = $conn->query($checkStudentQuery);

if ($checkStudentResult) {
    $rowCount = $checkStudentResult->fetch_assoc()['count'];

    if ($rowCount > 0) {
        // Student ID exists, update the corresponding week column
        $updateQuery = "UPDATE $tableName SET $selectedWeek = 1 WHERE std_id = '$studentId' AND crs_id = '$CourseId'";
        $updateResult = $conn->query($updateQuery);

        if ($updateResult) {
            echo "Attendance submitted successfully";
            $updateQuery = "UPDATE $tableName SET $selectedWeek = 1 WHERE std_id = '$studentId' AND crs_id = '$CourseId'";

        } else {
            echo "Failed to submit attendance: " . $conn->error;
        }
    } else {
        // Student ID does not exist, insert a new row
        $insertQuery = "INSERT INTO $tableName (std_id, $selectedWeek, crs_id) VALUES ('$studentId', 'yes', '$CourseId')";
        $insertResult = $conn->query($insertQuery);

        if ($insertResult) {
            echo "Attendance submitted successfully";
        } else {
            echo "Failed to submit attendance: " . $conn->error;
        }
    }
} else {
    echo "Failed to check student ID: " . $conn->error;
}

$conn->close();
?>
