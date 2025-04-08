classdef CoordinatorPickPlace < handle

    properties         
        FlowChart
        Robot
        World = {};
        Parts = {};
        Obstacles = {};
        DetectedParts = {};
        RobotEndEffector
        CurrentRobotJConfig
        CurrentRobotTaskConfig
        NextPart = 0;
        PartOnRobot = 0;
        HomeRobotTaskConfig 
        PlacingPose
        GraspPose
        Figure
        TimeStep
        MotionModel
        NumJoints
        NumDetectionRuns = 0;
        PathHandle
    end
    
    methods
        function obj = CoordinatorPickPlace(robot, currentRobotJConfig, robotEndEffector)
            obj.Robot = robot;            
            obj.CurrentRobotJConfig = currentRobotJConfig;
            obj.RobotEndEffector = robotEndEffector;
            obj.CurrentRobotTaskConfig = getTransform(obj.Robot, obj.CurrentRobotJConfig, obj.RobotEndEffector);
            obj.TimeStep = 0.1; % Visualization time step
            obj.MotionModel = jointSpaceMotionModel('RigidBodyTree', obj.Robot);
            obj.NumJoints = numel(obj.CurrentRobotJConfig);
                    
            % Initialize visualization
            obj.Figure = interactiveRigidBodyTree(obj.Robot,'ShowMarker',false, 'Frames', 'off'); 
            obj.Figure.Configuration = obj.CurrentRobotJConfig;
            obj.Figure.ShowMarker = false;
            hold on
            axis([-1 1 -1 1 -0.1 1.5]);
            view(58,25);            
        end
 
        
        function visualizeRobot(obj, robotStates, trajTimes)
            % Visualize robot motion           
            for k = 1:length(trajTimes)
                configNow = robotStates(k,1:obj.NumJoints);
                obj.Figure.Configuration = configNow;
                obj.Figure.ShowMarker = false;
                % Update current robot configuration
                obj.CurrentRobotJConfig = configNow;
                obj.CurrentRobotTaskConfig = getTransform(obj.Robot, obj.CurrentRobotJConfig, obj.RobotEndEffector);
                % Visualize parts
                if obj.PartOnRobot~=0
                    obj.Parts{obj.PartOnRobot}.mesh.Pose = obj.CurrentRobotTaskConfig * trvec2tform([0 0 0.04]);
                    obj.Parts{obj.PartOnRobot}.plotHandle.Matrix = obj.Parts{obj.PartOnRobot}.mesh.Pose;
                end
                drawnow;
                pause(0.05);
            end
        end
    
        function visualizeWorld(obj)
            try
             
             % Render ground
             ground = obj.World{1};
             [~, p1] = show(ground);

             % Render shelf
             p1.FaceColor = [1 1 1];
             p1.FaceAlpha = 1.0;
             p1.LineStyle = 'none';
        
            % Render floor2
            fv = stlread('2floor2.stl');
            floor2B = trisurf(fv,'FaceColor','w', ...
                     'EdgeColor',       'none',        ...
                     'FaceLighting',    'gouraud',     ...
                     'AmbientStrength', 0.15);
            floor2 = hgtransform;
            floor2B.Parent = floor2;
            floor2.Matrix = trvec2tform([-1 -1 -0.03]);       
            
            % Render trashcan
            fv = stlread('3trashcan.stl');
            trashcanB = trisurf(fv,'FaceColor','[0.8 0.8 1.0]', ...
                     'EdgeColor',       'none',        ...
                     'FaceLighting',    'gouraud',     ...
                     'AmbientStrength', 0.15);
            trashcan = hgtransform;
            trashcanB.Parent = trashcan;
            trashcan.Matrix = trvec2tform([-0.07 -0.9 -0.03]);
            
            % Render table
            fv = stlread('4table_2.stl');
            tableB = trisurf(fv,'FaceColor','[0.75 0.8 1.0]', ...
                     'EdgeColor',       'none',        ...
                     'FaceLighting',    'gouraud',     ...
                     'AmbientStrength', 0.15);
            table = hgtransform;
            tableB.Parent = table;
            table.Matrix = trvec2tform([0.25 0.33 -0.025]);
            
            % Render robotarm clamper
            fv = stlread('5robotarm_clamper.stl');
            robotarm_clamperB = trisurf(fv,'FaceColor','[0.8 0.8 1.0]', ...
                     'EdgeColor',       'none',        ...
                     'FaceLighting',    'gouraud',     ...
                     'AmbientStrength', 0.15);
            robotarm_clamper = hgtransform;
            robotarm_clamperB.Parent = robotarm_clamper;
            robotarm_clamper.Matrix = trvec2tform([-0.125 -0.125 -0.025]);
            
            drawnow;
           catch
           end
        end
        
        
        % Visualize obstacles
        function visualizeObstacles(obj)
            for i=1:numel(obj.Obstacles)
                [~, obs] = show(obj.Obstacles{i});
                obs.LineStyle = 'none';
                obs.FaceColor = '0.9 0.41 0.17';
            end
            drawnow;
        end


        function visualizeParts(obj)
            for i = 1:length(obj.Parts)
                tempPose = [0,0,0]; % to set transformation reference
                correctPose = obj.Parts{i}.mesh.Pose;
                obj.Parts{i}.mesh.Pose = trvec2tform(tempPose);
                [~, obj.Parts{i}.plot] = show(obj.Parts{i}.mesh);
                obj.Parts{i}.plot.LineStyle = 'none'; 
                obj.Parts{i}.plotHandle = hgtransform;
                obj.Parts{i}.plot.Parent = obj.Parts{i}.plotHandle;
                obj.Parts{i}.mesh.Pose = correctPose;
                obj.Parts{i}.plotHandle.Matrix = obj.Parts{i}.mesh.Pose;
                obj.Parts{i}.plot.FaceColor = obj.Parts{i}.color; 
            end
            drawnow;
        end
        
        
        function visualizePath(obj, positions)
            poses = zeros(size(positions,2),3);
            for i=1:size(positions,2)               
                poseNow = getTransform(obj.Robot, positions(:,i)', obj.RobotEndEffector);
                poses(i,:) = [poseNow(1,4), poseNow(2,4), poseNow(3,4)];
            end
            obj.PathHandle = plot3(poses(:,1), poses(:,2), poses(:,3),'k--','LineWidth',1.5);            
            drawnow;
        end
        
        % Display current job state
        function displayState(obj, message)
            disp(message);
        end
        
        % Delete function
        function delete(obj)
            delete(obj.FlowChart)
        end
            
    end
  
end

