function stateDot = TimeBasedStateInputsPickPlace(obj, timeInterval, jointStates, t, state)

    targetState = interp1(timeInterval, jointStates, t);
    
    % Compute state derivative
    stateDot = derivative(obj, state, targetState);
end
