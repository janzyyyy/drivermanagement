<?php
session_start();
header('Content-Type: application/json');
require_once __DIR__ . '/../db.php';

// Use session user_id if available, otherwise default to 1 for testing
$userId = $_SESSION['user_id'] ?? 1;

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    $stmt = $pdo->prepare('SELECT id, username, email, phone, address, dob, license_number, issue_date, expiry_date, years_experience, previous_jobs, vehicle_categories, member_since, total_trips, rating FROM drivers WHERE id = ?');
    $stmt->execute([$userId]);
    $row = $stmt->fetch();
    if (!$row) {
        http_response_code(404);
        echo json_encode(['error' => 'User not found']);
        exit;
    }
    $row['vehicle_categories'] = $row['vehicle_categories'] ? json_decode($row['vehicle_categories'], true) : [];
    echo json_encode($row);
    exit;
}

if ($method === 'PUT') {
    $input = json_decode(file_get_contents('php://input'), true);
    if (!$input) {
        http_response_code(400);
        echo json_encode(['error' => 'Invalid JSON']);
        exit;
    }

    // Whitelist updatable fields
    $allowed = ['username','email','phone','address','dob','license_number','issue_date','expiry_date','years_experience','previous_jobs','vehicle_categories'];
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
    $sql = 'UPDATE drivers SET ' . implode(', ', $sets) . ' WHERE id = ?';
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);

    echo json_encode(['success' => true]);
    exit;
}

// other methods not allowed
http_response_code(405);
echo json_encode(['error' => 'Method not allowed']);
exit;
?>