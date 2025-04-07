function CommandClassifyParts(coordinator)

    if ~isempty(coordinator.DetectedParts)
        coordinator.DetectedParts{1}.type = 3;
        coordinator.DetectedParts{2}.type = 1;
        coordinator.DetectedParts{3}.type = 2;
        coordinator.DetectedParts{4}.type = 4;
        coordinator.DetectedParts{5}.type = 3;
    end

   % Trigger Stateflow chart Event
   coordinator.FlowChart.partsClassified;       
end