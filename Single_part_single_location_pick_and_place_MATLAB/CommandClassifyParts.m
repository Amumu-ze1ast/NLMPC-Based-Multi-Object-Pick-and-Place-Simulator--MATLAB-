function CommandClassifyParts(coordinator)

    if ~isempty(coordinator.DetectedParts)
        coordinator.DetectedParts{1}.type = 1;
    end

   % Trigger Stateflow chart Event
   coordinator.FlowChart.partsClassified;       
end