<?php
session_start();
header('Content-Type: application/json');
require_once __DIR__ . '/../db.php';

$userId = $_SESSION['user_id'] ?? 1;
$method = $_SERVER['REQUEST_METHOD'];

if ($method !== 'PUT') {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true);
if (!$input) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid JSON']);
    exit;
}

// Whitelist updatable fields
$allowed = ['name', 'email', 'phone', 'address', 'dob', 'license_number', 'issue_date', 'expiry_date', 'years_experience', 'previous_jobs', 'vehicle_categories'];
$sets = [];
$params = [];

foreach ($allowed as $f) {
    if (array_key_exists($f, $input)) {
        if ($f === 'vehicle_categories') {
            $sets[] = "$f = ?";
            $params[] = json_encode($input[$f]);
        } else {
            $sets[] = "$f = ?";
            $params[] = $input[$f];
        }
    }
}

if (empty($sets)) {
    echo json_encode(['success' => false, 'message' => 'Nothing to update']);
    exit;
}

$params[] = $userId;
$sql = 'UPDATE users SET ' . implode(', ', $sets) . ' WHERE id = ?';

try {
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    echo json_encode(['success' => true, 'message' => 'Profile updated successfully']);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database error: ' . $e->getMessage()]);
}
?>