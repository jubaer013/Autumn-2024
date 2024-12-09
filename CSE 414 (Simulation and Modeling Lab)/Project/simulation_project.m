% Parameters
numPlanets = 8; % Number of planets
planetNames = {'Mercury', 'Venus', 'Earth', 'Mars', 'Jupiter', 'Saturn', 'Uranus', 'Neptune'};
planetColors = {'r', 'g', 'b', 'c', 'm', 'y', [0.5, 0.5, 0.5], 'w'}; % Colors for planets
orbitRadii = [30, 38, 50, 70, 90, 110, 130, 150]; % Orbital radii tripled for larger animation
orbitalPeriods = [88, 225, 365, 687, 4333, 10759, 30687, 60190]; % Orbital periods in Earth days

% Normalize orbital periods for simulation
orbitalPeriods = orbitalPeriods / max(orbitalPeriods);

% Scaling factor for slowing down the orbital speed
speedFactor = 1000; % Slowed down 1000x
orbitalPeriods = orbitalPeriods * speedFactor;

% Set up figure
figure('Color', 'k'); % Black background
hold on;
axis equal;
axis([-150 150 -150 150 -10 10]); % Axis limits increased for larger orbits
grid off; % Disable grid
set(gca, 'Color', 'k', 'XColor', 'none', 'YColor', 'none', 'ZColor', 'none'); % Hide axes

% Title and Labels
title('Simulated Solar System', 'Color', 'w', 'FontSize', 16);

% Draw Sun
plot3(0, 0, 0, 'yo', 'MarkerSize', 25, 'MarkerFaceColor', 'yellow'); % Sun

% Create orbits
theta = linspace(0, 2*pi, 360);
for i = 1:numPlanets
    % Orbit in XY-plane
    plot3(orbitRadii(i)*cos(theta), orbitRadii(i)*sin(theta), zeros(size(theta)), ...
          '-', 'Color', 'w'); % White orbit lines
end

% Initialize planets
planetHandles = gobjects(1, numPlanets);
planetSizes = [6, 7, 8, 8, 12, 10, 9, 8] * 2; % Planet sizes doubled for better visibility
labelHandles = gobjects(1, numPlanets); % For planet name labels
for i = 1:numPlanets
    % Create planets
    planetHandles(i) = plot3(orbitRadii(i), 0, 0, 'o', ...
                             'MarkerSize', planetSizes(i), ...
                             'MarkerFaceColor', planetColors{i}, ...
                             'Color', planetColors{i});
    % Add labels for planets
    labelHandles(i) = text(orbitRadii(i) + 2, 0, 0, planetNames{i}, ...
                           'Color', 'w', 'FontSize', 8);
end

% Simulation parameters
simulationTime = 20; % Duration in seconds
fps = 30; % Frames per second
dt = 1 / fps; % Time step
totalFrames = simulationTime * fps;

% Set a 3D view angle
view([-30 30]); % Adjust for a tilted top-down perspective

% Simulation loop
for frame = 1:totalFrames
    for i = 1:numPlanets
        % Calculate the angular position of the planet
        angle = 2 * pi * frame / (orbitalPeriods(i) * fps);
        
        % Update planet position in 3D space
        x = orbitRadii(i) * cos(angle);
        y = orbitRadii(i) * sin(angle);
        z = 0.2 * sin(angle / 2); % Subtle vertical oscillation for 3D effect
        set(planetHandles(i), 'XData', x, 'YData', y, 'ZData', z);
        
        % Update planet label position
        set(labelHandles(i), 'Position', [x + 2, y + 2, z]);
    end
    
    pause(dt); % Control animation speed
end