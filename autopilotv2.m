%Initializing keyboard input
global key
InitKeyboard();

%Initializing color sensor
brick.SetColorMode(2, 2);

%Initialize color variables
blue = 2;
yellow = 4;
green = 3;
red = 5;



%Speed tuning
drivingSpeed = 60;
turningSpeed = 20;
pickupSpeed = 30;
clawSpeed = 50;

%Designate Path
start = yellow;
pickup = blue;
dropoff = green;



%Driving Loop
x = 0;
while x == 0
    
    %This has to be here because matlab is stupid
    pause(.1);
    
    %Updates color and distance sensors every loop
    distance = brick.UltrasonicDist(1);
    color = brick.ColorCode(2);
    
    %Stops the vehicle for 5 seconds at red squares, then continues
    if color == red
        brick.StopMotor('A');
        brick.StopMotor('D');
        disp('STOPPING');
        pause(5);
        brick.MoveMotorAngleRel('A', -drivingSpeed, 540);
        brick.MoveMotorAngleRel('D', -drivingSpeed, 540);
        brick.WaitForMotor('A');
    end
    
    %Manual Pickup Script
    if color == pickup
        i = 0;
        while i == 0
            pause(0.1);
            switch key
                case 'uparrow'
                    disp('FORWARD');
                    brick.MoveMotor('A', -pickupSpeed);
                    brick.MoveMotor('D', -pickupSpeed);
                case 'downarrow'
                    disp('BACKWARD');
                    brick.MoveMotor('A', pickupSpeed);
                    brick.MoveMotor('D', pickupSpeed);
                case 'leftarrow'
                    disp('LEFT');
                    brick.MoveMotor('A', pickupSpeed);
                    brick.MoveMotor('D', -pickupSpeed);
                case 'rightarrow'
                    disp('RIGHT');
                    brick.MoveMotor('A', -pickupSpeed);
                    brick.MoveMotor('D', pickupSpeed);
                case 'w'
                    disp('CLAWUP');
                    brick.MoveMotor('C', -clawSpeed);
                case 's'
                    disp('CLAWDOWN');
                    brick.MoveMotor('C', clawSpeed);
                case 0
                    disp('VOID');
                    brick.StopMotor('A');
                    brick.StopMotor('D');
                    brick.StopMotor('C');
                case 'q'
                    i = 1;
                    break;
            end
        end
    end
    
    %Dropoff at designated zone
    if color == dropoff
        disp('DROPPING OFF');
        brick.StopMotor('A');
        brick.StopMotor('D');
        brick.MoveMotorAngleRel('C', clawSpeed, 540, 'Brake');
        brick.WaitForMotor('C');
        brick.MoveMotorAngleRel('A', drivingSpeed, 540, 'Brake');
        brick.MoveMotorAngleRel('D', drivingSpeed, 540, 'Brake');
        brick.WaitForMotor('A');
        x = 1;
    end
    
    %Pathfinding (not really pathfinding but close enough)
        brick.MoveMotor('A', -drivingSpeed);
        brick.MoveMotor('D', -drivingSpeed);
        %Check Left
        distance = brick.UltrasonicDist(1);
        if distance < 25
            disp('Wall Detected');
            brick.MoveMotorAngleRel('A', turningSpeed, 540, 'Brake');
            brick.MoveMotorAngleRel('D', -turningSpeed, 540, 'Brake');
            brick.WaitForMotor('A');
            pause(.1);
            %Check Right
            distance = brick.UltrasonicDist(1);
            if distance < 40
                disp('Wall Detected');
                brick.MoveMotorAngleRel('A', -turningSpeed, 1080, 'Brake');
                brick.MoveMotorAngleRel('D', turningSpeed, 1080, 'Brake');
                brick.WaitForMotor('A');
                pause(.1);
                %Check Dead End
                distance = brick.UltrasonicDist(1);
                if distance < 40
                    brick.MoveMotorAngleRel('A', -turningSpeed, 540, 'Brake');
                    brick.MoveMotorAngleRel('D', turningSpeed, 540, 'Brake');
                    disp('Dead End Detected');
                    prompt = 'Bypass Dead End? (Y = 1 / N = 2 / INTERSECTION = 3)';
                    bypass = input(prompt);
                    if bypass == 1
                        brick.MoveMotorAngleRel('A', -drivingSpeed, 1600, 'Brake');
                        brick.MoveMotorAngleRel('D', -drivingSpeed, 1600, 'Brake');
                        brick.WaitForMotor('A');
                        brick.MoveMotorAngleRel('A', turningSpeed, 540, 'Brake');
                        brick.MoveMotorAngleRel('D', -turningSpeed, 540, 'Brake');
                        brick.WaitForMotor('A');
                        pause(.1);
                        %Check Right
                        distance = brick.UltrasonicDist(1);
                        if distance < 40
                            disp('Wall Detected');
                            brick.MoveMotorAngleRel('A', -turningSpeed, 1080, 'Brake');
                            brick.MoveMotorAngleRel('D', turningSpeed, 1080, 'Brake');
                            brick.WaitForMotor('A');
                        end
                    end
                    if bypass == 3
                        brick.MoveMotorAngleRel('A', -drivingSpeed, 1600, 'Brake');
                        brick.MoveMotorAngleRel('D', -drivingSpeed, 1600, 'Brake');
                        brick.WaitForMotor('A');
                        brick.MoveMotorAngleRel('A', turningSpeed, 540, 'Brake');
                        brick.MoveMotorAngleRel('D', -turningSpeed, 540, 'Brake');
                        brick.WaitForMotor('A');
                        pause(.1);
                        %Check Right
                        distance = brick.UltrasonicDist(1);
                        if distance < 40
                            disp('Wall Detected');
                            brick.MoveMotorAngleRel('A', -turningSpeed, 1080, 'Brake');
                            brick.MoveMotorAngleRel('D', turningSpeed, 1080, 'Brake');
                            brick.WaitForMotor('A');
                        end
                        brick.MoveMotorAngleRel('A', -drivingSpeed, 1600, 'Brake');
                        brick.MoveMotorAngleRel('D', -drivingSpeed, 1600, 'Brake');
                        brick.WaitForMotor('A');
                        prompt = 'INTERECTION (LEFT = 1 / RIGHT = 2 / FORWARD = 3)';
                        intersection = input(prompt);
                        if intersection == 1
                            brick.MoveMotorAngleRel('A', turningSpeed, 540, 'Brake');
                            brick.MoveMotorAngleRel('D', -turningSpeed, 540, 'Brake');
                            brick.WaitForMotor('A');
                        end
                        if intersection == 2
                            brick.MoveMotorAngleRel('A', -turningSpeed, 540, 'Brake');
                            brick.MoveMotorAngleRel('D', turningSpeed, 540, 'Brake');
                            brick.WaitForMotor('A');
                        end
                    end
                end
            end
        end
    
end

brick.StopMotor('A');
brick.StopMotor('D');
brick.StopMotor('C');