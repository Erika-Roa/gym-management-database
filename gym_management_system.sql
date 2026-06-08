USE gym_management_system;
#Aisling Beresford aeb247, Ava Carragher ajc341, Erika Roa ejr134


#create our database 
#we are making a gym management system 
# CREATE DATABASE gym_management_system;
# USE gym_management_system; 

DROP TABLE IF EXISTS Memberships;
DROP TABLE IF EXISTS MemberWorkoutPlans;
DROP TABLE IF EXISTS WorkoutExercises;
DROP TABLE IF EXISTS Exercises;
DROP TABLE IF EXISTS WorkoutPlans;
DROP TABLE IF EXISTS ClassEnrollment;
DROP TABLE IF EXISTS FitnessClasses;
DROP TABLE IF EXISTS Equipment;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS MemberGym;
DROP TABLE IF EXISTS MembershipPlans;
DROP TABLE IF EXISTS Gyms;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS Staff;

#create gyms 
CREATE TABLE Gyms (
    gym_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    gym_name VARCHAR(100) NOT NULL,
    location VARCHAR(150) NOT NULL,
    phone VARCHAR(15) NOT NULL
) ENGINE=InnoDB;
#inserts 
INSERT INTO Gyms (gym_name, location, phone) VALUES
('NorthWest Gym', 'Pittsburgh', '4121248765'),
('North Gym', 'Pittsburgh', '41226713475'),
('South Gym', 'Pittsburgh', '4121230987'),
('East Gym', 'Pittsburgh', '4124236454'),
('West Gym', 'Pittsburgh', '4121029388');


#create members table 
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other')
) ENGINE=InnoDB; #engine for all tables
#inserts 
INSERT INTO Members (first_name, last_name, email, phone, date_of_birth, gender) VALUES
('Jack', 'Grey', 'jack.grey@email.com', '3456345678', '1998-06-15', 'Male'),
('Emma', 'Lesse', 'emma.lesse@email.com', '4234501980', '1999-03-22', 'Female'),
('Ted', 'Berry', 'ted.b@email.com', '47658971234', '1998-11-05', 'Male'),
('Olivia', 'Ronker', 'olivia.r@email.com', '5782930456', '2000-01-17', 'Female'),
('Erika', 'Roa', 'erika.roa@email.com', '9128789787', '2006-09-30', 'Female');
 
#create staff table 
CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role ENUM('Reception', 'Trainer', 'Manager', 'Membership Coordinator', 'Cleaner') NOT NULL,
    gym_id INT NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    FOREIGN KEY (gym_id) REFERENCES Gyms(gym_id)
) ENGINE=InnoDB;
#insterts 
INSERT INTO Staff (first_name, last_name, role, gym_id, email, phone) VALUES
('Sarah', 'Kosmer', 'Trainer', 1 , 'sarah@gym.com', '4122456789'),
('David', 'Lap', 'Trainer', 1 , 'david@gym.com', '6767676767'),
('Nirja', 'Diveker', 'Manager', 2 , 'nirja@gym.com', '8728495876'),
('Chris', 'Brown', 'Reception', 2 ,  'chris@gym.com', '1234567890'),
('Autumn', 'Burrows', 'Membership Coordinator', 1 , 'autumn@gym.com', '1235768921');
 
#create membershipPlans 
CREATE TABLE MembershipPlans (
    plan_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    plan_name ENUM('Basic','Premium', 'VIP') NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    duration_months ENUM('6', '12', '24', '36') NOT NULL
) ENGINE=InnoDB;
#inserts
INSERT INTO MembershipPlans (plan_name, price, duration_months) VALUES
('Basic', 30.00, '24'),
('Basic', 50.00, '6'),
('Premium', 80.00, '12'),
('VIP', 25.00, '36'),
('VIP', 500.00, '12');
 
#create Memberships 
#junctions member and plan
CREATE TABLE Memberships (
	member_id INT NOT NULL,
    plan_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    PRIMARY KEY (member_id, plan_id, start_date),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (plan_id) REFERENCES MembershipPlans(plan_id)
) ENGINE=InnoDB;

# I tried to create a trigger here to prevent overlapping memberships for the same member, but I was not able to. 
#I got an error saying I did not have permission.

