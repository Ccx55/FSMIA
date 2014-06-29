function result = analyzeDiffusion(trajall,Molecule,Option)
% Calculate diffusion coefficient
% Input
%   TRAJALL - trajectory results from previous image analysis
% Output
%   RESULT.X - (r^2/4\delta t) in ascending order
%   RESULT.Y - Cumulative distribution function

opt = struct;
opt.n = 4;

allSteps = [];
for i = 1:length(trajall)
    traj = trajall(i).trajectory;
    steps = computestep(traj,Molecule,Option,opt);
    allSteps = vertcat(allSteps,steps);
end

% ocnvert to r^2/8dt (um^2/s)
allSteps = (allSteps*1e-3).^2/(4*Option.ExposureTime*1e-3*opt.n);
allStepsAscend = sort(allSteps);

% number of observed displacements
M = length(allStepsAscend);
% cumulative distribution distribution
% use Schwartz's definition, it's actually 1-c.d.f.
cdf = 1 - (1:M)/M;

% plot(allStepsAscend,cdf)

result = struct;
result.x = allStepsAscend;
result.y = cdf;