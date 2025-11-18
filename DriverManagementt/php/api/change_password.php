<?php
session_start();
header('Content-Type: application/json');
require_once __DIR__ . '/../db.php';

$userId = $_SESSION['user_id'] ?? 1;
$method = $_SERVER['REQUEST_METHOD'];

if ($method !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true);
if (!$input || !isset($input['current_password']) || !isset($input['new_password'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing required fields']);
    exit;
}

// Get current password from database
$stmt = $pdo->prepare('SELECT password FROM users WHERE id = ?');
$stmt->execute([$userId]);
$user = $stmt->fetch();

if (!$user) {
    http_response_code(404);
    echo json_encode(['error' => 'User not found']);
    exit;
}

// Verify current password
if (!password_verify($input['current_password'], $user['password'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Current password is incorrect']);
    exit;
}

// Hash new password
$newPasswordHash = password_hash($input['new_password'], PASSWORD_DEFAULT);

// Update password
$stmt = $pdo->prepare('UPDATE users SET password = ? WHERE id = ?');
$stmt->execute([$newPasswordHash, $userId]);

echo json_encode(['success' => true, 'message' => 'Password changed successfully']);
?>