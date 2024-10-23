CREATE TABLE IF NOT EXISTS neon_rewards (
    id INT AUTO_INCREMENT PRIMARY KEY,
    citizenid VARCHAR(50) NOT NULL,
    last_claim_time INT NOT NULL
);