function CommandDetectParts(coordinator)
            
        if ~isempty(coordinator.Parts) && coordinator.NextPart<=length(coordinator.Parts)
            coordinator.DetectedParts = coordinator.Parts;
            % Trigger event 'partDetected' on Stateflow
            coordinator.FlowChart.partsDetected;
            return;
        end
        coordinator.NumDetectionRuns = coordinator.NumDetectionRuns +1;

        % Trigger Stateflow chart Event
        coordinator.FlowChart.noPartsDetected; 
   
end