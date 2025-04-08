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

    coordinator.Obstacles = {}; 

    visualizeObstacles(coordinator)
    
    % Construct parts
    sphere = collisionSphere(0.03);

    TSphere = trvec2tform([0.5 0.6 0.01]);


    sphere.Pose = TSphere;

    % Set the part mesh
    part1.mesh = sphere;

    % Set the part color
    part1.color = 'w';

    part1.centerPoint = tform2trvec(part1.mesh.Pose);
    part1.plot = [];
    coordinator.Parts = {part1};
    
    visualizeParts(coordinator)

   % Trigger Stateflow chart Event
   coordinator.FlowChart.worldBuilt;
end
