%Initializing keyboard input
global key
InitKeyboard();

%Initializing color sensor
brick.SetColorMode(2, 2);

x = 0;
%Loop to make everything happen more than once
while x == 0
    pause(.1);
            %The actual program starts here
            
            %Updates color and distance sensors every loop
            distance = brick.UltrasonicDist(1);
            color = brick.ColorCode(2);
            
            %Stop at red
            if color == 5
                brick.StopMotor('A');
                brick.StopMotor('D');
                pause(5);
                brick.MoveMotor('A', -60);
                brick.MoveMotor('D', -60);
                pause(2);
            end
            
            %pickup at yellow
            if color == 4
                %convert to manual input for pickup
                i = 0;
                while i == 0
                    switch key
                        case 'uparrow'
                            disp('FORWARD');
                            brick.MoveMotor('A', -60);
                            brick.MoveMotor('D', -60);
                        case 'downarrow'
                            disp('BACKWARD');
                            brick.MoveMotor('A', 60);
                            brick.MoveMotor('D', 60);
                        case 'leftarrow'
                            disp('LEFT');
                            brick.MoveMotor('A', 60);
                            brick.MoveMotor('D', -60);
                        case 'rightarrow'
                            disp('RIGHT');
                            brick.MoveMotor('A', -60);
                            brick.MoveMotor('D', 60);
                        case 'w'
                            disp('CLAW UP');
                            brick.MoveMotor('C', -100);
                        case 's'
                            disp('CLAW DOWN');
                            brick.MoveMotor('C', 100);
                        case 0
                            disp('STOP');
                            brick.StopMotor('A');
                            brick.StopMotor('D');
                            brick.StopMotor('C');
                        case 'q'
                            i = 1;
                            break;
                    end
                end
            end
            
            %Driving Function
            brick.MoveMotor('A', -60);
            brick.MoveMotor('D', -60);
            %if wall, then turn and pray
            if distance < 25
                disp("Wall Detected");
                brick.StopMotor('A');
                brick.StopMotor('D');
                brick.MoveMotorAngleRel('A', 20, 540, 'Brake');
                brick.MoveMotorAngleRel('D', -20, 540, 'Brake');
                brick.WaitForMotor('A');
                distance = brick.UltrasonicDist(1);
                if distance < 40
                    disp("Wall Detected");
                    brick.MoveMotorAngleRel('A', -20, 1080, 'Brake');
                    brick.MoveMotorAngleRel('D', 20, 1080, 'Brake');
                    brick.WaitForMotor('A');
                    pause(.1);
                    distance = brick.UltrasonicDist(1);
                    %CURRENTLY INCOMPLETE. For getting around tricky parts
                    %of the map. very wip.
                    if distance < 40
                        disp("Dead End Detected");
                        brick.MoveMotorAngleRel('A', 20, 540, 'Brake');
                        brick.MoveMotorAngleRel('D', -20, 540, 'Brake');
                        brick.MoveMotor('A', -60);
                        brick.MoveMotor('D', -60);
                        pause(4);
                        brick.StopMotor('A');
                        brick.StopMotor('D');
                        brick.MoveMotor('A', 50);
                        brick.MoveMotor('D', -50);
                        pause(1);
                    end
                        
                end
            end
            
            %Dropoff at blue
            if color == 2
              brick.StopMotor('A');
              brick.StopMotor('D');  
              brick.MoveMotor('C', 100);
              pause(2);
              brick.MoveMotor('A', 60);
              brick.MoveMotor('D', 60);
              pause(2);
              x = 1;
              break;
            end
end

CloseKeyboard();

%This is where I would put my functions, IF MATLAB WASNT STUPID AND GLOBAL
%VARIABLES WERE ACCESSIBLE BY FUNCTIONS MATLAB WHY