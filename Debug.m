%Initializing global keyboard control
global key
InitKeyboard();

%Initializing color sensor
brick.SetColorMode(2, 2);

%One big fat driving loop because matlab sucks and I cant do this any other
%way
while 1
    pause(0.1);
    distance = brick.UltrasonicDist(1);
    disp('ULTRASONIC');
    disp(distance);
    color = brick.ColorCode(2);
    disp('COLOR');
    disp(color);
    angle = brick.GyroAngle(4);
    disp('ANGLE');
    disp(angle);
    
    switch key
        case 'uparrow'
            disp('UP');
            brick.MoveMotor('A', -60);
            brick.MoveMotor('D', -60);
        case 'downarrow'
            disp('DOWN');
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
            disp('W');
            brick.MoveMotor('C', -50);
            
        case 's'
            disp('S');
            brick.MoveMotor('C', 50);
            
        case 0
            disp('Void');
            brick.StopMotor('A');
            brick.StopMotor('D');
            brick.StopMotor('C');
            
        case 'q'
            break;
    end
end
CloseKeyboard();

%This is where I would put my functions, IF MATLAB WASNT STUPID AND GLOBAL
%VARIABLES ACTUALLY PASSED THROUGH TO FUNCTIONS