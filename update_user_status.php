<?php
require 'connection.php';

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['user_id'], $data['status'])) {
    echo json_encode(['success' => false, 'message' => 'Missing parameters']);
    exit;
}

$user_id = intval($data['user_id']);
$status = intval($data['status']);

try {
    $stmt = $pdo->prepare("UPDATE user SET users_approve = ? WHERE id = ?");
    $stmt->execute([$status, $user_id]);
    echo json_encode(['success' => true]);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
