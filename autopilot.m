%Initializing keyboard input
global key
InitKeyboard();

x = 0;
%Loop to make everything happen more than once
while x == 0
    pause(.1);
       switch key
        case 'space'
            %This switch is basically only here for when things go horribly
            %wrong I can mash the spacebar and everything will be ok
            x = 1;
            break;
        case 0
            %The actual program starts here
            
            %Updates color and distance sensors every loop
            distance = brick.UltrasonicDist(1);
            
            %Driving Function
            speed = 100;
            brick.MoveMotor('A', -60);
            brick.MoveMotor('D', -60);
            %if wall, then turn and pray
            if distance < 20
                disp("Wall Detected");
                brick.StopMotor('A');
                brick.StopMotor('D');
                brick.MoveMotor('A', -50);
                brick.MoveMotor('D', 50);
                pause(2.1);
                distance = brick.UltrasonicDist(1);
                if distance < 40
                    disp("Wall Detected");
                    brick.MoveMotor('A', 50);
                    brick.MoveMotor('D', -50);
                    pause(4);
                    brick.StopMotor('A');
                    brick.StopMotor('D');
                    pause(.1);
                    distance = brick.UltrasonicDist(1);
                    %CURRENTLY INCOMPLETE. For getting around tricky parts
                    %of the map. very wip.
                    if distance < 40
                        disp("Dead End Detected");
                        brick.MoveMotor('A', 50);
                        brick.MoveMotor('D', -50);
                        pause(2.1);
                        brick.MoveMotor('A', -60);
                        brick.MoveMotor('D', -60);
                        pause(4);
                        brick.StopMotor('A');
                        brick.StopMotor('D');
                        brick.MoveMotor('A', 50);
                        brick.MoveMotor('D', -50);
                        pause(2.1);
                    end
                        
                end
            end
    end
end

CloseKeyboard();

%This is where I would put my functions, IF MATLAB WASNT STUPID AND GLOBAL
%VARIABLES WERE ACCESSIBLE BY FUNCTIONS MATLAB WHY