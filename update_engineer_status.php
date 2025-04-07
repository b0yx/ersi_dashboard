<?php
session_start();
header('Content-Type: application/json');

// Validate session and admin privileges
if (!isset($_SESSION['Email']) || $_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(403);
    echo json_encode(['success' => false, 'message' => 'Unauthorized access']);
    exit();
}

require_once 'connection.php';

// Get and validate input data
$input = json_decode(file_get_contents('php://input'), true);

if (!isset($input['engineer_id']) || !isset($input['status'])) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Invalid request data']);
    exit();
}

$engineer_id = (int)$input['engineer_id'];
$new_status = $input['status'] === 1 ? 1 : 0; // Force binary value

try {
    // Verify engineer exists
    $checkStmt = $pdo->prepare("SELECT id FROM user WHERE id = ?");
    $checkStmt->execute([$engineer_id]);
    
    if ($checkStmt->rowCount() === 0) {
        http_response_code(404);
        echo json_encode(['success' => false, 'message' => 'Engineer not found']);
        exit();
    }

    // Update status
    $updateStmt = $pdo->prepare("UPDATE user SET users_approve = ? WHERE id = ?");
    $updateStmt->execute([$new_status, $engineer_id]);

    // Verify update was successful
    if ($updateStmt->rowCount() > 0) {
        echo json_encode([
            'success' => true,
            'new_status' => $new_status,
            'engineer_id' => $engineer_id
        ]);
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'No changes made'
        ]);
    }

} catch (PDOException $e) {
    error_log("Database Error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Database operation failed']);
}