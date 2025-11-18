<?php
session_start();
header('Content-Type: application/json');
require_once __DIR__ . '/../db.php';

$userId = $_SESSION['user_id'] ?? 1;

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
    exit;
}

if (!isset($_FILES['license']) || $_FILES['license']['error'] !== UPLOAD_ERR_OK) {
    http_response_code(400);
    echo json_encode(['error' => 'No file uploaded or upload error']);
    exit;
}

$file = $_FILES['license'];
$allowedTypes = ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'];
$maxSize = 5 * 1024 * 1024; // 5MB

if (!in_array($file['type'], $allowedTypes)) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid file type. Only JPG, PNG, GIF allowed']);
    exit;
}

if ($file['size'] > $maxSize) {
    http_response_code(400);
    echo json_encode(['error' => 'File too large. Max 5MB']);
    exit;
}

// Create uploads directory if doesn't exist
$uploadDir = __DIR__ . '/../../uploads/licenses/';
if (!is_dir($uploadDir)) {
    mkdir($uploadDir, 0755, true);
}

// Generate unique filename
$extension = pathinfo($file['name'], PATHINFO_EXTENSION);
$filename = 'license_' . $userId . '_' . time() . '.' . $extension;
$filepath = $uploadDir . $filename;

// Move uploaded file
if (!move_uploaded_file($file['tmp_name'], $filepath)) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to save file']);
    exit;
}

// Update database
$dbPath = '../uploads/licenses/' . $filename;
$stmt = $pdo->prepare('UPDATE users SET license_image = ? WHERE id = ?');
$stmt->execute([$dbPath, $userId]);

echo json_encode([
    'success' => true,
    'path' => $dbPath,
    'message' => 'License image uploaded successfully'
]);
?>