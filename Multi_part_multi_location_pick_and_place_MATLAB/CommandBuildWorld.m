function CommandBuildWorld(coordinator)

    % Construct a ground for the simulation world
     ground = collisionBox(2, 2, 0.05);   
     Tground = trvec2tform([0 0 -0.04]);
     
     ground.Pose = Tground;
     coordinator.World = {ground};
     
     visualizeWorld(coordinator)
    
    % Construct the obstacles
    obs1 = collisionSphere(0.13);
    Tobs1 = trvec2tform([0.35 -0.15 0.1]);
    obs1.Pose = Tobs1;

    obs2 = collisionCylinder(0.1, 0.33);
    Tobs2 = trvec2tform([-0.07 -0.48 0.13]);
    obs2.Pose = Tobs2;

    obs3 = collisionBox(0.3, 0.05, 0.3);
    Tobs3 = trvec2tform([0.55 0.58 0.1]);
    obs3.Pose = Tobs3;
    
    obs4 = collisionBox(0.3, 0.05, 0.3);
    Tobs4 = trvec2tform([0.55 0.25 0.1]);
    obs4.Pose = Tobs4;

    coordinator.Obstacles = {obs1, obs2, obs3, obs4};    

    visualizeObstacles(coordinator)
    
    % Construct parts
    box1 = collisionBox(0.07, 0.07, 0.07);
    box2 = collisionBox(0.07, 0.07, 0.07);
    box3 = collisionBox(0.07, 0.07, 0.07);
    box4 = collisionBox(0.07, 0.07, 0.07);
    sphere = collisionSphere(0.03);

    TBox1 = trvec2tform([-0.05 -0.7 0.01]);
    TBox2 = trvec2tform([0.55 -0.25 0.01]);
    TBox3 = trvec2tform([-0.1 -0.5 0.33]);
    TBox4 = trvec2tform([-0.55 -0.45 0.01]);
    TSphere = trvec2tform([0.6 0.43 0.01]);

    box1.Pose = TBox1;
    box2.Pose = TBox2;
    box3.Pose = TBox3;
    box4.Pose = TBox4;
    sphere.Pose = TSphere;

    % Set the part mesh
    part1.mesh = box2;
    part2.mesh = box3;
    part3.mesh = box1;
    part4.mesh = sphere;
    part5.mesh = box4;

    % Set the part color
    part1.color = 'g';
    part2.color = 'r';
    part3.color = 'y';
    part4.color = 'w';
    part5.color = 'g';

    part1.centerPoint = tform2trvec(part1.mesh.Pose);
    part2.centerPoint = tform2trvec(part2.mesh.Pose);
    part3.centerPoint = tform2trvec(part3.mesh.Pose);
    part4.centerPoint = tform2trvec(part4.mesh.Pose);
    part5.centerPoint = tform2trvec(part5.mesh.Pose);

    part1.plot = [];
    part2.plot = [];
    part3.plot = [];
    part4.plot = [];
    part5.plot = [];

    coordinator.Parts = {part1, part2, part3, part4, part5};
    
    visualizeParts(coordinator)
     

   % Trigger Stateflow chart Event
   coordinator.FlowChart.worldBuilt;
end
