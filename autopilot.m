brick.SetColorMode(2, 2);

while brick.TouchPressed(3) == 0
    color = brick.ColorCode(2);
    distance = brick.UltrasonicDist(1);
    if color == 5
        brick.StopMotor('A');
        brick.StopMotor('D');
        pause (5);
        brick.MoveMotor('A', -100);
        brick.MoveMotor('D', -100);
    end
    if color == 2
        brick.StopMotor('A');
        brick.StopMotor('D');
        pause (5);
    end
    if color == 3
        brick.StopMotor('A');
        brick.StopMotor('D');
        pause (5);
    end
    if distance < 30
        brick.StopMotor('A');
        brick.StopMotor('D');
        brick.MoveMotor('A', -50);
        brick.MoveMotor('D', 50);
        pause (2);
        brick.StopMotor('A');
        brick.StopMotor('D');
        distance = brick.UltrasonicDist(1);
        if distance < 30
            brick.MoveMotor('A', 50);
            brick.MoveMotor('D', -50);
            pause (3.2);
            brick.StopMotor('A');
            brick.StopMotor('D');
        end
    end
    brick.MoveMotor('A', -100);
    brick.MoveMotor('D', -100);
end
brick.StopMotor('A');
brick.StopMotor('D');
    