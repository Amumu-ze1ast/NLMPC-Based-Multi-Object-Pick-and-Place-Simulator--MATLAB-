function CommandActivateGripper(coordinator, state)

       if strcmp(state,'on') == 1
           % Activate gripper 
           coordinator.PartOnRobot = coordinator.NextPart;
           % Add new picked part in collision checking
           partBody = getBody(coordinator.Robot,'pickedPart');
           addCollision(partBody,"sphere", 0.12 , trvec2tform([0 0 0]));
       else
           % Deactivate gripper 
           coordinator.PartOnRobot = 0;
           % Remove dropped part from collision checking
           partBody = getBody(coordinator.Robot,'pickedPart');
           clearCollision(partBody);
       end
       
       % Trigger Stateflow chart Event
       coordinator.FlowChart.nextAction; 
end