#inserts
INSERT INTO Memberships (member_id, plan_id, start_date, end_date) VALUES
(1, 1, '2026-03-04', '2026-12-01'),
(2, 2, '2026-01-13', '2026-12-01'),
(3, 3, '2026-04-01', '2026-12-01'),
(4, 4, '2026-02-04', '2026-12-01'),
(5, 5, '2026-01-01', '2027-12-01');
 
#create Workourt Plans 
CREATE TABLE WorkoutPlans (
    workout_plan_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    difficulty_level ENUM('Easy', 'Medium', 'Hard', 'Extreme', 'Expert') NOT NULL,
    description VARCHAR(255)
) ENGINE=InnoDB;
#inserts 
INSERT INTO WorkoutPlans (name, difficulty_level, description) VALUES
('Beginner Plan', 'Easy', 'basic intro workouts'),
('Strength Plan', 'Medium', 'build muscle'),
('Cardio Plan', 'Easy', 'strengthem endurance'),
('Advanced Plan', 'Hard', 'high intensity '),
('Weight Loss Plan', 'Extreme', 'burn fat');
 
 
#create Member Workout Plan 
#junction with member and workout plan id 
CREATE TABLE MemberWorkoutPlans (
    member_id INT NOT NULL,
    workout_plan_id INT NOT NULL,
    PRIMARY KEY (member_id, workout_plan_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (workout_plan_id) REFERENCES WorkoutPlans(workout_plan_id)
) ENGINE=InnoDB;
#inserts 
INSERT INTO MemberWorkoutPlans (member_id, workout_plan_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);
 
#create Exercises 
CREATE TABLE Exercises (
    exercise_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    muscle_group ENUM('Chest', 'Back', 'Biceps', 'Quads', 'Legs', 'Cardio', 'Core') NOT NULL
    #though prevelent to exercise categories 
) ENGINE=InnoDB;
#inserts 
INSERT INTO Exercises (name, muscle_group) VALUES
('Bench Press', 'Chest'),
('Squat', 'Legs'),
('Deadlift', 'Back'),
('Running', 'Cardio'),
('Plank', 'Core'); 
 
#create workout excerise 
#junction workout plan and exercise 
CREATE TABLE WorkoutExercises (
    workout_plan_id INT NOT NULL,
    exercise_id INT NOT NULL,
    sets INT NOT NULL,
    reps INT NOT NULL,
    PRIMARY KEY (workout_plan_id, exercise_id),
    FOREIGN KEY (workout_plan_id) REFERENCES WorkoutPlans(workout_plan_id),
    FOREIGN KEY (exercise_id) REFERENCES Exercises(exercise_id)
) ENGINE=InnoDB;
#inserts 
INSERT INTO WorkoutExercises (workout_plan_id, exercise_id, sets, reps) VALUES
(1, 1, 3, 10),
(2, 2, 4, 8),
(3, 4, 1, 30),
(4, 3, 5, 5),
(5, 5, 3, 60);
 
 
#create fitness classes 
CREATE TABLE FitnessClasses (
    class_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    class_name ENUM('Zumba', 'HIIT', 'Spin', 'Yoga', 'Pilates', 'Barre') NOT NULL,
    schedule DATETIME NOT NULL,
    staff_id INT NOT NULL,
    gym_id INT NOT NULL,
    FOREIGN KEY (gym_id) REFERENCES Gyms(gym_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
) ENGINE=InnoDB; 
#insert
INSERT INTO FitnessClasses (class_name, schedule, staff_id, gym_id) VALUES
('Yoga', '2026-04-1 10:00:00', 1, 1),
('Spin', '2026-04-3 12:00:00', 2, 1),
('Zumba', '2026-04-7 14:00:00', 3, 1),
('HIIT', '2026-04-4 16:00:00', 1, 2),
('Pilates', '2026-04-1 18:00:00', 2, 1);
 
#create class enrollment 
#junction member and class 
CREATE TABLE ClassEnrollment (
    member_id INT NOT NULL,
    class_id INT NOT NULL,
    PRIMARY KEY (member_id, class_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (class_id) REFERENCES FitnessClasses(class_id)
) ENGINE=InnoDB;
#inserts 
INSERT INTO ClassEnrollment (member_id, class_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);
 
#create equipment 
CREATE TABLE Equipment (
    equipment_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    type ENUM('Cardio', 'Strength', 'Resistance', 'Weights') NOT NULL,
    purchase_date DATE NOT NULL,
    status ENUM('Working', 'Maintenance', 'Awaiting Replacement') NOT NULL,
    gym_id INT NOT NULL,
    FOREIGN KEY (gym_id) REFERENCES Gyms(gym_id)
) ENGINE=InnoDB;
#inserts 
INSERT INTO Equipment (name, type, purchase_date, status, gym_id) VALUES
('Treadmill', 'Cardio', '2026-01-01', 'Working', 1),
('Dumbbells', 'Strength', '2026-02-10', 'Working', 2),
('Bench Press', 'Strength', '2026-03-15', 'Maintenance', 1),
('Elliptical', 'Cardio', '2026-03-20', 'Working', 1),
('Row Machine', 'Cardio', '2026-01-11', 'Working', 2);
 
#create payments 
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    member_id INT NOT NULL,
    plan_id INT NOT NULL,
    start_date DATE NOT NULL, 
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_method ENUM('Cash', 'Debit Card', 'Credit Card', 'Check')  NOT NULL,
    FOREIGN KEY (member_id, plan_id, start_date) REFERENCES Memberships(member_id, plan_id, start_date)
) ENGINE=InnoDB;
#inserts 
INSERT INTO Payments (member_id, plan_id, start_date, amount, payment_date, payment_method) VALUES
(1, 1, '2026-03-04', 30.00, '2026-04-01', 'Debit Card'),
(2, 2, '2026-01-13' , 50.00, '2026-01-16', 'Cash'),
(3, 3, '2026-04-01', 80.00, '2026-04-03', 'Credit Card'),
(4, 4, '2026-02-04',  25.00, '2026-02-15', 'Check'),
(5, 5, '2026-01-01', 500.00, '2026-01-01','Cash');
  
#create member gym 
CREATE TABLE MemberGym (
    member_id INT NOT NULL,
    gym_id INT NOT NULL,
    join_date DATE NOT NULL,
    PRIMARY KEY (member_id, gym_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (gym_id) REFERENCES Gyms(gym_id)
) ENGINE=InnoDB;
#inserts 
INSERT INTO MemberGym (member_id, gym_id, join_date) VALUES
(1, 1, '2026-01-01'),
(2, 2, '2026-01-10'),
(3, 3, '2026-02-01'),
(4, 4, '2026-02-15'),
(5, 5, '2026-01-01');
 
#transaction with rollback 
START TRANSACTION;

INSERT INTO Payments (member_id, plan_id, start_date, amount, payment_date, payment_method)
VALUES (1, 1, '2026-03-04', 50.00, CURDATE(), 'Credit Card');

UPDATE Memberships
SET end_date = DATE_ADD(end_date, INTERVAL 1 MONTH)
WHERE member_id = 1
AND plan_id = 1
AND start_date = '2026-03-04';

# ROLLBACK;  -- use only if testing

COMMIT;
 
#create views 
#member and membership view 
DROP VIEW IF EXISTS MemberMembershipDetails;
CREATE VIEW MemberMembershipDetails AS
SELECT 
    m.member_id,
    CONCAT(m.first_name, ' ', m.last_name) AS full_name,
    mp.plan_name,
    mp.price,
    ms.start_date,
    ms.end_date
FROM Members m
JOIN Memberships ms ON m.member_id = ms.member_id
JOIN MembershipPlans mp ON ms.plan_id = mp.plan_id;
 
#class popularity 
DROP VIEW IF EXISTS ClassPopularity;
CREATE VIEW ClassPopularity AS
SELECT 
    fc.class_name,
    COUNT(ce.member_id) AS total_enrolled
FROM FitnessClasses fc
LEFT JOIN ClassEnrollment ce ON fc.class_id = ce.class_id
GROUP BY fc.class_name;
 
#Indexes 
CREATE INDEX idx_member_email ON Members(email);
CREATE INDEX idx_staff_role ON Staff(role);
CREATE INDEX idx_payment_member ON Payments(member_id);
CREATE INDEX idx_class_schedule ON FitnessClasses(schedule);

#check if data was inserted correctly
SELECT * FROM Members;
SELECT * FROM Gyms;
SELECT * FROM Staff;
SELECT * FROM FitnessClasses;
SELECT * FROM MemberGym;
