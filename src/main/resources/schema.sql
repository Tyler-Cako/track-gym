CREATE TABLE IF NOT EXISTS Users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(256)
);

CREATE TABLE IF NOT EXISTS ExerciseTypes(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(256)
);

INSERT INTO ExerciseTypes(name) VALUES ('BENCH_PRESS');
INSERT INTO ExerciseTypes(name) VALUES ('SQUAT');
INSERT INTO ExerciseTypes(name) VALUES ('DEADLIFT');
INSERT INTO ExerciseTypes(name) VALUES ('OVERHEAD_PRESS');

CREATE TABLE IF NOT EXISTS Splits(
    id INT PRIMARY KEY AUTO_INCREMENT,
    multiplier FLOAT,
    reps TINYINT
);

CREATE TABLE IF NOT EXISTS Exercises(
    id INT PRIMARY KEY AUTO_INCREMENT,
    exercise_type_id INT,
    one_rep_max FLOAT,

    split1_id INT,
    split1_is_completed BOOLEAN,
    split1_completed_date TIMESTAMP,

    split2_id INT,
    split2_is_completed BOOLEAN,

    split3_id INT,
    split3_is_completed BOOLEAN,

    split4_id INT NULL,
    split4_is_completed BOOLEAN NULL,

    FOREIGN KEY (exercise_type_id) REFERENCES ExerciseTypes(id),
    FOREIGN KEY (split1_id) REFERENCES Splits(id),
    FOREIGN KEY (split2_id) REFERENCES Splits(id),
    FOREIGN KEY (split3_id) REFERENCES Splits(id),
    FOREIGN KEY (split4_id) REFERENCES Splits(id)
);

CREATE TABLE IF NOT EXISTS UserExerciseMapper(
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    exercise_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (exercise_id) REFERENCES Exercises(id)
);
