CREATE TABLE IF NOT EXISTS Users
(
    id   INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(256)
);

-- "Enum" for different types of exercise. Saves on storage since there are a non-infinite number of possible exercises
CREATE TABLE IF NOT EXISTS ExerciseTypes
(
    id   INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(64) unique
);

-- Same with Workouts, "enum" for different types of workouts.
CREATE TABLE IF NOT EXISTS WorkoutTypes
(
    id   INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(64) unique
);

/* Base table for exercises to keep track of exercise progress. The following columns are shared:
    * FK: exercise_type_id Exercise type from ExerciseType enum
    * FK: User_id to track unique users progress on this exercise type
    * date_completed timestamp to generate historical data for user.
 */
CREATE TABLE IF NOT EXISTS Exercises
(
    id               INT PRIMARY KEY AUTO_INCREMENT,
    exercise_type_id INT,
    user_id          INT,
    date_completed   TIMESTAMP,

    FOREIGN KEY (exercise_type_id) REFERENCES ExerciseTypes (id),
    FOREIGN KEY (user_id) REFERENCES Users (id)
);

/*
    Base table for Workouts, which house exercises, so users can build their own workouts with various exercises.
    Can have different types of workouts based on the sub-table.
        * FK: workout_type_id Workout type from WorkoutTYpe enum
 */
CREATE TABLE IF NOT EXISTS Workouts
(
    id              INT PRIMARY KEY AUTO_INCREMENT,
    workout_type_id INT,

    FOREIGN KEY (workout_type_id) REFERENCES WorkoutTypes (id)
);

/*
    Junction table mapping users to workouts for scheduling and tracking purposes. User can enable/disabled a particular
    workout. Use sequence # and last_completed to calculate next workout user should complete.
 */
CREATE TABLE IF NOT EXISTS UserWorkoutsMapper
(
    id             INT PRIMARY KEY AUTO_INCREMENT,
    user_id        INT,
    workout_id     INT,
    sequence       INT,
    last_completed TIMESTAMP NULL,
    enabled        BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (user_id) REFERENCES Users (id),
    FOREIGN KEY (workout_id) REFERENCES Workouts (id),

    UNIQUE (user_id, sequence)
);

-- Repped exercises

CREATE TABLE IF NOT EXISTS ExerciseRepped
(
    id INT PRIMARY KEY,
    exercise_id INT,
    weight TINYINT,
    target_reps TINYINT,
    reps1 TINYINT,
    reps2 TINYINT NULL,
    reps3 TINYINT NULL,
    reps4 TINYINT NULL,
    date_completed TIMESTAMP,

    FOREIGN KEY (exercise_id) REFERENCES Exercises (id)
);

-- Timed Exercises

CREATE TABLE IF NOT EXISTS ExerciseTimed
(
    id INT PRIMARY KEY,
    exercise_id INT,
    weight TINYINT NULL,
    target_time TINYINT,
    time1 TINYINT,
    time2 TINYINT NULL,
    time3 TINYINT NULL,
    time4 TINYINT NULL,
    date_completed TIMESTAMP,

    FOREIGN KEY (exercise_id) REFERENCES Exercises (id)
);

/* We have some different types of exercises, 531, repped, and time based exercises. We also have different types of workouts
    We have a base table of Workouts and Exercise, and then specific tables based on these different types of exercises and workouts.
*/
--
-- CREATE TABLE IF NOT EXISTS Splits531
-- (
--     id          INT PRIMARY KEY AUTO_INCREMENT,
--     name        VARCHAR(15),
--
--     multiplier1 FLOAT,
--     reps1       TINYINT,
--
--     multiplier2 FLOAT,
--     reps2       TINYINT,
--
--     multiplier3 FLOAT,
--     reps3       TINYINT
-- );
--
-- CREATE TABLE IF NOT EXISTS Exercises531
-- (
--     exercise_id               INT PRIMARY KEY,
--     one_rep_max               FLOAT,
--
--     warmup_split_id INT,
--
--     split1_id                 INT,
--     split1_is_completed       BOOLEAN,
--     split1_completed_date     TIMESTAMP,
--
--     split2_id                 INT,
--     split2_is_completed       BOOLEAN,
--     split2_completed_date     TIMESTAMP,
--
--     split3_id                 INT,
--     split3_is_completed       BOOLEAN,
--     split3_completed_date     TIMESTAMP,
--
--     deload_split_id           INT     NULL,
--     deload_split_is_completed BOOLEAN NULL,
--
--     FOREIGN KEY (exercise_id) REFERENCES Exercises (id),
--     FOREIGN KEY (warmup_split_id) REFERENCES Splits531,
--     FOREIGN KEY (split1_id) REFERENCES Splits531 (id),
--     FOREIGN KEY (split2_id) REFERENCES Splits531 (id),
--     FOREIGN KEY (split3_id) REFERENCES Splits531 (id),
--     FOREIGN KEY (deload_split_id) REFERENCES Splits531 (id)
-- );
--
-- CREATE TABLE IF NOT EXISTS Workout531
-- (
--     id                       INT PRIMARY KEY AUTO_INCREMENT,
--
--     exercise_531_id          INT,
--     assistance_exercise_1_id INT NULL,
--     assistance_exercise_2_Id INT NULL,
--     assistance_exercise_3_id INT NULL,
--     assistance_exercise_4_id INT NULL,
--
--     FOREIGN KEY (exercise_531_id) REFERENCES Exercises531 (exercise_id),
--     FOREIGN KEY (assistance_exercise_1_id) REFERENCES ExerciseRepped(id),
--     FOREIGN KEY (assistance_exercise_2_id) REFERENCES ExerciseRepped(id),
--     FOREIGN KEY (assistance_exercise_3_id) REFERENCES ExerciseRepped(id),
--     FOREIGN KEY (assistance_exercise_4_id) REFERENCES ExerciseRepped(id),
-- );
--
-- CREATE TABLE IF NOT EXISTS Workout531Beginner
-- (
--     id                    INT PRIMARY KEY AUTO_INCREMENT,
--     workout_name          VARCHAR(256),
--
--     primary_exercise_1_id INT,
--     primary_exercise_2_id INT,
--
--     assistance_exercise_1_id INT NULL,
--     assistance_exercise_2_id INT NULL,
--     assistance_exercise_3_id INT NULL,
--     assistance_exercise_4_id INT NULL,
--
--     FOREIGN KEY (primary_exercise_1_id) REFERENCES Workout531 (id),
--     FOREIGN KEY (primary_exercise_2_id) REFERENCES Workout531 (id),
--     FOREIGN KEY (assistance_exercise_1_id) REFERENCES ExerciseRepped(id),
--     FOREIGN KEY (assistance_exercise_2_id) REFERENCES ExerciseRepped(id),
--     FOREIGN KEY (assistance_exercise_3_id) REFERENCES ExerciseRepped(id),
--     FOREIGN KEY (assistance_exercise_4_id) REFERENCES ExerciseRepped(id),
-- );