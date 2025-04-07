function CommandMoveToTaskConfig(coordinator, taskConfig, tolerance, avoidCollisions)



        % Execute closed-loop trajectory optimization and control using
        % model predictive control
        mpcTimeStep = 0.55;
        [positions, velocities, accelerations, timestamp, success] = PlanExecuteTrajectoryPickPlace(coordinator.Robot, mpcTimeStep,  coordinator.Obstacles, coordinator.RobotEndEffector, coordinator.CurrentRobotJConfig, taskConfig, tolerance, avoidCollisions);
        if success==0
            error('Cannot compute motion to reach desired task configuration. Aborting...')
        end
        
        %% Execute the trajectory using low-fidelity simulation
        targetStates = [positions;velocities;accelerations]'; 
        targetTime = timestamp;
        initState = [positions(:,1);velocities(:,1)]';
        trajTimes = targetTime(1):coordinator.TimeStep:targetTime(end);

        [~,robotStates] = ode15s(@(t,state) TimeBasedStateInputsPickPlace(coordinator.MotionModel, targetTime, targetStates, t, state), trajTimes, initState);

        %% Visualize trajectory
        visualizePath(coordinator,positions);
        visualizeRobot(coordinator, robotStates, trajTimes);
        
        % Deleta path on plot
        coordinator.PathHandle.Visible = 'off';

        % Update current robot configuration
        coordinator.CurrentRobotJConfig = positions(:,end)';
        coordinator.CurrentRobotTaskConfig = getTransform(coordinator.Robot, coordinator.CurrentRobotJConfig, coordinator.RobotEndEffector); 

        % Trigger Stateflow chart Event
        coordinator.FlowChart.taskConfigReached; 
end