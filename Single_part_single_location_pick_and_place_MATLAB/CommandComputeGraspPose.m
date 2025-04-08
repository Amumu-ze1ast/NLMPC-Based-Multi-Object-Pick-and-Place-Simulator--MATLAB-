function CommandComputeGraspPose(coordinator) 


    if coordinator.NextPart == 1
        coordinator.GraspPose = trvec2tform(coordinator.Parts{coordinator.NextPart}.centerPoint + [0 0 0.04])*axang2tform([1 0 0 1.35*pi]);

     end
        % Trigger Stateflow chart Event
        coordinator.FlowChart.nextAction; 
end