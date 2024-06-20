<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "cgs";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$usernamee = $_POST['username'];

$sql = "CONCAT(G.g_name, ' - ', C.crs_name) AS Group_Course
FROM Groupp G
JOIN Teach T ON G.g_id = T.g_id
JOIN Course C ON T.crs_id = C.crs_id
JOIN dr D ON T.dr_id = D.dr_id
WHERE D.dr_name = 'nasser_ali';";

$result = $conn->query($sql);

if ($result) {
    $groups = [];
    while ($row = $result->fetch_assoc()) {
        $groups[] = $row['g_name'];
    }
    echo implode(',', $groups);
} else {
    echo "Query failed: " . $conn->error;
}

$conn->close();
?>
