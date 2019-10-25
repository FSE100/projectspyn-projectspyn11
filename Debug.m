global key
InitKeyboard();
brick.SetColorMode(2, 2);

while 1
    pause(0.1);
    brick.GyroCalibrate(4);
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
            brick.MoveMotor('A', -100);
            brick.MoveMotor('D', -100);
            
        case 'downarrow'
            disp('DOWN');
            brick.MoveMotor('A', 100);
            brick.MoveMotor('D', 100);
            
        case 'leftarrow'
            disp('LEFT');
            brick.MoveMotor('A', 100);
            brick.MoveMotor('D', -100);
            
        case 'rightarrow'
            disp('RIGHT');
            brick.MoveMotor('A', -100);
            brick.MoveMotor('D', 100);
        case 'w'
            disp('W');
            brick.MoveMotor('C', -10);
            
        case 's'
            disp('S');
            brick.MoveMotor('C', 10);
            
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