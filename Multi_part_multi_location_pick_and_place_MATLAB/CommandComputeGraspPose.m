function CommandComputeGraspPose(coordinator) 


    if coordinator.NextPart == 1
        coordinator.GraspPose = trvec2tform(coordinator.Parts{coordinator.NextPart}.centerPoint + [0 0 0.04])*axang2tform([0 1 0 pi]);
    
    elseif coordinator.NextPart == 2
        coordinator.GraspPose = trvec2tform(coordinator.Parts{coordinator.NextPart}.centerPoint + [0 0 0.04])*axang2tform([1 0 0 3*pi/4]);
    
    elseif coordinator.NextPart == 3
        coordinator.GraspPose = trvec2tform(coordinator.Parts{coordinator.NextPart}.centerPoint + [0 0 0.04])*axang2tform([0 1 0 pi]);
    
    elseif coordinator.NextPart == 4
        coordinator.GraspPose = trvec2tform(coordinator.Parts{coordinator.NextPart}.centerPoint + [0 0 0.04])*axang2tform([0 1 0 pi]);
     
    else
        coordinator.GraspPose = trvec2tform(coordinator.Parts{coordinator.NextPart}.centerPoint + [0 0.04 0])*axang2tform([1 0 0 pi/2]);
          
     
     end
        % Trigger Stateflow chart Event
        coordinator.FlowChart.nextAction; 
end