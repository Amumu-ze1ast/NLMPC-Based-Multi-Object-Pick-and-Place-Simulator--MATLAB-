function CommandPickingLogic(coordinator)

        coordinator.NextPart = coordinator.NextPart + 1; 
        if coordinator.NextPart<=length(coordinator.Parts)               
            % Objects are placed on either belt1, belt2, belt3 or belt4 according to
            % their type
            if coordinator.DetectedParts{coordinator.NextPart}.type == 1
                coordinator.DetectedParts{coordinator.NextPart}.placingBelt = 1;                    
            
            elseif coordinator.DetectedParts{coordinator.NextPart}.type == 2
                coordinator.DetectedParts{coordinator.NextPart}.placingBelt = 2;
            
            elseif coordinator.DetectedParts{coordinator.NextPart}.type == 3
                coordinator.DetectedParts{coordinator.NextPart}.placingBelt = 3;
            
            else
                coordinator.DetectedParts{coordinator.NextPart}.placingBelt = 4;
            end
            % Trigger Stateflow chart Event
            coordinator.FlowChart.partsDetected;
            return;
        end

        % Trigger Stateflow chart Event
        coordinator.FlowChart.noPartsDetected;

end